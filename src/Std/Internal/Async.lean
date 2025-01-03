/-
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Henrik Böving
-/
prelude
import Std.Time
import Std.Internal.UV


namespace Std
namespace Internal
namespace IO
namespace Async

/--
A `Task` that may resolve to a value or an `IO.Error`.
-/
def AsyncTask (α : Type u) : Type u := Task (Except IO.Error α)

namespace AsyncTask

@[inline]
protected def pure (x : α) : AsyncTask α := Task.pure <| .ok x

instance : Pure AsyncTask where
  pure := AsyncTask.pure

@[inline]
protected def bind (x : AsyncTask α) (f : α → AsyncTask β) : AsyncTask β :=
  Task.bind x fun r =>
    match r with
    | .ok a => f a
    | .error e => Task.pure <| .error e

-- TODO: variants with explicit error handling

@[inline]
def bindIO (x : AsyncTask α) (f : α → IO (AsyncTask β)) : BaseIO (AsyncTask β) :=
  IO.bindTask x fun r =>
    match r with
    | .ok a => f a
    | .error e => .error e

@[inline]
def mapIO (f : α → β) (x : AsyncTask α) : BaseIO (AsyncTask β) :=
  IO.mapTask (t := x) fun r =>
    match r with
    | .ok a => pure (f a)
    | .error e => .error e

/--
Run the `AsyncTask` in `x` and block until it finishes.
-/
def spawnBlocking (x : IO (AsyncTask α)) : IO α := do
  let t ← x
  let res := t.get
  match res with
  | .ok a => return a
  | .error e => .error e

@[inline]
def spawn (x : IO α) : BaseIO (AsyncTask α) := do
  IO.asTask x

@[inline]
def ofPromise (x : IO.Promise α) : AsyncTask α :=
  x.result.map pure

@[inline]
def getState (x : AsyncTask α) : BaseIO IO.TaskState :=
  IO.getTaskState x

end AsyncTask

/--
`Sleep` can be used to sleep for some duration once.
The underlying timer has millisecond resolution.
-/
structure Sleep where
  private ofNative ::
    native : Internal.UV.Timer

namespace Sleep

/--
Set up a `Sleep` that waits for `duration` milliseconds.
This function only initializes but does not yet start the timer.
-/
@[inline]
def mk (duration : Std.Time.Millisecond.Offset) : IO Sleep := do
  let native ← Internal.UV.Timer.mk duration.toInt.toNat.toUInt64 false
  return ofNative native

/--
If:
- `s` is not yet running start it and return an `AsyncTask` that will resolve once the previously
   configured `duration` has run out.
- `s` is already or not anymore running return the same `AsyncTask` as the first call to `wait`.
-/
@[inline]
def wait (s : Sleep) : IO (AsyncTask Unit) := do
  let promise ← s.native.next
  return .ofPromise promise

/--
If:
- `s` is still running this will delay the resolution of `AsyncTask`s created with `wait` by
  `duration` milliseconds.
- `s` is not yet or not anymore running this is a no-op.
-/
@[inline]
def reset (s : Sleep) : IO Unit :=
  s.native.reset

/--
If:
- `s` is still running this stops `s` without resolving any remaing `AsyncTask` that were created
  through `wait`. Note that if another `AsyncTask` is binding on any of these it is going hang
  forever without further intervention.
- `s` is not yet or not anymore running this is a no-op.
-/
@[inline]
def stop (s : Sleep) : IO Unit :=
  s.native.stop

end Sleep

/--
Return an `AsyncTask` that resolves after `duration`.
-/
def sleep (duration : Std.Time.Millisecond.Offset) : IO (AsyncTask Unit) := do
  let sleeper ← Sleep.mk duration
  sleeper.wait

/--
`Interval` can be used to repeatedly wait for some duration like a clock.
The underlying timer has millisecond resolution.
-/
structure Interval where
  private ofNative ::
    native : Internal.UV.Timer


namespace Interval

/--
Setup up an `Interval` that waits for `duration` milliseconds.
This function only initializes but does not yet start the timer.
-/
@[inline]
def mk (duration : Std.Time.Millisecond.Offset) : IO Interval := do
  let native ← Internal.UV.Timer.mk duration.toInt.toNat.toUInt64 true
  return ofNative native

/--
If:
- `i` is not yet running start it and return an `AsyncTask` that resolves right away as the 0th
  multiple of `duration` has elapsed.
- `i` is already running and:
  - the tick from the last call of `i` has not yet finished return the same `AsyncTask` as the last
    call
  - the tick frrom the last call of `i` has finished return a new `AsyncTask` that waits for the
    closest next tick from the time of calling this function.
- `i` is not running aymore this is a no-op.
-/
@[inline]
def tick (i : Interval) : IO (AsyncTask Unit) := do
  let promise ← i.native.next
  return .ofPromise promise

/--
If:
- `Interval.tick` was called on `i` before the timer restarts counting from now and the next tick
   happens in `duration`.
- `i` is not yet or not anymore running this is a no-op.
-/
@[inline]
def reset (i : Interval) : IO Unit :=
  i.native.reset

/--
If:
- `i` is still running this stops `i` without resolving any remaing `AsyncTask` that were created
  through `tick`. Note that if another `AsyncTask` is binding on any of these it is going hang
  forever without further intervention.
- `i` is not yet or not anymore running this is a no-op.
-/
@[inline]
def stop (i : Interval) : IO Unit :=
  i.native.stop

end Interval

end Async
end IO
end Internal
end Std

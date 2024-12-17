-- Adapted from Henrik Boving async_slee.lean test

import Std.Internal.UV
open Std.Internal.UV

def assertElapsed (t1 t2 : Nat) (should : Nat) (eps : Nat) : IO Unit := do
  let dur := t2 - t1
  if (Int.ofNat dur - Int.ofNat should).natAbs > eps then
    throw <| .userError s!"elapsed time was too different, measured {dur}, should: {should}, tolerance: {eps}"

def assertDuration (should : Nat) (eps : Nat) (x : IO α) : IO α := do
  let t1 ← IO.monoMsNow
  let res ← x
  let t2 ← IO.monoMsNow
  assertElapsed t1 t2 should eps
  return res

-- generous tolerance for slow CI systems
def EPS : Nat := 4

def await (x : Task α) : IO α := pure x.get

namespace SleepTest

def oneShotSleep : IO Unit := do
  assertDuration 20 EPS do
    let timer ← Timer.mk 20 false
    let p ← timer.next
    await p.result

def promiseBehavior1 : IO Unit := do
    let timer ← Timer.mk 20 false
    let p ← timer.next
    let r := p.result
    assert! (← IO.getTaskState r) != .finished
    IO.sleep (20 + EPS).toUInt32
    assert! (← IO.getTaskState r) == .finished

def promiseBehavior2 : IO Unit := do
  let timer ← Timer.mk 20 false
  let p1 ← timer.next
  let p2 ← timer.next
  assert! (← IO.getTaskState p1.result) != .finished
  assert! (← IO.getTaskState p2.result) != .finished
  IO.sleep (20 + EPS).toUInt32
  assert! (← IO.getTaskState p1.result) == .finished
  assert! (← IO.getTaskState p2.result) == .finished

def promiseBehavior3 : IO Unit := do
  let timer ← Timer.mk 20 false
  let p1 ← timer.next
  assert! (← IO.getTaskState p1.result) != .finished
  IO.sleep (20 + EPS).toUInt32
  assert! (← IO.getTaskState p1.result) == .finished
  let p3 ← timer.next
  assert! (← IO.getTaskState p3.result) == .finished

def resetBehavior : IO Unit := do
  let timer ← Timer.mk 20 false
  let p ← timer.next
  assert! (← IO.getTaskState p.result) != .finished

  IO.sleep 10
  assert! (← IO.getTaskState p.result) != .finished
  timer.reset

  IO.sleep 10
  assert! (← IO.getTaskState p.result) != .finished

  IO.sleep (10 + EPS).toUInt32
  assert! (← IO.getTaskState p.result) == .finished

#eval oneShotSleep
#eval promiseBehavior1
#eval promiseBehavior2
#eval promiseBehavior3
#eval resetBehavior
#eval oneShotSleep

end SleepTest

namespace IntervalTest

def sleepFirst : IO Unit := do
  assertDuration 0 EPS go
where
  go : IO Unit := do
    let timer ← Timer.mk 20 true
    let prom ← timer.next
    await prom.result

def sleepSecond : IO Unit := do
  discard <| assertDuration 20 EPS go
where
  go : IO _ := do
    let timer ← Timer.mk 20 true

    let task ←
      IO.bindTask (← timer.next).result fun _ => do
      IO.bindTask (← timer.next).result fun _ => pure (Task.pure (.ok 2))

    await task

def promiseBehavior1 : IO Unit := do
  let timer ← Timer.mk 20 true
  let p1 ← timer.next
  IO.sleep EPS.toUInt32
  assert! (← IO.getTaskState p1.result) == .finished
  let p2 ← timer.next
  assert! (← IO.getTaskState p2.result) != .finished
  IO.sleep (20 + EPS).toUInt32
  assert! (← IO.getTaskState p2.result) == .finished

def promiseBehavior2 : IO Unit := do
  let timer ← Timer.mk 20 true
  let p1 ← timer.next
  IO.sleep EPS.toUInt32
  assert! (← IO.getTaskState p1.result) == .finished

  let prom1 ← timer.next
  let prom2 ← timer.next
  assert! (← IO.getTaskState prom1.result) != .finished
  assert! (← IO.getTaskState prom2.result) != .finished
  IO.sleep (20 + EPS).toUInt32
  assert! (← IO.getTaskState prom1.result) == .finished
  assert! (← IO.getTaskState prom2.result) == .finished

def promiseBehavior3 : IO Unit := do
  let timer ← Timer.mk 20 true
  let p1 ← timer.next
  IO.sleep EPS.toUInt32
  assert! (← IO.getTaskState p1.result) == .finished

  let prom1 ← timer.next
  assert! (← IO.getTaskState prom1.result) != .finished
  IO.sleep (20 + EPS).toUInt32
  assert! (← IO.getTaskState prom1.result) == .finished
  let prom2 ← timer.next
  assert! (← IO.getTaskState prom2.result) != .finished
  IO.sleep (20 + EPS).toUInt32
  assert! (← IO.getTaskState prom2.result) == .finished

def delayedTickBehavior : IO Unit := do
  let timer ← Timer.mk 20 true
  let p1 ← timer.next
  IO.sleep EPS.toUInt32
  assert! (← IO.getTaskState p1.result) == .finished

  IO.sleep 10
  let p2 ← timer.next
  assert! (← IO.getTaskState p2.result) != .finished
  IO.sleep (10 + EPS).toUInt32
  assert! (← IO.getTaskState p2.result) == .finished

def skippedTickBehavior : IO Unit := do
  let timer ← Timer.mk 20 true
  let p1 ← timer.next
  IO.sleep EPS.toUInt32
  assert! (← IO.getTaskState p1.result) == .finished

  IO.sleep 30
  let p2 ← timer.next
  assert! (← IO.getTaskState p2.result) != .finished
  IO.sleep (10 + EPS).toUInt32
  assert! (← IO.getTaskState p2.result) == .finished

def resetBehavior : IO Unit := do
  let timer ← Timer.mk 20 true
  let p1 ← timer.next
  IO.sleep EPS.toUInt32
  assert! (← IO.getTaskState p1.result) == .finished

  let prom ← timer.next
  assert! (← IO.getTaskState prom.result) != .finished

  IO.sleep 10
  assert! (← IO.getTaskState prom.result) != .finished
  timer.reset

  IO.sleep 10
  assert! (← IO.getTaskState prom.result) != .finished

  IO.sleep (10 + EPS).toUInt32
  assert! (← IO.getTaskState prom.result) == .finished

def sequentialSleep : IO Unit := do
  discard <| assertDuration 20 EPS go
where
  go : IO _ := do
    let timer ← Timer.mk 10 true
    -- 0th interval ticks instantly
    let task ←
      IO.bindTask (← timer.next).result fun _ => do
      IO.bindTask (← timer.next).result fun _ => do
      IO.bindTask (← timer.next).result fun _ => pure (Task.pure (.ok 2))

    await task

#eval sleepFirst
#eval sleepSecond
#eval promiseBehavior1
#eval promiseBehavior2
#eval promiseBehavior3
#eval delayedTickBehavior
#eval skippedTickBehavior
#eval resetBehavior
#eval sequentialSleep

end IntervalTest

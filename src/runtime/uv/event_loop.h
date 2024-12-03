/*
Copyright (c) 2024 Lean FRO, LLC. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

Author: Sofia Rodrigues
*/
#pragma once
#include <lean/lean.h>
#include "runtime/debug.h"
#include "runtime/alloc.h"
#include "runtime/io.h"
#include "runtime/utf8.h"
#include "runtime/object.h"
#include "runtime/thread.h"
#include "runtime/allocprof.h"
#include "runtime/object.h"

namespace lean {

void initialize_libuv_loop();

#ifndef LEAN_EMSCRIPTEN
using namespace std;
#include <uv.h>

// Event loop structure for managing asynchronous events and synchronization across multiple threads.
typedef struct {
    uv_loop_t  * loop;      // The libuv event loop.
    uv_mutex_t   mutex;     // Mutex for protecting shared resources.
    uv_cond_t    cond_var;  // Condition variable for thread synchronization.
    uv_async_t   async;     // Async handle to notify the main event loop.
    _Atomic(int) n_waiters; // Atomic counter for managing waiters.
} event_loop_t;

// The multithreaded event loop object for all tasks in the task manager.
extern event_loop_t global_ev;

// =======================================
// Event loop manipulation functions.
void event_loop_init(event_loop_t *event_loop);
void event_loop_cleanup(event_loop_t *event_loop);
void event_loop_lock(event_loop_t *event_loop);
void event_loop_unlock(event_loop_t *event_loop);
void event_loop_wake(event_loop_t *event_loop);
void event_loop_run_loop(event_loop_t *event_loop);

#endif

// =======================================
// Global event loop manipulation functions
extern "C" LEAN_EXPORT lean_obj_res lean_uv_event_loop_configure(b_obj_arg options, obj_arg /* w */ );
extern "C" LEAN_EXPORT lean_obj_res lean_uv_event_loop_alive(obj_arg /* w */ );

}

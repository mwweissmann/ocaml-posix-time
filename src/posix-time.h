#ifndef OCAML_POSIX_TIME
#define OCAML_POSIX_TIME
/*
Copyright (c) 2015 - 2016 Markus W. Weissmann <markus.weissmann@in.tum.de>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#include <time.h>
#include <caml/mlvalues.h>

/* Conversion functions to and from data types of Posix_time:
  From OCaml to C (NAME_val) and from C to OCaml (val_NAME). */
static inline struct timespec timespec_val(value v);
static inline struct timeval timeval_val(value v);
static inline struct tm tm_val(value v);
static inline value val_timespec(struct timespec t);
static inline value val_timeval(struct timeval t);
static inline value val_tm(struct tm t);
#ifndef __APPLE__
static inline struct itimerspec itimerspec_val(value v);
static inline value val_itimerspec(struct itimerspec itimer);
#endif

static inline struct timespec timespec_val(value v) {
  return (struct timespec){
    .tv_sec = Int64_val(Field(v, 0)),
    .tv_nsec = Int64_val(Field(v, 1))
  };
}

CAMLprim static inline value val_timespec(struct timespec t) {
  CAMLparam0();
  CAMLlocal1(tuple);
  tuple = caml_alloc(2, 0);
  Store_field(tuple, 0, caml_copy_int64(t.tv_sec));
  Store_field(tuple, 1, caml_copy_int64(t.tv_nsec));
  CAMLreturn(tuple);
}

static inline struct timeval timeval_val(value v) {
  return (struct timeval){
    .tv_sec = Int64_val(Field(v, 0)),
    .tv_usec = Int64_val(Field(v, 1))
  };
}

CAMLprim static inline value val_timeval(struct timeval t) {
  CAMLparam0();
  CAMLlocal1(tuple);
  tuple = caml_alloc(2, 0);
  Store_field(tuple, 0, caml_copy_int64(t.tv_sec));
  Store_field(tuple, 1, caml_copy_int64(t.tv_usec));
  CAMLreturn(tuple);
}

static inline struct tm tm_val(value v) {
  return (struct tm){
    .tm_sec = Int_val(Field(v, 0)), 
    .tm_min = Int_val(Field(v, 1)),
    .tm_hour = Int_val(Field(v, 2)),
    .tm_mday = Int_val(Field(v, 3)),
    .tm_mon = Int_val(Field(v, 4)),
    .tm_year = Int_val(Field(v, 5)),
    .tm_wday = Int_val(Field(v, 6)),
    .tm_yday = Int_val(Field(v, 7)),
    .tm_isdst = Int_val(Field(v, 8))
  };
}

CAMLprim static inline value val_tm(struct tm t) {
  CAMLparam0();
  CAMLlocal1(tuple);
  tuple = caml_alloc(9, 0);
  Store_field(tuple, 0, Val_int(t.tm_sec));
  Store_field(tuple, 1, Val_int(t.tm_min));
  Store_field(tuple, 2, Val_int(t.tm_hour));
  Store_field(tuple, 3, Val_int(t.tm_mday));
  Store_field(tuple, 4, Val_int(t.tm_mon));
  Store_field(tuple, 5, Val_int(t.tm_year));
  Store_field(tuple, 6, Val_int(t.tm_wday));
  Store_field(tuple, 7, Val_int(t.tm_yday));
  Store_field(tuple, 8, Val_int(t.tm_isdst));
  CAMLreturn(tuple);
}

#ifndef __APPLE__
static inline struct itimerspec itimerspec_val(value v) {
  return (struct itimerspec) {
    .it_interval = timespec_val(Field(v, 0)),
    .it_value = timespec_val(Field(v, 1))
  };
}

CAMLprim static inline value val_itimerspec(struct itimerspec itimer) {
  CAMLparam0();
  CAMLlocal1(tuple);
  tuple = caml_alloc(2, 0);
  Store_field(tuple, 0, val_timespec(itimer.it_interval));
  Store_field(tuple, 1, val_timespec(itimer.it_value));
  CAMLreturn(tuple);
}
#endif

#endif


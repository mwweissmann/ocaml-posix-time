#ifndef OCAML_POSIX_TIME
#define OCAML_POSIX_TIME

#include <time.h>
#include <caml/mlvalues.h>

#define timespec_of_time_value(t) ((struct timespec){.tv_sec=Int64_val(Field(t,0)),.tv_nsec=Int64_val(Field(time,1))})
#define timeval_of_time_value(t) ((struct timeval){.tv_sec=Int64_val(Field(t,0)),.tv_nsec=Int64_val(Field(time,1))})

#endif

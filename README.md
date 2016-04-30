# OCaml POSIX time

This OCaml library provides POSIX time data structures and basic functions to operate on them. This library is meant to be as an interface for modules using POSIX time data structures. For this purpose it also features a C header file posix-time.h with conversion functions to and from the provided data types.

posix-time provides OCaml version of the following POSIX C structs:
```C
struct timespec;
struct timeval;
struct tm;
struct itimerspec;
````

The library and all provided data types and functions are OCaml native implementations.

The full interface can be seen in the [API documentation](http://mwweissmann.github.io/ocaml-posix-time/).

The C interface provides the following functions:

### posix-time.h
```C
static inline struct timespec timespec_val(value v);
static inline value val_timespec(struct timespec t);

static inline struct timeval timeval_val(value v);
static inline value val_timeval(struct timeval t);

static inline struct tm tm_val(value v);
static inline value val_tm(struct tm t);

static inline struct itimerspec itimerspec_val(value v);
static inline value val_itimerspec(struct itimerspec itimer);
```

The source code of time is available under the MIT license.

This library is originally written by [Markus Weissmann](http://www.mweissmann.de/)


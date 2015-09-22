# POSIX time

This library provides POSIX time data structures and basic functions to operate on them.

```ocaml
module Timespec : sig
  type t = private {
    tv_sec : int64; (* seconds *)
    tv_nsec : int64; (* nanoseconds *)
  }
...
end

module Timeval : sig
  type t = private {
    tv_sec : int64; (* seconds *)
    tv_usec : int64; (* microseconds *)
  }
...
end
```

The source code of time is available under the MIT license.

This library is originally written by [Markus Weissmann](http://www.mweissmann.de/)


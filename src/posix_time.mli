(*
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
*)

(** POSIX Time

  @author Markus W. Weissmann
*)

module Timespec : sig
  type t = private {
    tv_sec : int64;
    tv_nsec : int64;
  }
  (** POSIX timespec time specifier with seconds and nanoseconds. A normalized
      value of type [t] must have a value of [tv_nsec] between [0] and
      [1000000000] (exclusive). *)

  val create : int64 -> int64 -> t
  (** [create sec nsec] creates a new normalized timespec with [sec] seconds
      and [nsec] nanoseconds. *)

  val add : t -> t -> t
  (** [add t1 t2] adds the two timespec values, returning a normalized value *)

  val sub : t -> t -> t
  (** [sub t1 t2] subtracts [t2] from [t1], creating a new normalized time
      value. *)

  val add_sec : int64 -> t -> t
  (** [add_sec s t] adds [s] seconds to [t]. *)

  val add_nsec : int64 -> t -> t
  (** [add_sec ns t] adds [ns] nanoseconds to [t]. *)

  val sub_sec : int64 -> t -> t
  (** [sub_sec s t] subtracts [s] seconds from [t]. *)

  val sub_nsec : int64 -> t -> t
  (** [sub_sec ns t] subtracts [ns] nanoseconds from [t]. *)

  val compare : t -> t -> int
  (** [compare t1 t2] compares the two time values [t1] and [t2]. It returns
      [0] if [t1] is equal to [2], a negative integer if [t1] is less than [t2],
      and a positive integer if [t1] is greater than [t2]. *)
end

module Timeval : sig
  type t = private {
    tv_sec : int64;
    tv_usec : int64;
  }
  (** POSIX timeval time value with seconds and microseconds. A normalized
      value of type [t] must have a value of [tv_usec] between [0] and
      [1000000] (exclusive). *)

  val create : int64 -> int64 -> t
  (** [create sec usec] creates a new normalized timespec with [sec] seconds
      and [usec] microseconds. *)

  val add : t -> t -> t
  (** [add t1 t2] adds the two timespec values, returning a normalized value *)

  val sub : t -> t -> t
  (** [sub t1 t2] subtracts [t2] from [t1], creating a new normalized time
      value. *)

  val add_sec : int64 -> t -> t
  (** [add_sec s t] adds [s] seconds to [t]. *)

  val add_usec : int64 -> t -> t
  (** [add_sec us t] adds [us] microseconds to [t]. *)

  val sub_sec : int64 -> t -> t
  (** [sub_sec s t] subtracts [s] seconds from [t]. *)

  val sub_usec : int64 -> t -> t
  (** [sub_sec us t] subtracts [us] microseconds from [t]. *)

  val compare : t -> t -> int
  (** [compare t1 t2] compares the two time values [t1] and [t2]. It returns
      [0] if [t1] is equal to [2], a negative integer if [t1] is less than [t2],
      and a positive integer if [t1] is greater than [t2]. *)
end

module Tm : sig
  type t = private {
    tm_sec : int;
    tm_min : int;
    tm_hour : int;
    tm_mday : int;
    tm_mon : int;
    tm_year : int;
    tm_wday : int;
    tm_yday : int;
    tm_isdst : int;
  }
  (** POSIX tm value with seconds [0,61], minutes [0,59], hours [0,23], day of
    month [0,31], month of year [0,11], years since 1900, day of week [0,6]
    (Sunday = 0), day of year [0,365] and daylight saving flag.
    The daylight saving flag is positive if daylight saving is in effect and 0
    if not. In case this information is not available, it has a negative value.
  *)

  val create : int -> int -> int -> int -> int -> int -> int -> int -> int -> t option
  (** [create tm_sec tm_min tm_hour tm_mday rm_mon tm_year tm_wday tm_yday tm_isdst]
    creates a new time value if the all arguments suffice the aforementioned
    predicates. Otherwise [create] will return [None]. *)

  val compare : t -> t -> int
  (** [compare t1 t2] compares the two time values [t1] and [t2]. It returns
    [0] if [t1] is equal to [2], a negative integer if [t1] is less than [t2],
    and a positive integer if [t1] is greater than [t2].
    [compare] considers tm_year, tm_mon, tm_mday, tm_hour, tm_min, tm_sec in
    the given order. *)
end

module Itimerspec : sig
  type t = {
    it_interval : Timespec.t;
    it_value : Timespec.t;
  }
end


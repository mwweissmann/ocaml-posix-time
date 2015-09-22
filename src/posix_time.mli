(*
Copyright (c) 2015 Markus W. Weissmann <markus.weissmann@in.tum.de>

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

module Itimerspec : sig
  type t = {
    it_interval : Timespec.t;
    it_value : Timespec.t;
  }
end


module Timespec = struct
  type t = {
    tv_sec : int64;
    tv_nsec : int64;
  }

  let max_nsec = Int64.of_float 1e9

  let compare x y =
    match Int64.compare x.tv_sec y.tv_sec with
    | 0 -> Int64.compare x.tv_nsec y.tv_nsec
    | d -> d

  let create sec nsec =
    let rec normalize sec nsec =
      if nsec < Int64.zero then
        normalize (Int64.pred sec) (Int64.add nsec max_nsec)
      else if nsec >= max_nsec then
        normalize (Int64.succ sec) (Int64.sub nsec max_nsec)
      else
        sec, nsec
    in
    let tv_sec, tv_nsec = normalize sec nsec in
    { tv_sec; tv_nsec }

  let add x y =
    create Int64.(add x.tv_sec y.tv_sec) Int64.(add x.tv_nsec y.tv_nsec)

  let sub x y =
    create Int64.(sub x.tv_sec y.tv_sec) Int64.(sub x.tv_nsec y.tv_nsec)

  let add_sec sec t =
    { t with tv_sec = Int64.add t.tv_sec sec }

  let sub_sec sec t =
    { t with tv_sec = Int64.sub t.tv_sec sec }

  let add_nsec nsec t =
    create t.tv_sec (Int64.add t.tv_nsec nsec)

  let sub_nsec nsec t =
    create t.tv_sec (Int64.sub t.tv_nsec nsec)
end

module Timeval = struct
  type t = {
    tv_sec : int64;
    tv_usec : int64;
  }

  let max_usec = Int64.of_float 1e6

  let compare x y =
    match Int64.compare x.tv_sec y.tv_sec with
    | 0 -> Int64.compare x.tv_usec y.tv_usec
    | d -> d

  let create sec usec =
    let rec normalize sec usec =
      if usec < Int64.zero then
        normalize (Int64.pred sec) (Int64.add usec max_usec)
      else if usec >= max_usec then
        normalize (Int64.succ sec) (Int64.sub usec max_usec)
      else
        sec, usec
    in
    let tv_sec, tv_usec = normalize sec usec in
    { tv_sec; tv_usec }

  let add x y =
    create Int64.(add x.tv_sec y.tv_sec) Int64.(add x.tv_usec y.tv_usec)

  let sub x y =
    create Int64.(sub x.tv_sec y.tv_sec) Int64.(sub x.tv_usec y.tv_usec)

  let add_sec sec t =
    { t with tv_sec = Int64.add t.tv_sec sec }

  let sub_sec sec t =
    { t with tv_sec = Int64.sub t.tv_sec sec }

  let add_usec usec t =
    create t.tv_sec (Int64.add t.tv_usec usec)

  let sub_usec usec t =
    create t.tv_sec (Int64.sub t.tv_usec usec)
end

module Tm = struct
  type t = {
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

  let create tm_sec tm_min tm_hour tm_mday tm_mon tm_year tm_wday tm_yday tm_isdst =
    let in_range a b x = (a <= x) && (x <= b) in
    if (in_range 0 61 tm_sec) &&
      (in_range 0 59 tm_min) &&
      (in_range 0 23 tm_hour) &&
      (in_range 0 31 tm_mday) &&
      (in_range 0 11 tm_mon) &&
      (in_range 0 6 tm_wday) &&
      (in_range 0 365 tm_yday) then
      Some { tm_sec; tm_min; tm_hour; tm_mday; tm_mon; tm_year; tm_wday; tm_yday; tm_isdst }
    else None

  let compare x y =
    begin match compare x.tm_year y.tm_year with
    | 0 -> begin match compare x.tm_mon y.tm_mon with
      | 0 -> begin match compare x.tm_mday y.tm_mday with
        | 0 -> begin match compare x.tm_hour y.tm_hour with
          | 0 -> begin match compare x.tm_min y.tm_min with
            | 0 -> compare x.tm_sec y.tm_sec
            | d -> d
            end
          | d -> d
          end
        | d -> d
        end
      | d -> d
      end
    | d -> d
    end
end



module Itimerspec = struct
  type t = {
    it_interval : Timespec.t;
    it_value : Timespec.t;
  }
end


fun is_p1 x = x <> 0 andalso ((x mod 3 = 0) orelse (x mod 5 = 0))

fun sum xs = List.foldl (op +) 0 xs
                                 
val p1 = sum (List.filter is_p1 (List.tabulate (1000, fn x => x)))

(* val f = fn x => x*x *)

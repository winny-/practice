fun digits n = List.rev let
        fun f 0 = nil
          | f n = (n mod 10)::(f (Int.quot (n, 10)))
    in
        f n
    end

fun fact 0 = 1
  | fact n = n * (fact (n-1))

fun digit_factorial n = List.foldl (fn (x, acc) => acc + fact x) 0 (digits n)

fun p34 () = List.filter (fn x => x = digit_factorial x) (List.tabulate (1000000, fn x => x))

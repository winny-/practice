fun digits n = let
    fun f 0 xs = xs
      | f m xs = f (Int.quot (m, 10)) ((m mod 10)::xs)
in
    f n []
end

(* split list into equal lengths, omitting possible middle element *)
fun split xs = let
    val n = Int.quot ((length xs), 2)
    val maybe_drop = (length xs) mod 2
in
    (List.take (xs, n), List.drop (xs, n+maybe_drop))
end

fun is_palindrome n = let
    val (a,b) = split (digits n)
in
    ListPair.all (op =) (a, (List.rev b))
end

fun range (n,m) = List.tabulate(m-n, fn x => x+n)

(* where n < m, find largest palindrome product in [n,m) *)
fun find_largest_palindrome_product (n, m) = let
    fun f largest [] [] = largest
      | f largest (_::xs) [] = f largest xs xs
      | f largest xs (z::zs) = let
          val product = (hd xs) * z
          val largest' = if is_palindrome product andalso product > largest
                         then product
                         else largest
      in
          f largest' xs zs
      end
    val numbers = range (n,m)
in
    f 0 numbers numbers
end


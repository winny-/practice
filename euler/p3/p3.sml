fun td n = let
    fun step n' x xs =
        if n' > 1 then
            if n mod x = 0 then
                step (n' div x) (x+1) (x::xs)
            else
                step n' (x+1) xs
        else
            xs
in
    step n 2 []
end
       
val p3 = hd (td 600851475143);

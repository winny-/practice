fun p2 max pred = let
    fun step a b sum =
        if a >= max then
            sum
        else
            let
                val a' = a + b
                val b' = a
            in
                if pred a' then
                    step a' b' (sum+a')
                else
                    step a' b' sum
            end
in
    step 0 1 0
end

val answer = p2 4000000 (fn x => x mod 2 = 0)


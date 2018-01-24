val kinds = [200, 100, 50, 20, 10, 5, 2, 1]

fun count_change amount = let
    fun f 0 _ = 1
      | f _ [] = 0
      | f m xs = if m < 0
                 then 0
                 else ((f (m - (hd xs)) xs) + (f m (tl xs)))
in
    f amount kinds
end

        
    

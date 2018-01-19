pure function is_p1(n)
  implicit none
  integer, intent(in) :: n
  logical :: is_p1
  is_p1 = n /= 0 .AND. (MODULO(n, 3) == 0 .OR. MODULO(n, 5) == 0)
end function is_p1

program p1
  implicit none

  logical :: is_p1
  integer :: sum = 0
  integer :: i

  do i = 1, 999
     if (is_p1(i)) then
        sum = sum + i
     end if
  end do
  print *, sum
end program p1

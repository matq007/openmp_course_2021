program pi_serial

  implicit none


  integer, parameter::steps=1000000000
  integer i
  double precision dx,x,sum,pi
  
  pi=acos(-1.d0)
  dx=1.d0/dble(steps)
  sum=0.d0

  !$omp parallel private (i, x) shared(dx)
  !$omp do reduction(+: sum)
  do i=1,steps
     x=(dble(i)-.5d0)*dx
     sum=sum+4.d0/(1.d0+x*x)
  enddo
  !$omp end do
  !$omp end parallel

  sum=sum*dx

  print *,sum,abs(pi-sum)/pi

end program pi_serial

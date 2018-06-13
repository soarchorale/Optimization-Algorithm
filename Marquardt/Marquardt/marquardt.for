      module M_L
	  implicit none
        real,parameter::e=0.1 
	end module M_L
	
      real function f(x1,x2) !/Ŀ�꺯��/
	  implicit none 	    
		real x1,x2	
	    f=2*x1**2+x2**2
	    return 
	end function
      
      real function g(x1,x2,lamda) 
	    implicit none 
		real,parameter::e=0.1	    	
	    real x1,x2,lamda
		real dfx1,dfx2,f        
	    
		dfx1=(f(x1+e,x2)-f(x1-e,x2))/(2*e) !/Ŀ�꺯����x1��һ��ƫ��/
          dfx2=(f(x1,x2+e)-f(x1,x2-e))/(2*e) !/Ŀ�꺯����x1��һ��ƫ��/
          g=2*(x1-lamda*dfx1)**2+(x2-lamda*dfx2)**2 
		                                  !/���ڵ�������lamda�ĺ���/
	  return 
	end function
!********************************************************************************
!**********************ţ�ٷ��Ե�������lamda����һά����*************************
!********************************************************************************     
      subroutine gg(x1,x2,lamda,e)  
	    implicit none
	
      	integer k
		real x1,x2,lamda,e
		real dfx1,dfx2,dl,dll,g,f        
	    lamda=0.5  !�Ե�����������ֵ
          k=1
	   do while(.true.)
	     dl=(g(x1,x2,lamda+e)-g(x1,x2,lamda-e))/(2*e)!/�Բ���lamda��һ��ƫ��/
	     dll=(g(x1,x2,lamda+2*e)-2*g(x1,x2,lamda)+g(x1,x2,lamda-2*e))
     $		    /(4*e*e)                             !/�Բ���lamda�����ƫ��/
	     lamda=lamda-dl/dll            !/ţ�ٷ���lamda����һά���������伫ֵ/
		 k=k+1              
		 if(abs(dl/dll).lt.1e-5) exit 
	   end do   
	   return  
	end subroutine
!********************************************************************************
!**********************ʵ���������ȫѡ��Ԫ��˹-Լ����ȥ��***********************
!********************************************************************************
      subroutine BRINV(a,n,l,is,js)
        integer i,j,k,n
	  real a(n,n),is(n),js(n)
        real  t,d,l

        l=1.0
         do k=1,n
           d=0.0
             do i=k,n
	          do j=k,n
	             if(abs(a(i,j)).gt.d) then
		            d=abs(a(i,j))
		            is(k)=i
		            js(k)=j
		         end if
	          end do
	       end do
	      if(d+1.0.eq.1.0)then
	          l=0
	          write(*,"(1x,'err* *not inv')")
              return
	      end if
          do j=1,n
	       t=a(k,j)
	  	   a(k,j)=a(is(k),j)
		   a(is(k),j)=t 
	    end do
	    do i=1,n
	      t=a(i,k)
	      a(i,k)=a(i,js(k))
		  a(i,js(k))=t 
	    end do
	    a(k,k)=1/a(k,k)
	    do j=1,n
		  if(j.ne.k)then
		    a(k,j)=a(k,j)*a(k,k)
		  end if
		end do
	    do i=1,n
	      if(i.ne.k)then
		    do j=1,n
		      if(j.ne.k)then
		        a(i,j)=a(i,j)-a(i,k)*a(k,j)
		      end if
	        end do
		  end if
	    end do
	    do i=1,n
	      if(i.ne.k)then
		    a(i,k)=-a(i,k)*a(k,k)
		  end if
	    end do
	  end do
	  do k=n,1,-1
	    do j=1,n
	      t=a(k,j)
	   	  a(k,j)=a(js(k),j)
		  a(js(k),j)=t
	    end do
	    do i=1,n
	      t=a(i,k)
	      a(i,k)=a(i,is(k))
            a(i,is(k))=t
	    end do
	  end do
	return
      end subroutine
!*******************************************************************
!************������һ��ƫ����������ƫ��������ɭ����*************
!*******************************************************************

	subroutine hessen_matrix(a,n,p,x1,x2,e)
      implicit none

	  integer n
	  dimension a(n,n),p(n)
	  real x1,x2,e
	  real a,p,dfx1,ddfx1,dfx2,ddfx2,dfxy,f

          dfx1=(f(x1+e,x2)-f(x1-e,x2))/(2*e) !/Ŀ�꺯����x1���һ��ƫ��/
	    dfx2=(f(x1,x2+e)-f(x1,x2-e))/(2*e) !/Ŀ�꺯����x2���һ��ƫ��/
		ddfx1=(f(x1+2*e,x2)-2*f(x1,x2)+f(x1-2*e,x2))/(4*e**2)
		                                   !/Ŀ�꺯����x1��Ķ���ƫ��/	
		ddfx2=(f(x1,x2+2*e)-2*f(x1,x2)+f(x1,x2-2*e))/(4*e**2) 
                                             !/Ŀ�꺯����x2��Ķ���ƫ��/
		dfxy=(f(x1+e,x2+e)-f(x1+e,x2-e)-f(x1-e,x2+e)+f(x1-e,x2-e))
     $	  	  /(4*e**2)                    !/Ŀ�꺯���Ķ��׻��ƫ��/
	   
	    p(1)=dfx1
	    p(2)=dfx2
		a(1,1)=ddfx1
	    a(1,2)=dfxy
	    a(2,1)=dfxy
	    a(2,2)=ddfx2

	end subroutine  hessen_matrix

!*******************************************************************
!***************  marquardt_Levenberg������  ***********************
!*******************************************************************	 
	program marquardt_Levenberg
        use M_L
        implicit none

    	    integer,parameter::n=2
		integer i,j,k
	    real s,f1,f2,f3,f,g
		real lamda,l
	    real is(n),js(n)
		real a(n,n)
	    real q(n,n),p(n),m(n)
	    real x1,x2,g1,g11,g12,g13
	    real dfx1,ddfx1,dfx2,ddfx2,dfxy,dl,dll
	    real::bata=0.5 
	    x1=5                             !/��Ŀ�꺯���ı�������ֵ/
	    x2=5
	    data((q(i,j),i=1,2),j=1,2)/1,0,0,1/
	    k=0                              !/������������ֵ/
          do while(.true.)
	      k=k+1
            call hessen_matrix(a,2,p,x1,x2,e)
            a=a+bata*q
            call BRINV(a,2,l,is,js)               		 
	        do i=1,2
	          m(i)=0
	            do j=1,2
                     m(i)=m(i)+a(i,j)*p(j)
	            end do
	         end do
            call gg(x1,x2,lamda,e)
              x1=x1-lamda*m(1)               !/ͨ��k�ε�������x(k)��x(k+1)/
	        x2=x2-lamda*m(2)
	        write(*,*) x1,x2,f(x1,x2),k
	          if(abs(sqrt(lamda*m(1)**2+lamda*m(2)**2)).lt.0.1)exit
          end do
	 
	 stop   
	end program


	 


	
	   

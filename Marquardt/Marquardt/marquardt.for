      module M_L
	  implicit none
        real,parameter::e=0.1 
	end module M_L
	
      real function f(x1,x2) !/目标函数/
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
	    
		dfx1=(f(x1+e,x2)-f(x1-e,x2))/(2*e) !/目标函数在x1点一阶偏导/
          dfx2=(f(x1,x2+e)-f(x1,x2-e))/(2*e) !/目标函数在x1点一阶偏导/
          g=2*(x1-lamda*dfx1)**2+(x2-lamda*dfx2)**2 
		                                  !/关于迭代步长lamda的函数/
	  return 
	end function
!********************************************************************************
!**********************牛顿法对迭代步长lamda进行一维搜索*************************
!********************************************************************************     
      subroutine gg(x1,x2,lamda,e)  
	    implicit none
	
      	integer k
		real x1,x2,lamda,e
		real dfx1,dfx2,dl,dll,g,f        
	    lamda=0.5  !对迭代步长赋初值
          k=1
	   do while(.true.)
	     dl=(g(x1,x2,lamda+e)-g(x1,x2,lamda-e))/(2*e)!/对步长lamda求一阶偏导/
	     dll=(g(x1,x2,lamda+2*e)-2*g(x1,x2,lamda)+g(x1,x2,lamda-2*e))
     $		    /(4*e*e)                             !/对步长lamda求二阶偏导/
	     lamda=lamda-dl/dll            !/牛顿法对lamda进行一维搜索，求其极值/
		 k=k+1              
		 if(abs(dl/dll).lt.1e-5) exit 
	   end do   
	   return  
	end subroutine
!********************************************************************************
!**********************实矩阵求逆的全选主元高斯-约当消去法***********************
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
!************求函数的一阶偏导数及二阶偏导数（海森矩阵）*************
!*******************************************************************

	subroutine hessen_matrix(a,n,p,x1,x2,e)
      implicit none

	  integer n
	  dimension a(n,n),p(n)
	  real x1,x2,e
	  real a,p,dfx1,ddfx1,dfx2,ddfx2,dfxy,f

          dfx1=(f(x1+e,x2)-f(x1-e,x2))/(2*e) !/目标函数在x1点的一阶偏导/
	    dfx2=(f(x1,x2+e)-f(x1,x2-e))/(2*e) !/目标函数在x2点的一阶偏导/
		ddfx1=(f(x1+2*e,x2)-2*f(x1,x2)+f(x1-2*e,x2))/(4*e**2)
		                                   !/目标函数在x1点的二阶偏导/	
		ddfx2=(f(x1,x2+2*e)-2*f(x1,x2)+f(x1,x2-2*e))/(4*e**2) 
                                             !/目标函数在x2点的二阶偏导/
		dfxy=(f(x1+e,x2+e)-f(x1+e,x2-e)-f(x1-e,x2+e)+f(x1-e,x2-e))
     $	  	  /(4*e**2)                    !/目标函数的二阶混合偏导/
	   
	    p(1)=dfx1
	    p(2)=dfx2
		a(1,1)=ddfx1
	    a(1,2)=dfxy
	    a(2,1)=dfxy
	    a(2,2)=ddfx2

	end subroutine  hessen_matrix

!*******************************************************************
!***************  marquardt_Levenberg主程序  ***********************
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
	    x1=5                             !/对目标函数的变量赋初值/
	    x2=5
	    data((q(i,j),i=1,2),j=1,2)/1,0,0,1/
	    k=0                              !/迭代次数赋初值/
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
              x1=x1-lamda*m(1)               !/通过k次迭代，由x(k)求x(k+1)/
	        x2=x2-lamda*m(2)
	        write(*,*) x1,x2,f(x1,x2),k
	          if(abs(sqrt(lamda*m(1)**2+lamda*m(2)**2)).lt.0.1)exit
          end do
	 
	 stop   
	end program


	 


	
	   

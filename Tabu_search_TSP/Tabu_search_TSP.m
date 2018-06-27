%禁忌搜索解决TSP的Matlab程序 

%编的一个很简单的禁忌搜索程序，效果一般，以后还要努力改善。

%keywords:TSP,TS

%by Zhaokai,zkcsu@126.com 

%Information School of Central South University

%2006/06

%This program is for testing

function TspTS

%禁忌搜索是对局部领域搜索的一种扩展，是一种全局逐步寻优算法。搜索过程可以接受劣解，有较强的爬山能力。

%领域结构对收敛性有很大影响。这个程序的结构简单，为SWAP操作。

clear;

city10=[0.4 0.4439;0.2439 0.1463;0.1707 0.2293;0.2293 0.761;0.5171 0.9414;

    0.8732 0.6536;0.6878 0.5219;0.8488 0.3609;0.6683 0.2536;0.6195 0.2634];%10 cities d'=2.691

for i=1:10

    for j=1:10

        DL10(i,j)=((city10(i,1)-city10(j,1))^2+(city10(i,2)-city10(j,2))^2)^0.5;       

    end

end

city30=[41 94;37 84;54 67;25 62;7 64;2 99;68 58;71 44;54 62;83 69;64 60;18 54;22 60;

    83 46;91 38;25 38;24 42;58 69;71 71;74 78;87 76;18 40;13 40;82 7;62 32;58 35;45 21;41 26;44 35;4 50];%30 cities d'=423.741 by D B Fogel

for i=1:30

    for j=1:30

        DL30(i,j)=((city30(i,1)-city30(j,1))^2+(city30(i,2)-city30(j,2))^2)^0.5;       

    end

end

city50=[31 32;32 39;40 30;37 69;27 68;37 52;38 46;31 62;30 48;21 47;25 55;16 57;

17 63;42 41;17 33;25 32;5 64;8 52;12 42;7 38;5 25; 10 77;45 35;42 57;32 22;

27 23;56 37;52 41;49 49;58 48;57 58;39 10;46 10;59 15;51 21;48 28;52 33;

58 27;61 33;62 63;20 26;5 6;13 13;21 10;30 15;36 16;62 42;63 69;52 64;43 67];%50 cities d'=427.855 by D B Fogel

for i=1:50

    for j=1:50

        DL50(i,j)=((city50(i,1)-city50(j,1))^2+(city50(i,2)-city50(j,2))^2)^0.5;       

    end

end

city75=[48 21;52 26;55 50;50 50;41 46;51 42;55 45;38 33;33 34;45 35;40 37;50 30;

55 34;54 38;26 13;15 5;21 48;29 39;33 44;15 19;16 19;12 17;50 40;22 53;21 36;

20 30;26 29;40 20;36 26;62 48;67 41;62 35;65 27;62 24;55 20;35 51;30 50;

45 42;21 45;36 6;6 25;11 28;26 59;30 60;22 22;27 24;30 20;35 16;54 10;50 15;

44 13;35 60;40 60;40 66;31 76;47 66;50 70;57 72;55 65;2 38;7 43;9 56;15 56;

10 70;17 64;55 57;62 57;70 64;64 4;59 5;50 4;60 15;66 14;66 8;43 26];%75 cities d'=549.18 by D B Fogel

for i=1:75

    for j=1:75

        DL75(i,j)=((city75(i,1)-city75(j,1))^2+(city75(i,2)-city75(j,2))^2)^0.5;       

    end

end

dislist=DL30;

Clist=city30;

CityNum=size(dislist,2);

Tlist=zeros(CityNum);%禁忌表(tabu list)

cl=100;%保留前cl个最好候选解

bsf=Inf;

tl=ceil(CityNum^0.5);%禁忌长度(tabu length)

l1=200;%候选解(candidate),不大于n*(n-1)/2(全部领域解个数)

S0=randperm(CityNum);

S=S0;

BSF=S0;

Si=zeros(l1,CityNum);

StopL=80*CityNum;

p=1;

clf;

figure(1);

stop = uicontrol('style','toggle','string','stop', ... 

  'background','white');

tic;

while (p<StopL)

    if l1>CityNum*(CityNum)/2

    disp('候选解个数,不大于n*(n-1)/2(全部领域解个数)！ 系统自动退出！');

    l1=(CityNum*(CityNum)/2)^.5;

    break;

    end

    ArrS(p)=F(dislist,S);        

    i=1;

    A=zeros(l1,2);

    while i<=l1        

        M=CityNum*rand(1,2);

        M=ceil(M);

        if M(1)~=M(2)

            m1=max(M(1),M(2));m2=min(M(1),M(2));

            A(i,1)=m1;A(i,2)=m2;

            if i==1

                isdel=0;

            else

                for j=1:i-1

                    if A(i,1)==A(j,1)&&A(i,2)==A(j,2)

                     isdel=1;break;

                    else

                    isdel=0;

                    end

                end

            end 

            if ~isdel

               i=i+1;

            else i=i;

            end            

        else i=i;

        end

    end

    

    CL=Inf*ones(cl,4);

    for i=1:l1

        Si(i,:)=S;

        Si(i,[A(i,1),A(i,2)])=S([A(i,2),A(i,1)]);

        F(i)=F(dislist,Si(i,:));

        if i<=cl

                CL(i,2)=F(i);

                CL(i,1)=i;

                CL(i,3)=S(A(i,1));

                CL(i,4)=S(A(i,2));   

        else

            for j=1:cl

             if F(i)<CL(j,2)

                  CL(j,2)=F(i);

                  CL(j,1)=i;

                  CL(j,3)=S(A(i,1));

                  CL(j,4)=S(A(i,2));

                  break;

             end            

            end

        end

    end

    

    if CL(1,2)<bsf%藐视准则(aspiration criterion)

        bsf=CL(1,2);

        S=Si(CL(1,1),:);        

        BSF=S;

        for m=1:CityNum

            for n=1:CityNum

                if Tlist(m,n)~=0

                Tlist(m,n)=Tlist(m,n)-1;

                end

            end

        end

        Tlist(CL(1,3),CL(1,4))=tl;

    else  

        for i=1:cl

            if Tlist(CL(i,3),CL(i,4))==0

                S=Si(CL(i,1),:);                

            for m=1:CityNum

                for n=1:CityNum

                    if Tlist(m,n)~=0

                        Tlist(m,n)=Tlist(m,n)-1;

                    end

                end

            end        

            Tlist(CL(i,3),CL(i,4))=tl;

            break;

            end

        end

    end    

    p=p+1;    

    Arrbsf(p)=bsf;

    for i=1:CityNum-1

       plot([Clist(BSF(i),1),Clist(BSF(i+1),1)],[Clist(BSF(i),2),Clist(BSF(i+1),2)],'bo-');

       hold on;

    end

    plot([Clist(BSF(CityNum),1),Clist(BSF(1),1)],[Clist(BSF(CityNum),2),Clist(BSF(1),2)],'bo-');

    title(['Counter : ',int2str(p*l1),'  The Min Distance: ',num2str(bsf)]);

    hold off;

    pause(0.005);    

    if get(stop,'value')==1

        break;

    end

end

toc;

BestShortcut=BSF

theMinDistance=bsf

set(stop,'style','pushbutton','string','close',... 

   'callback','close(gcf)');

figure(2);

plot(Arrbsf,'r'); hold on;

plot(ArrS,'b');grid;

title('搜索过程');

legend('Best So Far','当前解');

end

function F=F(dislist,s)

        DistanV=0;

        n=size(s,2);

        for i=1:(n-1)

        DistanV=DistanV+dislist(s(i),s(i+1));

        end

        DistanV=DistanV+dislist(s(n),s(1));      

    F=DistanV;

end


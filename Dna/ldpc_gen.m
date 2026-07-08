clc
clear all
M=500;%H的行数
N=1000;%H的列数
j=3;%每列1的个数
k=6;%每行1的个数

H1=zeros(M/j,N);%初始化
for a=1:(M/j)
    H1(a,(a-1)*k+1:a*k) =1;
  
end
H2=[];%初始化
for c=1:j-1
b=randperm(N);
H2=[H2;H1(:,b)];
end
H=[H1;H2];

%消除4环
for m=1:M
for n=m+1:M
   w=and(H(m,:),H(n,:)) ;
d=find(w);
e=length(d);
if e>1
    if  length(find(H(m,:)))>length(find(H(n,:)))
        for f=1:e-1
           H(m,d(f)) =0;
          
        end
    else
        for f=1:e-1
           H(n,d(f)) =0;
        end
    end
end
    
    
end  
end  

    
disp(H)

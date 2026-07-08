
%Diagonalize matrix A,mod 2
%Output:
%  DiagA is the matrix of diagonalization
%  GT is the transpose of the generating matrix 
%  H is the original matrix with its columns reordered as in the Gaussian elimination
function  [DiagA,GT,H,rankA,N0,K0,M0]=Diag(A)
[rows,columns]=size(A);
if(rows>columns) %invalid size of the input matrix
    DiagA=[];
    rankA=0;
    GT=[];
    H=[];
    return;
end
B=A;
D=A;
minRowCol=min(rows,columns);
for u=1:1:minRowCol
    if(0==B(u,u))
        changeFlag=0;
        for v=u:1:columns
            x=B(u:rows,v);
            index=find(x==1);
            if(0==isempty(index)) %find the position where the value is "1"
                currentRow=u+index(1)-1;
                currentCol=v;
                changeFlag=1;
                break;
            end
        end
        if(1==changeFlag)
            B=ChangeRows(B,currentRow,u);
            B=ChangeColumns(B,currentCol,u);
            D=ChangeColumns(D,currentCol,u);
        end
    end
    for v=(u+1):1:rows
        if(1==B(v,u))
            B(v,:)=mod(B(v,:)+B(u,:),2);
        end
    end
end
rA=0;
for u=1:1:minRowCol
    if(0==B(u,u))
        break;
    end
    rA=rA+1;
end
for u=1:1:rA
    for v=(u+1):1:rA
        if(1==B(u,v))
            B(u,:)=mod(B(u,:)+B(v,:),2);
        end
    end
end
N0=columns;
M0=rA;
K0=N0-M0;
count=1;
s=1;
flag=0;
while(1)
    for u=1:1:K0
        a=N0-(s-1)*K0-u+1;
        b=N0-s*K0-u+1;
        B=ChangeColumns(B,a,b);
        D=ChangeColumns(D,a,b);
        count=count+1;
        if(count>M0)
            flag=1;
            break;
        end
    end
    if(flag==1)
        break;
    end
    s=s+1;
end
n=columns;
m=rows;
m0=rA;
k0=n-m0;
P=B(1:1:m0,1:1:(n-m0));
H=D; 
GT=[eye(k0);P];
DiagA=B;
rankA=rA;

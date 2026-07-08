
% % 下面给出矩阵的行交换和列交换函数。
%Exchange the rows u and v of the matrix A

function [OutputMatrix]=ChangeRows(A,m,n)
[u,v]=size(A);
if((m>u)|(n>u)) %No exchange
    OutputMatrix=A;
    return;
end
B=A;
B(m,:)=A(n,:);
B(n,:)=A(m,:);
OutputMatrix=B;



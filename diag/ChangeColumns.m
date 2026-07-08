%Exchange the columns u and v of the matrix A
function [OutputMatrix]=ChangeColumns(A,m,n)
[u,v]=size(A);
if((m>v)|(n>v)) %No exchange
    OutputMatrix=A;
    return;
end
B=A;
B(:,m)=A(:,n);
B(:,n)=A(:,m);
OutputMatrix=B;
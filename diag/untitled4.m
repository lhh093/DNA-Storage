clc;
clear all;
A = [
1 1 1 0 0 1 1 0 0 1
1 1 1 0 0 1 1 0 0 1
1 0 1 0 1 1 0 1 1 0
0 0 1 1 1 0 1 0 1 1
0 1 0 1 1 1 0 1 0 1
0 1 0 1 1 1 0 1 0 1
1 1 0 1 0 0 1 1 1 0]; 
A = IEEE80211n(648, 1/2);
A =double(A);
[DiagA,GT,H,rankA,N0,K0,M0]=Diag(A)
GT'
result=mod(DiagA*GT,2);
if all(result(:) == 0)
    disp('H 和 G 匹配');
else
    disp('H 和 G 不匹配');
end
[m,n]=size(GT');
s = randi([0 1], 1, m); 
codeword = mod(s * GT', 2);

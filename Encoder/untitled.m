n = 1440;
m = 480;   % 对应R≈0.401

dv = 4;    % 平均度

H = ldpc_peg(n, 1 - m/n, dv);

[m1, n1] = size(H);
r=rank(H);
R = 1 - rank(H)/n;

filename = sprintf('LDPC(%d,%d).mat', n, n-m);
save(filename, 'H');
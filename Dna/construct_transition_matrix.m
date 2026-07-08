function P = construct_transition_matrix(a)
    % 计算 p1, p2, p3
    p1 = a;
    p2 = 3 * a;
    p3 = 0;

    % 构造4x4概率转移矩阵
    P = [1 - 2 * p1 - p3, p1, p3, p1;  
         p1, 1 - 2 * p1 - p2, p1, p2;  
         p3, p1, 1 - 2 * p1 - p3, p1;  
         p1, p2, p1, 1 - 2 * p1 - p2];
end

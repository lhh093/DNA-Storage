function output_seq = dna_channel(input_seq,a)
    % 定义概率转移矩阵
    %   A      C    G    T
    % P = [0.5, 0.3, 0.1, 0.1;  % 从 A 转移
    %      0.2, 0.5, 0.2, 0.1;  % 从 C 转移
    %      0.3, 0.2, 0.4, 0.1;  % 从 G 转移
    %      0.4, 0.2, 0.1, 0.3]; % 从 T 转移
    
    p1 = a;
    p2 = 3 * a;
    p3 = 0;
        % 构造4x4概率转移矩阵
    % P = [1-2*p1-p3, p1,        p3,        p1;  
    %      p1,        1-2*p1-p2, p1,        p2;  
    %      p3,        p1,        1-2*p1-p3, p1;  
    %      p1,        p2,        p1,        1 - 2 * p1 - p2];

           % A     C     T     G
     P = [1 - 2 * p1 - p3, p1, p1, p3;  % 从 A 转移
         p1, 1 - 2 * p1 - p2, p2, p1;  % 从 c 转移
         p1, p2, 1 - 2 * p1 - p2, p1; % 从 T 转移
         p3, p1, p1, 1 - 2 * p1 - p3];% 从 G 转移

    % disp('概率转移矩阵 P:');
    % disp(P);
    % 确保输入序列仅包含 A, C, G, T 字符
    if any(~ismember(input_seq, 'ACGT'))
        error('输入序列必须仅包含A, C, G, T字符');
    end
    
    n = length(input_seq); % 碱基数量
    output_seq = ''; % 初始化输出序列

    for i = 1:n
        % 取一个碱基
        current_base = input_seq(i);
        
        % 将碱基映射到对应的状态索引
        switch current_base
            case 'A', state = 1;
            case 'C', state = 2;
            case 'T', state = 3;
            case 'G', state = 4;
        end
        
        % 根据当前状态选择下一状态
        transition_probs = P(state, :);
        cumulative_probs = cumsum(transition_probs);
        r = rand;
        next_state = find(cumulative_probs >= r, 1);
        
        % 将下一个状态转换为DNA碱基
        switch next_state
            case 1, next_base = 'A';
            case 2, next_base = 'C';
            case 3, next_base = 'T';
            case 4, next_base = 'G';
        end
        
        % 追加到输出序列
        output_seq = strcat(output_seq, next_base);
    end
end

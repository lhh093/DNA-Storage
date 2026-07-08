function output_seq = bit_sequence_transition(input_seq)
    % 定义概率转移矩阵
    P = [0.5, 0.3, 0.1, 0.1;  % 从 00 转移
         0.2, 0.5, 0.2, 0.1;  % 从 01 转移
         0.3, 0.2, 0.4, 0.1;  % 从 11 转移
         0.4, 0.2, 0.1, 0.3]; % 从 10 转移

    % 将二进制字符串转换为数值序列
    if mod(length(input_seq), 2) ~= 0
        error('输入序列的长度必须为偶数');
    end
    
    n = length(input_seq) / 2; % 每两个bit为一组
    output_seq = ''; % 初始化输出序列

    for i = 1:n
        % 取两个bit
        current_bits = input_seq((2*i-1):(2*i));
        
        % 将bit对映射到对应的状态索引
        switch current_bits
            case '00', state = 1;
            case '01', state = 2;
            case '11', state = 3;
            case '10', state = 4;
        end
        
        % 根据当前状态选择下一状态
        transition_probs = P(state, :);
        cumulative_probs = cumsum(transition_probs);
        r = rand;
        next_state = find(cumulative_probs >= r, 1);
        
        % 将下一个状态转换为bit对
        switch next_state
            case 1, next_bits = '00';
            case 2, next_bits = '01';
            case 3, next_bits = '11';
            case 4, next_bits = '10';
        end
        
        % 追加到输出序列
        output_seq = strcat(output_seq, next_bits);
    end
end

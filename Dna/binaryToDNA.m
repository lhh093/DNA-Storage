function dna_seq = binaryToDNA(codeword)
    % 检查输入码字长度是否为偶数
    if mod(length(codeword), 2) ~= 0
        error('Codeword length must be even.');
    end

    % 预先分配dna序列的空间
    n = length(codeword) / 2;
    dna_seq = repmat(' ', 1, n);  % 创建一个空字符数组

    % 遍历码字，每两个比特进行映射
    for i = 1:2:length(codeword)
        bits = codeword(i:i+1);  % 获取两个比特
        if isequal(bits, [0 0])
            dna_seq((i+1)/2) = 'A';
        elseif isequal(bits, [1 0])
            dna_seq((i+1)/2) = 'T';
        elseif isequal(bits, [0 1])
            dna_seq((i+1)/2) = 'C';
        elseif isequal(bits, [1 1])
            dna_seq((i+1)/2) = 'G';
        else
            error('Unexpected bit combination.');
        end
    end
end

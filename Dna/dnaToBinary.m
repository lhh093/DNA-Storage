function codeword = dnaToBinary(dna_seq)
    % 预分配存储二进制码字的数组
    n = length(dna_seq) * 2;  % 每个DNA碱基对应两个比特
    codeword = zeros(1, n);

    % 遍历DNA序列，进行反向映射
    for i = 1:length(dna_seq)
        switch dna_seq(i)
            case 'A'
                codeword(2*i-1:2*i) = [0 0];
            case 'T'
                codeword(2*i-1:2*i) = [1 0];
            case 'C'
                codeword(2*i-1:2*i) = [0 1];
            case 'G'
                codeword(2*i-1:2*i) = [1 1];
            otherwise
                error('Invalid character in DNA sequence.');
        end
    end
end

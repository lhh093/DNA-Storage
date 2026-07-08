function dna_str = binary_to_acgt(x1, x2)
    % 输入：两个长度为n的二进制码字x1, x2
    % 输出：一个长度为n的字符串dna_str（ACGT）

    n = length(x1);
    dna_str = blanks(n);  % 初始化一个空字符串

    % 遍历每一位，根据(x1(i), x2(i))的值生成相应的ACGT字符
    for i = 1:n
        if x1(i) == 0 && x2(i) == 0
            dna_str(i) = 'A';  % (0,0) -> A
        elseif x1(i) == 0 && x2(i) == 1
            dna_str(i) = 'C';  % (0,1) -> C
        elseif x1(i) == 1 && x2(i) == 0
            dna_str(i) = 'T';  % (1,0) -> T
        elseif x1(i) == 1 && x2(i) == 1
            dna_str(i) = 'G';  % (1,1) -> G
        else
            error('输入的二元码字必须只包含0和1');
        end
    end
end

function [x1, x2] = dna_to_binary(y)
    % 输入参数:
    % y: 一个长度为n的碱基字符串，只包含字符 'A', 'C', 'G', 'T'
    % 输出参数:
    % x1: 一个长度为n的二元数组，表示每个碱基的第一个二进制元素
    % x2: 一个长度为n的二元数组，表示每个碱基的第二个二进制元素

    % 定义碱基到二进制的映射
    base_to_binary = containers.Map({'A', 'C', 'G', 'T'}, ...
                                    {'00', '01', '11', '10'});

    % 获取输入字符串的长度
    n = length(y);

    % 初始化输出数组
    x1 = zeros(1, n);
    x2 = zeros(1, n);

    % 遍历每个碱基
    for i = 1:n
        % 获取当前碱基
        current_base = y(i);

        % 获取对应的二进制编码
        binary_code = base_to_binary(current_base);

        % 将二进制编码的第一个和第二个元素分别存入x1和x2
        x1(i) = str2double(binary_code(1));
        x2(i) = str2double(binary_code(2));
    end
end
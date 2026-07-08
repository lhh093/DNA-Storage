function [llr_1, llr_2] = calculate_dna_llr(dna_str,a)
    % 输入：dna_str，一个由字符 'A', 'C', 'G', 'T' 组成的字符串
    % 输出：llr_1, llr_2，两个长度为n的数组，对应不同的LLR算法
    p1=a;
    p2=3*a;
    n = length(dna_str);
    llr_1 = zeros(1, n);
    llr_2 = zeros(1, n);
    

    
    % 遍历每一个DNA碱基
    for i = 1:n
        base = dna_str(i);
        
        switch base
            case 'A'
                % 对A应用算法1
                llr_1(i) = log((1-p1)/p1); 
                llr_2(i) = log((1-p1)/p1); 
            case 'C'
                % 对C应用算法2
                llr_1(i) = log((1-p1-p2)/(p1+p2));
                llr_2(i) = log((p1+p2)/(1-p1-p2));
            case 'G'
                % 对G应用算法3
                llr_1(i) = log((p1)/(1-p1)); 
                llr_2(i) = log((p1)/(1-p1)); 
            case 'T'
                % 对T应用算法4
                llr_1(i) = log((p1+p2)/(1-p1-p2)); 
                llr_2(i) = log((1-p1-p2)/(p1+p2));
            otherwise
                error('非法字符: %s', base);
        end
    end
end



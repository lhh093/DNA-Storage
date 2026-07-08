function [llr_1, llr_2] = calculate_dna_llr_count(x,y,a)
    % 输入：dna_str，一个由字符 'A', 'C', 'G', 'T' 组成的字符串
    % 输出：llr_1, llr_2，两个长度为n的数组，对应不同的LLR算法
    p1=a;
    p2=3*a;
    n = length(y);
    llr_1 = zeros(1, n);
    llr_2 = zeros(1, n);
    
    counts = count_bases(x, y);
    %disp(counts);
    % 遍历每一个DNA碱基
    for i = 1:n
        base = y(i);
        
        switch base
            case 'A'
                % y=A
                llr_1(i) = log((counts.AA+counts.CA)/(counts.GA+counts.TA)); 
                llr_2(i) = log((counts.AA+counts.TA)/(counts.GA+counts.CA)); 
            case 'C'
                % y=C
                llr_1(i) = log((counts.AC+counts.CC)/(counts.GC+counts.TC));
                llr_2(i) = log((counts.AC+counts.TC)/(counts.GA+counts.CC));
            case 'G'
                % y=G
                llr_1(i) = log((counts.AG+counts.CG)/(counts.GG+counts.TG)); 
                llr_2(i) = log((counts.AG+counts.TG)/(counts.GG+counts.CG)); 
            case 'T'
                % y=T
                llr_1(i) = log((counts.AT+counts.CT)/(counts.GT+counts.TT)); 
                llr_2(i) = log((counts.AT+counts.TT)/(counts.GT+counts.CT));
            otherwise
                error('非法字符: %s', base);
        end
    end    

    % for i = 1:n
    %     base = y(i);
    % 
    %     switch base
    %         case 'A'
    %            % 对A应用算法1
    %             llr_1(i) = log((1-p1)/p1); 
    %             llr_2(i) = log((1-p1)/p1); 
    %         case 'C'
    %             %对C应用算法2
    %             llr_1(i) = log((1-p1-p2)/(p1+p2));
    %             llr_2(i) = log((p1+p2)/(1-p1-p2));
    %         case 'G'
    %             %对G应用算法3
    %             llr_1(i) = log((p1)/(1-p1)); 
    %             llr_2(i) = log((p1)/(1-p1)); 
    %         case 'T'
    %             %对T应用算法4
    %             llr_1(i) = log((p1+p2)/(1-p1-p2)); 
    %             llr_2(i) = log((1-p1-p2)/(p1+p2));
    %         otherwise
    %             error('非法字符: %s', base);
    %     end
    % end
end



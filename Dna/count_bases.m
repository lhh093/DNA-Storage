function counts = count_bases(x, y)
    % 初始化计数器
    counts = struct('AA', 0, 'AC', 0, 'AT', 0, 'AG', 0, ...
                    'CA', 0, 'CC', 0, 'CT', 0, 'CG', 0, ...
                    'TA', 0, 'TC', 0, 'TT', 0, 'TG', 0, ...
                    'GA', 0, 'GC', 0, 'GT', 0, 'GG', 0);
    
    % 遍历字符串
    for i = 1:length(x)
        switch x(i)
            case 'A'
                switch y(i)
                    case 'A'
                        counts.AA = counts.AA + 1;
                    case 'C'
                        counts.AC = counts.AC + 1;
                    case 'T'
                        counts.AT = counts.AT + 1;
                    case 'G'
                        counts.AG = counts.AG + 1;
                end
            case 'C'
                switch y(i)
                    case 'A'
                        counts.CA = counts.CA + 1;
                    case 'C'
                        counts.CC = counts.CC + 1;
                    case 'T'
                        counts.CT = counts.CT + 1;
                    case 'G'
                        counts.CG = counts.CG + 1;
                end
            case 'T'
                switch y(i)
                    case 'A'
                        counts.TA = counts.TA + 1;
                    case 'C'
                        counts.TC = counts.TC + 1;
                    case 'T'
                        counts.TT = counts.TT + 1;
                    case 'G'
                        counts.TG = counts.TG + 1;
                end
            case 'G'
                switch y(i)
                    case 'A'
                        counts.GA = counts.GA + 1;
                    case 'C'
                        counts.GC = counts.GC + 1;
                    case 'T'
                        counts.GT = counts.GT + 1;
                    case 'G'
                        counts.GG = counts.GG + 1;
                end
        end
    end
end

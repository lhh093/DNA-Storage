function [ v1,v2 ] = LDPCDecoder_dna_fangfa3( H, y,LLR_y1, LLR_y2, p1,iterMax)
%LDPCDecoder_SP LDPC使用和积算法解码
%   H为校验矩阵，用以进行判决；LLR_y为接收到的信号初始置信度；iterMax为最大迭代次数；返回v为解码后的信息序列估计值
% ij与原文定义相反 原文i定义1到n 码长 程序定义i为1到i位校验位
addpath('Dna')
a=0.1;
%注释
L_u=2*p1/(1-2*p1);

[y1, y2] = dna_to_binary(y);
[x1, x2] = dna_to_binary(y);

%初始化第一码字 u 和 v 矩阵
ch1=zeros(size(LLR_y1));
Uji1 = zeros(size(H));
Uji1_iter = zeros(size(H));
Vij1 = zeros(size(H'));
[VerificationNodes1, VariableNodes1] = size(H);


%初始化第二码字 u 和 v 矩阵
ch2=zeros(size(LLR_y2));
Uji2 = zeros(size(H));
Uji2_iter = zeros(size(H));
Vij2 = zeros(size(H'));
[VerificationNodes2, VariableNodes2] = size(H);


%初始化Uji
for i = 1:1:VariableNodes1
            idx1 = find(H(:, i) == 1);
            for k = 1:1:length(idx1)
                 Vij1(i, idx1(k)) =  LLR_y1(i);
                 Vij2(i, idx1(k)) =  LLR_y2(i);
            end   
end 

for iter = 1:1:iterMax


    %停止迭代判决
    if all(mod(H*(x1'), 2) == 0) && all(mod(H*(x2'), 2) == 0)
        fprintf("\n 迭代提前结束 %d",iter);
        break;
    end
    
    % Message passing between two codes
    for i = 1:VariableNodes1
            idx1 = find(H(:, i) == 1);
            if (y1(i) == 1 && y2(i) == 0) || (y1(i) == 0 && y2(i) == 1)
                % 当组合为 (1, 0) 或 (0, 1) 时，更新交换信息ch
                    tmp1=a*sum(Uji2(idx1, i));
                    ch21=2 * atanh(tanh(tmp1/2)*tanh(L_u/2));
                    ch1(i)=LLR_y1(i)+ch21;
                    tmp2=a*sum(Uji1(idx1, i));
                    ch12=2 * atanh(tanh(tmp2/2)*tanh(L_u/2));
                    ch2(i)=LLR_y2(i)+ch12;
            else
                    ch1(i)=LLR_y1(i);
                    ch2(i)=LLR_y2(i);
            end
    end
     Uji1_iter=Uji1;
     Uji2_iter=Uji2;

    %Check node update
    for j = 1:1:VerificationNodes1
        idx1 = find(H(j, :) == 1);
        for k = 1:1:length(idx1)
            multipleVal1 = 1;
            multipleVal2 = 1;
            for l = 1:1:length(idx1)
                 if k == l
                      continue;
                 end
                 tmp=Vij1(idx1(l), j);
                 tmp = min(tmp, 20);
                 tmp = max(tmp, -20);
                 multipleVal1 = multipleVal1 * tanh(tmp/2);
                 tmp=Vij2(idx1(l), j);
                 tmp = min(tmp, 20);
                 tmp = max(tmp, -20);
                 multipleVal2 = multipleVal2 * tanh(tmp/2);
            end
            Uji1(j, idx1(k)) = 2 * atanh(multipleVal1);
            Uji2(j, idx1(k)) = 2 * atanh(multipleVal2);
            
            % %%%源程序
            %             multipleVal1 = 2*atanh(prod(tanh(Vij1(idx1, j)/2))/tanh(Vij1(idx1(k), j)/2));
            %             multipleVal2 = 2*atanh(prod(tanh(Vij2(idx1, j)/2))/tanh(Vij2(idx1(k), j)/2));
            % 
            % %第一码字
            % if multipleVal1 == inf || multipleVal1 == -inf
            %     if multipleVal1 == inf
            %         Uji1(j, idx1(k)) = 10;
            %         %disp(['>> Uji is inf when j = ' num2str(j) ', i = ' num2str(idx1(k))]);
            %     else
            %         Uji1(j, idx1(k)) = -10;
            %         %disp(['>> Uji is -inf when j = ' num2str(j) ', i = ' num2str(idx1(k))]);
            %     end              
            % else
            %     Uji1(j, idx1(k)) = multipleVal1;
            % end
            % 
            % %第二码字
            % if multipleVal2 == inf || multipleVal2 == -inf
            %     if multipleVal2 == inf
            %         Uji2(j, idx1(k)) = 10;
            %         %disp(['>> Uji is inf when j = ' num2str(j) ', i = ' num2str(idx1(k))]);
            %     else
            %         Uji2(j, idx1(k)) = -10;
            %         %disp(['>> Uji is -inf when j = ' num2str(j) ', i = ' num2str(idx1(k))]);
            %     end
            % else
            %     Uji2(j, idx1(k)) = multipleVal2;
            % end
        end
    end
    
    %Variable node update
    for i = 1:1:VariableNodes1
         idx1 = find(H(:, i) == 1);
         for k = 1:1:length(idx1)
             Vij1(i, idx1(k)) =  ch1(i) + sum(Uji1(idx1, i)) - Uji1(idx1(k), i);
             Vij2(i, idx1(k)) =  ch2(i) + sum(Uji2(idx1, i)) - Uji2(idx1(k), i);
         end
    end
    %判决
    for i = 1:1:VariableNodes1
        idx1 = find(H(:, i) == 1);
        addVal = sum(Uji1(idx1, i)) + ch1(i);
        if(addVal < 0)
            x1(i) = 1;
        else
            x1(i) = 0;
        end
    end
    %第二判决
    for i = 1:1:VariableNodes1
        idx1 = find(H(:, i) == 1);
        addVal = sum(Uji2(idx1, i)) + ch2(i);
        if(addVal < 0)
            x2(i) = 1;
        else
            x2(i) = 0;
        end
    end

end


 v1 = x1;
 v2 = x2;

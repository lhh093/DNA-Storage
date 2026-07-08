function [ v1 ] = LDPCDecoder_dna_fangfa1_test( H, LLR_y1, iterMax)
% 方法1译码的matlab仿真
% 复现论文: [LDPC_Codes_for_Portable_DNA_Storage]
% 编码者: 刘海航 华南师范大学        
% 时间: [25.3.24]

%   H为校验矩阵，用以进行判决；LLR_y为接收到的信号初始置信度；iterMax为最大迭代次数；返回v为解码后的信息序列估计值

addpath('Dna')
a=0.1;
%注释


x1 = zeros(size(LLR_y1));

%初始化第一码字 u 和 v 矩阵
ch1=LLR_y1;
Uji1 = zeros(size(H));
Uji1_iter = zeros(size(H));
Vij1 = zeros(size(H'));
[VerificationNodes1, VariableNodes1] = size(H);





%初始化Uji
for i = 1:1:VariableNodes1
            idx1 = find(H(:, i) == 1);
            for k = 1:1:length(idx1)
                 Vij1(i, idx1(k)) =  LLR_y1(i);
                 
            end   
end 

for iter = 1:1:iterMax


    %停止迭代判决
    % if mod(H*(x1'), 2) == 0
    %     break;
    % end
    
    % Message passing between two codes
    % for i = 1:VariableNodes1
    %         idx1 = find(H(:, i) == 1);
    %         %if (x1(i) == 1 && x2(i) == 0) || (x1(i) == 0 && x2(i) == 1)
    % 
    %         ch1(i)=LLR_y1(i);
    % 
    % 
    % end
    
 

    %Check node update
    for j = 1:1:VerificationNodes1
        idx1 = find(H(j, :) == 1);
        for k = 1:1:length(idx1)
            multipleVal1 = 1;
            
            for l = 1:1:length(idx1)
                 if k == l
                      continue;
                 end
                 tmp=Vij1(idx1(l), j);
                 tmp = min(tmp, 20);
                 tmp = max(tmp, -20);
                 multipleVal1 = multipleVal1 * tanh(tmp/2);
                 
            end
            Uji1(j, idx1(k)) = 2 * atanh(multipleVal1);
            
            

        end
    end
    
    %Variable node update
    for i = 1:1:VariableNodes1
         idx1 = find(H(:, i) == 1);
         for k = 1:1:length(idx1)
             Vij1(i, idx1(k)) =  ch1(i) + sum(Uji1(idx1, i)) - Uji1(idx1(k), i);
             
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
   
    if mod(H*(x1'), 2) == 0
         break;
    end

end


 v1 = x1;
 

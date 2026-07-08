clc
clear all
%循环100次，统计对应输入的每位，输出序列acgt的个数，行：acgt
input_seq = 'ACTGACTG'; % 输入的DNA序列
lambda=0.1;
% 输入序列的长度
seq_len = length(input_seq);
    
% 初始化统计矩阵，4行分别代表ACGT，列数为输入序列的长度
stats_matrix = zeros(4, seq_len);

% 定义碱基到索引的映射
base_map = containers.Map({'A', 'C', 'T', 'G'}, {1, 2, 3, 4});
    
% 进行多次序列生成并统计结果
for trial = 1:100
    % 调用 dna_sequence_transition 函数生成输出序列
    output_seq = dna_channel(input_seq,lambda);
        
    % 统计每个位置上的碱基
    for i = 1:seq_len
         base = output_seq(i);
         base_index = base_map(base);
         stats_matrix(base_index, i) = stats_matrix(base_index, i) + 1;
     end
end
    
    % 输出统计结果矩阵
disp('碱基在每个位置上的出现次数（行：ACTG，列：输入序列位置）');
disp(stats_matrix);


% input_seq = '00011110'; % 输入的二进制序列
% output_seq = bit_sequence_transition(input_seq);
% disp(['输入序列: ', input_seq]);
% disp(['输出序列: ', output_seq]);

% input_seq = 'ACGTACGT'; % 输入的DNA序列
% output_seq = dna_channel(input_seq);
% disp(['输入DNA序列: ', input_seq]);
% disp(['输出DNA序列: ', output_seq]);
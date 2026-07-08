function H = ldpc_peg(n, R, dv)
% PEG构造LDPC
% n: 码长
% R: 码率
% dv: 每列度（规则）

m = round(n * (1 - R));
H = zeros(m, n);

for v = 1:n
    for k = 1:dv
        
        if k == 1
            % 第一条边：选度最小的校验节点
            [~, c] = min(sum(H, 2));
        else
            % BFS找最远节点（避免短环）
            dist = inf(m,1);
            visited_v = false(n,1);
            visited_c = false(m,1);
            
            queue = [];
            
            % 初始化
            neighbors = find(H(:, v));
            visited_c(neighbors) = true;
            dist(neighbors) = 1;
            queue = neighbors;
            
            d = 1;
            while ~isempty(queue)
                next_queue = [];
                for i = 1:length(queue)
                    cnode = queue(i);
                    
                    v_neighbors = find(H(cnode, :));
                    for vn = v_neighbors
                        if ~visited_v(vn)
                            visited_v(vn) = true;
                            c_neighbors = find(H(:, vn));
                            for cn = c_neighbors'
                                if ~visited_c(cn)
                                    visited_c(cn) = true;
                                    dist(cn) = d + 1;
                                    next_queue(end+1) = cn;
                                end
                            end
                        end
                    end
                end
                
                queue = next_queue;
                d = d + 1;
            end
            
            % 选距离最大且度最小的校验节点
            max_dist = max(dist(~isinf(dist)));
            candidates = find(dist == max_dist);
            
            if isempty(candidates)
                candidates = find(~visited_c);
            end
            
            [~, idx] = min(sum(H(candidates,:),2));
            c = candidates(idx);
        end
        
        H(c, v) = 1;
    end
end

end
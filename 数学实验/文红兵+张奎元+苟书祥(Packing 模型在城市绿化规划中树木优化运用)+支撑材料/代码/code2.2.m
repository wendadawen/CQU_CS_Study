clc ; clear all ;

e1 = 0.5;  


W = 500 ; % 矩形土地的长
L = 500 ; % 矩形土地的宽
R = 2.5 ;  % 树的半径

% 第一幅图数据 
x_exist = [4 ; 9 ; 14 ; 25 ; 123 ; 78 ; 84 ; 159 ; 245 ; 256 ; 356 ; 452] ;  % 已经存在的树的x坐标
y_exist = [8 ; 2.5 ; 13 ; 25 ; 456 ; 45 ; 45 ; 159 ; 245 ; 256 ; 356 ; 425] ;  % 已经存在的树的y坐标


W_block = 25 ;  % 每一块的W
L_block = 25 ;  % 每一块的L

final_x = []; 
final_y = [];
final_n = 0;
n_pre_max = floor(L_block / (2 * R)) * floor(W_block / (2 * R)) ;
for y_move = 1:W/W_block
    for x_move = 1:L/L_block
        %圆平移
        %%%%%%%%%%每张图的初始化%%%%%%%%%%%%%%%%%%%%%
        n_left = 0 ; % 圆形的最小数量（一定可以）
        n_right = ceil(L_block * W_block / (pi * R * R)) + 1;  % 圆形的最大数量（不一定可以）
        n_max = 0 ;  % 二分答案的最大圆的数量
        x_and_y_position = [] ; % 最大数量下的各个点的坐标
        
        Y = [x_exist - (x_move - 1) * L_block;  y_exist - (y_move - 1) * W_block] ;
        
        % 因为圆形的数量 满足单调性，运用二分算法求解满足特定土地的最大圆形数量
        n_max_esp = 100 ;
        Iter = 20 ;  % 每一块的迭代次数 
        cnt = 0 ; 
        while (cnt < Iter && n_pre_max > n_max) || cnt == 0
            cnt = cnt + 1 ;
            left = max(n_max, n_left) + 1 ;
            right = n_right ;
            while left < right
                mid = floor((left + right) / 2) ;
                if mid == 0
                    break ; 
                end
                disp("现在正在计算：" + num2str(mid)) ;
                [result, solution] = check(mid, L_block, W_block, R, e1, Y) ;
                if result == 1
                    if n_max < mid
                        n_max = mid ;
                        x_and_y_position = solution ;
                        n_max_esp = result ;
                    end
                    if n_max == mid && n_max_esp > result
                        x_and_y_position = solution ;
                        n_max_esp = result ;
                    end
                    left = mid + 1 ;
                    disp(num2str(mid) + "个圆形可以容纳下！") ;
                else
                    right = mid - 1 ;
                    disp(num2str(mid) + "个圆形不能容纳下！") ;
                end
            end
        end
        if n_max == 0
            continue ;
        end
        n_pre_max = max(n_pre_max, n_max) ;
        final_x = cat(1, final_x, x_and_y_position(1:n_max) + (x_move - 1) * L_block);
        final_y = cat(1, final_y, x_and_y_position(n_max+1:end) + (y_move - 1) * W_block);
        final_n = final_n + n_max; 
    end

end


% 绘制圆形
x = final_x;
y = final_y;
figure ;
for i = 1:final_n
    if mod(i ,2) == 1  
        rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'r', 'EdgeColor', 'none');
    else
        rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'g', 'EdgeColor', 'none');
    end
end
for i = 1:size(x_exist, 1)
    rectangle('Position', [x_exist(i)-R, y_exist(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'b', 'EdgeColor', 'none');
end
axis([0 L 0 W]);
xlabel("L") ;
ylabel("W") ;
title("树木种植图")

disp("最多还可以种植："+final_n+"树") ;

% 二分函数的check函数
function [result, solution] = check(m, L_block, W_block, R, e1, Y)
    
    % 初始化迭代点
    x = rand(m, 1) * L_block ; 
    y = rand(m, 1) * W_block ;
    X = [x ; y] ;

    % 约束变量的上界和下界
    lb = [repmat(R, m, 1) ; repmat(R, m, 1)] ;
    ub = [repmat(L_block-R, m, 1) ; repmat(W_block-R, m, 1)] ;
    
    % 将固定参数传递给 objfun
    objfun = @(X)objectiveFcn(X,L_block,W_block,R,Y) ;
    
    % 运用fmincon函数求解函数最小值
    %options = optimoptions('ga','PopulationSize', 50, 'Generations', 100, "HybridFcn","fmincon");
    %[solution,objectiveValue] = ga(objfun,2*m,[],[],[],[],lb,ub,[],options);  % 遗传算法
    %[solution,objectiveValue] = particleswarm(objfun,2*m,lb,ub); % 多粒度算法
    %[solution,objectiveValue] = patternsearch(objfun,X,[],[],[],[],lb,ub) ; % 模式搜索
    options = optimoptions("fmincon","MaxFunctionEvaluations",10000);
    [solution,objectiveValue] = fmincon(objfun,X,[],[],[],[],lb,ub,[],options);
    
    % 返回check的结果，表示
    result = objectiveValue < e1 ;
end

% 目标函数，采用拟物算法,参考"求解圆形packing问题的启发式方法_康雁"
function f = objectiveFcn(X, L_block, W_block, R, Y)
    n = size(X, 1) / 2 ;
    x = X(1:n) ;
    y = X(n+1:end) ;
    d = zeros(n, n+4) ;
    for i = 1:n
        for j = 1:n
            if i == j
                continue ;
            end
            tp = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2) ;
            d(i,j) = smooth(2*R - tp) ;
        end
        d(i, n+1) = smooth(R-y(i)) ;
        d(i, n+2) = smooth(R-x(i)) ;
        d(i, n+3) = smooth(R-W_block+y(i)) ;
        d(i, n+4) = smooth(R-L_block+x(i)) ;
    end

    m = size(Y, 1) / 2 ;
    x1 = Y(1:m) ;
    y1 = Y(m+1:end) ;
    g = rand(n, m) ;
    for i = 1:n
        for j = 1:m
            tp = sqrt((x(i)-x1(j))^2 + (y(i)-y1(j))^2) ;
            g(i, j) = smooth(2*R - tp) ;
        
        end
    end

    %disp(d) ;
    f = sum(sum(d.^2)) + sum(sum(g.^2)) ;
end

% 对max(0,a)进行平滑处理，非连续函数运算较慢，我们对非连续函数进行平滑处理，使其成为连续函数，在求解答案时获得了一个数量级甚至两个数量级的提升，与此带来的害处是精度降低，需要调节精度，不过这是非常值得的。
% 平滑函数是 Sigmoid 函数
function f = smooth(a)  
    f = a ./ (1 + exp(-a*10000)) ;
end
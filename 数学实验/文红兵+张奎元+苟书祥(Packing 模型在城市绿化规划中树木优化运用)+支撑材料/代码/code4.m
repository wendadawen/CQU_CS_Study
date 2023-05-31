clc ; clear all ;

e1 = 0.5 ;  % 精度，小于该值都认为函数的最小值是0

Area = 300 ;  % 土地的面积
R = 2.5;  % 树的半径
Iter = 3 ;  % 迭代多次取做多


x_and_y_position = [] ; % 最大数量下的各个点的坐标
n_max = 0 ;  % 二分答案的最大圆的数量

L_t = 0 ;
W_t = 0 ;
for L = 2*R:0.5:Area/2
    W = Area / L ;
    if W < 2*R
        continue ;
    end
    n_left = max(0, floor(L / (2 * R)) * floor(W / (2 * R)) - 100) ; % 圆形的最小数量
    n_right = ceil(L * W / (pi * R * R)) ;  % 圆形的最大数量
    
    % 因为圆形的数量 满足单调性，运用二分算法求解满足特定土地的最大圆形数量
    for i = 1:Iter
        left = max(n_max, n_left) ;
        right = n_right ;
        while left <= right
            mid = floor((left + right) / 2) ;
            if mid <= 0
                continue ;
            end
            disp("现在正在计算：" + num2str(mid)) ;
            [result, solution] = check(mid, L, W, R, e1) ;
            if result == 1
                n_max = mid ; L_t = L ; W_t = W ;
                left = mid + 1 ;
                x_and_y_position = solution ;
                disp(num2str(mid) + "个圆形可以容纳下！") ;
            else
                right = mid - 1 ;
                disp(num2str(mid) + "个圆形不能容纳下！") ;
            end
        end
    end
end

% 绘制圆形
x = x_and_y_position(1:n_max) ;
y = x_and_y_position(n_max+1:end) ;
figure ;
for i = 1:n_max
    rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'r', 'EdgeColor', 'none');
end
axis([0 L_t 0 W_t]);

disp("此时的长："+L_t+"  宽："+W_t) ;
 

% 二分函数的check函数
function [result, solution] = check(m, L, W, R, e1)
    
    % 初始化迭代点
    x = rand(m, 1) * L ; 
    y = rand(m, 1) * W ;
    X = [x ; y] ;

    % 约束变量的上界和下界
    lb = [repmat(R, m, 1) ; repmat(R, m, 1)] ;
    ub = [repmat(L-R, m, 1) ; repmat(W-R, m, 1)] ;
    
    % 将固定参数传递给 objfun
    objfun = @(X)objectiveFcn(X,L,W,R) ;
    
    % 运用模式搜索算法求解函数最小值
    %options = optimoptions('ga','PopulationSize', 50, 'Generations', 100, "HybridFcn","fmincon");
    %[solution,objectiveValue] = ga(objfun,2*m,[],[],[],[],lb,ub,[],options);
    %[solution,objectiveValue] = particleswarm(objfun,2*m,lb,ub);
    %[solution,objectiveValue] = patternsearch(objfun,X,[],[],[],[],lb,ub,[],options);
    options = optimoptions("fmincon","MaxFunctionEvaluations",10000);
    [solution,objectiveValue] = fmincon(objfun,X,[],[],[],[],lb,ub,[],options);

    % 返回check的结果，表示
    result = objectiveValue < e1 ;
end

function f = objectiveFcn(X, L_block, W_block, R)
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
    %disp(d) ;
    f = sum(sum(d.^2)) ;
end

function f = smooth(a)  
    f = a ./ (1 + exp(-a*10000)) ;
end
perm = randperm(length(final_x));
x = final_x(perm(1:5000));
y = final_y(perm(1:5000));
n = 5000;
dis = 100000000;


subplot(1,2,1);
R = 0.5; % set R to 0.5
L = max(x) + 2*R;
W = max(y) + 2*R;
for i = 1:n
    if mod(i, 2) == 1  
       rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'r', 'EdgeColor', 'none');
    else
        rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'g', 'EdgeColor', 'none');
    end
end
axis([0 L 0 W]);
xlabel("L") ;
ylabel("W") ;
title("树木种植原图");

% rest of the code remains the same

for i = 1:n
    for j = 1:n
        if(i == j)
            continue
        end
        if(sqrt((x(i) - x(j)) ^ 2 + (y(i) - y(j)) ^ 2 ) > 7.5)
            dis = min(dis, sqrt((x(i) - x(j)) ^ 2 + (y(i) - y(j)) ^ 2));
        end
    end
end

area = n * (dis / 2) ^ 2 * pi; 
disp("面积为:" + num2str(area));

subplot(1, 2, 2);
R = dis / 2; % set R to 0.5
L = max(x) + 2*R;
W = max(y) + 2*R;
for i = 1:n
    if mod(i, 2) == 1  
       rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'r', 'EdgeColor', 'none');
    else
        rectangle('Position', [x(i)-R, y(i)-R, 2*R, 2*R], 'Curvature', [1, 1], 'FaceColor', 'g', 'EdgeColor', 'none');
    end
end

axis([0 L 0 W]);
xlabel("L") ;
ylabel("W") ;
title("树木优化后种植图");

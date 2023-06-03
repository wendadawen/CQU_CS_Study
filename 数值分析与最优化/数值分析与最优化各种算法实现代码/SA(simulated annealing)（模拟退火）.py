import math
import random
import numpy as np
from matplotlib import pyplot as plt


# 寻找函数的最大值
def f(x: np.ndarray) -> float:
    return x[0] * math.cos(2 * math.pi * x[1]) + x[1] * math.sin(2 * math.pi * x[0])


def judge(dE: float, T: float) -> bool:
    if dE < 0:
        return True
    else:
        p = math.exp(-(dE / T))
        if p > random.random():
            return True
        else:
            return False


if __name__ == '__main__':
    x_size = 2  # 变量的维度
    k = 20  # 在每个温度下迭代的次数
    t0 = 100000  # 初始温度
    Tend = 1  # 终止温度
    alpha = 0.95  # 冷却速率
    ub_x = [2, 2]
    lb_x = [-2, -2]

    evolve_route = []  # 每次迭代的最大值

    # 初始解
    x = []
    for j in range(x_size):
        x.append(random.uniform(lb_x[j], ub_x[j]))
    x = np.array(x)
    x_best = x
    # 迭代
    T = t0
    while T > Tend:
        for i in range(k):
            x_new = x + np.random.uniform(-0.1, 0.1, 2)
            for j in range(x_size):
                if x_new[j] > ub_x[j]:
                    x_new[j] = ub_x[j]
                elif x_new[j] < lb_x[j]:
                    x_new[j] = lb_x[j]
            dE = f(x_new) - f(x)
            if judge(dE, T):
                x = x_new
            if f(x_best) < f(x):
                x_best = x
            evolve_route.append(f(x))
        T = alpha * T

    # 输出
    print("最大值：", x_best)
    print("最优解：", f(x_best))

    # 画图
    plt.figure()
    plt.scatter([x for x in range(1, len(evolve_route) + 1)], evolve_route)
    plt.xlabel('Iter')
    plt.ylabel('Distance')
    plt.title('Iter-Distance')
    plt.show()

import math
import random
from typing import List
import numpy as np
from matplotlib import pyplot as plt


# 寻找函数的最大值
def f(x: List[float]) -> float:
    return x[0] * math.cos(2 * math.pi * x[1]) + x[1] * math.sin(2 * math.pi * x[0])


def generate_random_particles(particles_size: int, particle_size: int) -> (np.ndarray, np.ndarray):
    particles_x, particles_v = [], []
    for i in range(particles_size):
        temp_x, temp_v = [], []
        for j in range(particle_size):
            temp_x.append(random.uniform(lb_x[j], ub_x[j]))
            temp_v.append(random.uniform(lb_v[j], ub_v[j]))
        particles_x.append(temp_x)
        particles_v.append(temp_v)
    return np.array(particles_x), np.array(particles_v)


def update_particles_velocity(particles_v: np.ndarray, particles_x: np.ndarray) -> np.ndarray:
    particles_v = w*particles_v + c1*random.random()*(pbest-particles_x) + c2*random.random()*(pbest-particles_x)
    for i in range(particles_v.shape[0]):
        for j in range(particles_v.shape[1]):
            if particles_v[i, j] > ub_v[j]:
                particles_v[i, j] = ub_v[j]
            elif particles_v[i, j] < lb_v[j]:
                particles_v[i, j] = lb_v[j]
    return particles_v


def update_particles_position(particles_v, particles_x) -> np.ndarray:
    particles_x = particles_x + particles_v
    for i in range(particles_x.shape[0]):
        for j in range(particles_x.shape[1]):
            if particles_x[i, j] > ub_x[j]:
                particles_x[i, j] = ub_x[j]
            elif particles_x[i, j] < lb_x[j]:
                particles_x[i, j] = lb_x[j]
    return particles_x


def update_particles_pbest(pbest, particles_x) -> np.ndarray:
    n = len(particles_x)
    for i in range(n):
        if f(pbest[i]) < f(particles_x[i]):
            pbest[i] = particles_x[i]
    return pbest


if __name__ == '__main__':
    particles_size = 50  # 粒子群大小
    particle_size = 2  # 单个粒子的维度
    max_iterations = 100  # 最大迭代次数
    c1 = 2  # 加速度常数
    c2 = 2  # 加速度常数
    w = 0.8
    ub_x = [2, 2]
    lb_x = [-2, -2]
    ub_v = [2, 2]
    lb_v = [-2, -2]

    evolve_route = []  # 每次迭代的最大值

    # 随机生成粒子
    particles_x, particles_v = generate_random_particles(particles_size, particle_size)
    # 初始化历史最优解
    gbest = particles_x[0]  # 粒子群最优解
    for i in range(particles_size):
        if f(particles_x[i]) > f(gbest):
            gbest = particles_x[i]
    pbest = particles_x   # 个体粒子的历史最优解

    # 迭代更新
    for iteration in range(max_iterations):
        for i in range(particles_size):
            particles_v = update_particles_velocity(particles_v,particles_x)
            particles_x = update_particles_position(particles_v, particles_x)
            pbest = update_particles_pbest(pbest, particles_x)
            if f(particles_x[i]) > f(gbest):
                gbest = particles_x[i]
        evolve_route.append(f(gbest))

    # 输出
    print("最大值：", gbest)
    print("最优解：", f(gbest))

    # 画图
    plt.figure()
    plt.scatter([x for x in range(1, max_iterations+1)], evolve_route)
    plt.xlabel('Iter')
    plt.ylabel('Distance')
    plt.title('Iter-Distance')
    plt.show()



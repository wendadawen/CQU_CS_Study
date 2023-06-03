import itertools
import math
import random
import bisect
from typing import List
from matplotlib import pyplot as plt

M = 100
"""
遗传算法容易陷入局部最优的结果，为了解决这一问题，可以采取以下两个策略（欢迎补充）：
1、适应度函数尺度化
定义：将适应度函数的值放大或缩小来重新定义适应度函数的过程
方法：
遗传初期缩小适应度差别（减小超级个体竞争力）
遗传后期增大适应度差异（加快收敛）
即f(x)=μ(F(x))，F(x)为适应度函数
μ(x)可以为一次函数，幂函数，指数函数等

2、灾变
如果长时间最优值没有变化，就扼杀最优值
加入灾变之后几乎都是全局最优解
"""


# 定义目标函数(求最大值)
def f(x: List[int]) -> float:
    f = 0
    for i in range(1, len(x)):
        f += math.sqrt((x_axis[x[i - 1]] - x_axis[x[i]]) ** 2 + (y_axis[x[i - 1]] - y_axis[x[i]]) ** 2)
    return -f


# 定义尺度化函数
def u(x: float) -> float:
    tp = (x + M)
    return tp


# 定义适应度函数
def calc_fitness(chromosome: List[int]) -> float:
    x = decode_chromosome(chromosome)
    return u(f(x))


def decode_chromosome(chromosome: List[int]) -> List[int]:
    return chromosome


# 定义随机种群生成函数
def generate_random_chromosomes(chromosomes_size: int, chromosome_length: int) -> List[List[int]]:
    chromosomes = []
    for i in range(chromosomes_size):
        chromosome = random.sample([x for x in range(0, chromosome_length)], chromosome_length)
        chromosomes.append(chromosome)
    return chromosomes


# 定义交叉操作函数
def crossover(chromosomes: List[List[int]], crossover_rate: float) -> List[List[int]]:
    n = len(chromosomes)
    offspring_chromosomes = []
    for i in range(0, n, 2):
        offspring1, offspring2 = two_point_crossover(chromosomes[i], chromosomes[i + 1], crossover_rate)
        offspring_chromosomes.append(offspring1)
        offspring_chromosomes.append(offspring2)
    return offspring_chromosomes


def two_point_crossover(chromosome1: List[int], chromosome2: List[int], crossover_rate: float) -> (
        List[int], List[int]):
    if random.random() <= crossover_rate:
        crossover_point1 = random.randint(1, len(chromosome1) - 1)
        crossover_point2 = random.randint(1, len(chromosome1) - 1)
        crossover_point1, crossover_point2 = sorted([crossover_point1, crossover_point2])

        offspring1, offspring2 = [], []
        for city in chromosome1[:crossover_point2 + 1]:
            if city not in chromosome2[crossover_point1: crossover_point2 + 1]:
                offspring1.append(city)
        for city in chromosome2[:crossover_point2 + 1]:
            if city not in chromosome1[crossover_point1: crossover_point2 + 1]:
                offspring2.append(city)

        offspring1 += chromosome2[crossover_point1: crossover_point2 + 1]
        offspring2 += chromosome1[crossover_point1: crossover_point2 + 1]

        for city in chromosome1[crossover_point2 + 1:]:
            if city not in chromosome2[crossover_point1: crossover_point2 + 1]:
                offspring1.append(city)
        for city in chromosome2[crossover_point2 + 1:]:
            if city not in chromosome1[crossover_point1: crossover_point2 + 1]:
                offspring2.append(city)
        return offspring1, offspring2
    return chromosome1, chromosome2


# 定义变异操作函数
def mutation(offspring_chromosomes: List[List[int]], mutation_rate: float) -> List[List[int]]:
    n = len(offspring_chromosomes)
    mutated_chromosomes = []
    for i in range(n):
        chromosome = single_point_mutation(offspring_chromosomes[i], mutation_rate)
        chromosome = two_point_mutation(chromosome, mutation_rate)
        mutated_chromosomes.append(chromosome)
    return mutated_chromosomes


def single_point_mutation(chromosome: List[int], mutation_rate: float) -> List[int]:
    mutated_chromosome = chromosome
    if random.random() < mutation_rate:
        mutation_point1 = random.randint(0, len(chromosome) - 1)
        mutation_point2 = random.randint(0, len(chromosome) - 1)
        mutated_chromosome[mutation_point1], mutated_chromosome[mutation_point2] = mutated_chromosome[mutation_point2], \
            mutated_chromosome[mutation_point1]
    return mutated_chromosome


def two_point_mutation(chromosome: List[int], mutation_rate: float) -> List[int]:
    mutated_chromosome = chromosome
    if random.random() < mutation_rate:
        # 随机选择一个位置进行变异
        mutation_point1 = random.randint(0, len(chromosome) - 1)
        mutation_point2 = random.randint(0, len(chromosome) - 1)
        mutation_point1, mutation_point2 = sorted([mutation_point1, mutation_point2])
        mutated_chromosome[mutation_point1: mutation_point2 + 1] = reversed(
            mutated_chromosome[mutation_point1: mutation_point2 + 1])
    return mutated_chromosome


# 定义更新种群函数
def update_chromosomes(sorted_chromosomes: List[List[int]], chromosomes_size: int) -> List[List[int]]:
    # 保留最优解
    best_chromosome = sorted_chromosomes[-1]
    new_chromosomes = [best_chromosome]
    # 轮盘赌选择种群
    fitness_sum = sum([calc_fitness(chromosome) for chromosome in sorted_chromosomes])
    fitness = [calc_fitness(chromosome) / fitness_sum for chromosome in sorted_chromosomes]
    probabilities = list(itertools.accumulate(fitness))
    for i in range(chromosomes_size - 1):
        new_chromosomes.append(sorted_chromosomes[roulette_wheel_selection(probabilities)])
    return new_chromosomes


# 选择操作，轮盘赌选择
def roulette_wheel_selection(probabilities: List[float]) -> int:
    """
    :param probabilities: 个体概率的前缀和
    :return: 随机选择的个体下标
    """
    r = random.uniform(0, 1)
    return bisect.bisect_left(probabilities, r)


if __name__ == '__main__':
    # 城市坐标
    y_axis = [96.1, 94.44, 92.54, 93.37, 97.24, 96.29, 97.38, 98.12, 97.38, 95.59]
    x_axis = [16.47, 16.47, 20.09, 22.39, 25.23, 17.2, 16.3, 14.05, 16.53, 21.52]

    # 定义遗传算法参数
    chromosomes_size = 50  # 种群数量
    chromosome_length = len(x_axis)  # 染色体长度
    crossover_rate = 0.8  # 交叉概率
    mutation_rate = 0.01  # 变异概率
    max_iterations = 1000  # 最大迭代次数
    Lambda = 1  # 用来衡量迭代的深度
    evolve_route = []  # 每次迭代的最大值
    catastrophe_up = 20  # 灾变上限，若最优值一直是一个值，破坏它

    # 初始化种群
    pre_fitness = None
    catastrophe_count = 0
    best_x = None
    best_fitness = -math.inf
    chromosomes = generate_random_chromosomes(chromosomes_size, chromosome_length)

    # 开始迭代
    for iteration in range(1, max_iterations + 1):
        # 交叉操作（按顺序两两进行交叉操作）
        offspring_chromosomes = crossover(chromosomes, crossover_rate)
        # 变异操作（按顺序进行变异操作）
        mutated_chromosomes = mutation(offspring_chromosomes, mutation_rate)
        # 更新种群（轮盘赌法更新种群，chromosomes选取一半，mutated_chromosomes选取一半）
        sorted_chromosomes = sorted(chromosomes + mutated_chromosomes, key=lambda chromosome: calc_fitness(chromosome))
        chromosomes = update_chromosomes(sorted_chromosomes, chromosomes_size)
        # 输出此次迭代的适应度最高的点
        Lambda = iteration / max_iterations
        part_best_x = decode_chromosome(sorted_chromosomes[-1])
        part_best_fitness = f(part_best_x)
        if part_best_fitness > best_fitness:
            best_fitness = part_best_fitness
            best_x = part_best_x
        print(f'x: {part_best_x} , f(x) : {-part_best_fitness}')
        evolve_route.append(-best_fitness)
        # 灾变
        if part_best_fitness == pre_fitness:
            catastrophe_count += 1
        if catastrophe_count == catastrophe_up:
            chromosomes = sorted_chromosomes[:chromosomes_size // 2] + generate_random_chromosomes(
                chromosomes_size // 2, chromosome_length)
            catastrophe_count = 0
        pre_fitness = part_best_fitness

    # 输出结果
    print("最小值：", -best_fitness)
    print("最优解：", best_x)

    # 画图
    plt.figure()
    plt.scatter([x for x in range(1, max_iterations + 1)], evolve_route)
    plt.xlabel('Iter')
    plt.ylabel('Distance')
    plt.title('Iter-Distance')
    plt.show()

    plt.figure()
    plt.scatter(x_axis, y_axis)
    plt.plot([x_axis[x] for x in best_x], [y_axis[x] for x in best_x])
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title('Route')
    plt.show()

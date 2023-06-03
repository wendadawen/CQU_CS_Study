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
def f(x: List[float]) -> float:
    return x[0] * math.cos(2 * math.pi * x[1]) + x[1] * math.sin(2 * math.pi * x[0])


# 定义尺度化函数
def u(x: float) -> float:
    tp = (x + M)
    return tp

# 定义适应度函数
def calc_fitness(chromosome: List[str]) -> float:
    x = decode_chromosome(chromosome)
    return u(f(x))


def decode_chromosome(chromosome: List[str]) -> List[float]:
    # 将二进制字符串解码为实数值 x
    x = []
    chromosome_length = len(chromosome[0])
    chromosome_size = len(chromosome)
    for i in range(chromosome_size):
        x.append(lb[i] + (ub[i] - lb[i]) / ((1 << chromosome_length) - 1) * (int(chromosome[i], 2)))
    return x


# 定义随机种群生成函数
def generate_random_chromosomes(chromosomes_size: int, chromosome_length: int, chromosome_size: int) -> List[List[str]]:
    chromosomes = []
    for i in range(chromosomes_size):
        chromosome = ["".join([random.choice(["0", "1"]) for __ in range(chromosome_length)]) for _ in
                      range(chromosome_size)]
        chromosomes.append(chromosome)
    return chromosomes


# 定义交叉操作函数
def crossover(chromosomes: List[List[str]], crossover_rate: float) -> List[List[str]]:
    n = len(chromosomes)
    offspring_chromosomes = []
    for i in range(0, n, 2):
        offspring1, offspring2 = single_point_crossover(chromosomes[i], chromosomes[i + 1], crossover_rate)
        offspring1, offspring2 = two_point_crossover(offspring1, offspring2, crossover_rate)
        offspring_chromosomes.append(offspring1)
        offspring_chromosomes.append(offspring2)
    return offspring_chromosomes


def single_point_crossover(chromosome1: List[str], chromosome2: List[str], crossover_rate: float) -> (
        List[str], List[str]):
    chromosome_size = len(chromosome1)
    # 单点交叉
    offspring1 = []
    offspring2 = []
    for i in range(chromosome_size):
        if random.random() > crossover_rate:
            offspring1.append(chromosome1[i])
            offspring2.append(chromosome2[i])
        else:
            crossover_point = random.randint(1, len(chromosome1[0]) - 1)
            offspring1.append(chromosome1[i][:crossover_point] + chromosome2[i][crossover_point:])
            offspring2.append(chromosome2[i][:crossover_point] + chromosome1[i][crossover_point:])
    return offspring1, offspring2


def two_point_crossover(chromosome1: List[str], chromosome2: List[str], crossover_rate: float) -> (
        List[str], List[str]):
    chromosome_size = len(chromosome1)
    # 单点交叉
    offspring1 = []
    offspring2 = []
    for i in range(chromosome_size):
        if random.random() > crossover_rate:
            offspring1.append(chromosome1[i])
            offspring2.append(chromosome2[i])
        else:
            crossover_point1 = random.randint(1, len(chromosome1[0]) - 1)
            crossover_point2 = random.randint(1, len(chromosome1[0]) - 1)
            crossover_point1, crossover_point2 = sorted([crossover_point1, crossover_point2])
            offspring1.append(
                chromosome1[i][:crossover_point1] + chromosome2[i][crossover_point1: crossover_point2] + chromosome1[i][
                                                                                                         crossover_point2:])
            offspring2.append(
                chromosome2[i][:crossover_point1] + chromosome1[i][crossover_point1: crossover_point2] + chromosome2[i][
                                                                                                         crossover_point2:])
    return offspring1, offspring2


# 定义变异操作函数
def mutation(offspring_chromosomes: List[List[str]], mutation_rate: float) -> List[List[str]]:
    n = len(offspring_chromosomes)
    mutated_chromosomes = []
    for i in range(n):
        chromosome = single_point_mutation(offspring_chromosomes[i], mutation_rate)
        mutated_chromosomes.append(chromosome)
    return mutated_chromosomes


def single_point_mutation(chromosome: List[str], mutation_rate: float) -> List[str]:
    chromosome_size = len(chromosome)
    mutated_chromosome = chromosome
    for i in range(chromosome_size):
        if random.random() < mutation_rate:
            # 随机选择一个位置进行变异
            mutation_point = random.randint(0, len(chromosome[0]) - 1)
            # 将该位置的基因取反
            mutated_chromosome[i] = chromosome[i][:mutation_point] + (
                "0" if chromosome[i][mutation_point] == "1" else "1") + chromosome[i][mutation_point + 1:]
    return mutated_chromosome


# 定义更新种群函数
def update_chromosomes(sorted_chromosomes: List[List[str]], chromosomes_size: int) -> List[List[str]]:
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
    # 定义遗传算法参数
    chromosomes_size = 50  # 种群数量
    chromosome_length = 20  # 染色体长度
    chromosome_size = 2  # 染色体个数
    crossover_rate = 0.8  # 交叉概率
    mutation_rate = 0.01  # 变异概率
    max_iterations = 1000  # 最大迭代次数
    Lambda = 1  # 用来衡量迭代的深度
    lb = [-2, -2]  # x的下界
    ub = [2, 2]   # x的上界
    evolve_route = []  # 每次迭代的最大值
    catastrophe_up = 50  # 灾变上限，若最优值一直是一个值，破坏它
    # 初始化种群
    pre_fitness = None
    catastrophe_count = 0
    best_x = None
    best_fitness = -math.inf
    chromosomes = generate_random_chromosomes(chromosomes_size, chromosome_length, chromosome_size)

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
        print(f'x: {part_best_x} , f(x) : {part_best_fitness}')
        evolve_route.append(best_fitness)
        # 灾变
        if part_best_fitness == pre_fitness:
            catastrophe_count += 1
        if catastrophe_count == catastrophe_up:
            chromosomes = sorted_chromosomes[:chromosomes_size // 2] + generate_random_chromosomes(chromosomes_size // 2, chromosome_length, chromosome_size)
            catastrophe_count = 0
        pre_fitness = part_best_fitness

    # 输出结果
    print("最大值：", best_fitness)
    print("最优解：", best_x)

    # 画图
    plt.figure()
    plt.scatter([x for x in range(1, max_iterations+1)], evolve_route)
    plt.xlabel('Iter')
    plt.ylabel('Distance')
    plt.title('Iter-Distance')
    plt.show()
from typing import List
import numpy as np
import sympy
import matplotlib.pyplot as plt

# SOR迭代法求解方程组
def SOR_iteration(A: np.matrix, b: np.matrix, iter: int, w: float) -> np.matrix:
    """
    Ax = b
    :param A:
    :param b:
    :param iter: 迭代次数
    :param w: 松弛因子，0<w<2
    :return:
    """
    mat = np.concatenate((-A, b), axis=1)
    n = len(mat)
    for i in range(0, n):
        if mat[i, i] == 0:
            print("主元为0！")
            return np.mat([])
        else:
            mat[i] /= -mat[i, i]
    mat = w * mat
    for i in range(0, n):
        mat[i, i] += 1
    x = np.matrix(np.random.rand(n, 1))  # 初始值
    for it in range(1, iter + 1):
        for i in range(0, n):
            x[i, 0] = mat[i, :-1] * x + mat[i, -1]
        #print(f"第{it}次迭代的结果：\n", x)
    return x

# 最小二乘法
def least_square_fit(y: List[float], x: List[float], power: int) -> str:
    """
    最小二乘法拟合,n个插值点构造n次的插值函数
    :param y: 传入的拟合点y
    :param x: 传入的拟合点x
    :param power: 拟合的函数的次幂
    :return: 返回拟合的函数
    """
    power += 1
    A = np.mat(np.zeros((power, power)))  # Ax = b,A是一个对称正定矩阵
    b = np.mat(np.zeros((power, 1)))
    fai = [[1]*len(x)]
    for i in range(1, power):
        fai.append([fai[-1][j] * x[j] for j in range(0, len(x))])

    def dot(a: List[float], b: List[float]) -> float:
        return sum([a[i] * b[i] for i in range(len(a))])

    for i in range(0, power):
        for j in range(i, power):
            tp = dot(fai[i], fai[j])
            A[i, j] = A[j, i] = tp
        b[i, 0] = dot(y, fai[i])
    c = SOR_iteration(A=A, b=b, iter=2000, w=1.8)

    plt.scatter(x, y)
    plt.plot(x, np.polyval(c[:, 0][::-1], x), color='red')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Polynomial Regression by Least Squares Method')
    plt.show()

    ret = f'{c[0, 0]}'
    for i in range(1, power):
        if c[i, 0] < 0:
            ret += f' {c[i, 0]} * x**{i}'
        else:
            ret += f' + {c[i, 0]} * x**{i}'
    return sympy.sympify(ret)

if __name__ == '__main__':
    x = [i for i in range(1, 25)]
    y = [66, 66, 65, 64, 63, 63, 62, 61, 60, 60, 59, 58, 58, 58, 58, 57, 57, 57, 58, 60, 64, 67, 68, 58]
    print('拟合的函数是：f(x) =', least_square_fit(y, x, 3))

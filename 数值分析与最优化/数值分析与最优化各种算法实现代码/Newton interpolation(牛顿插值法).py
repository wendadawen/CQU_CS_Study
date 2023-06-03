from typing import List
import numpy as np
import sympy


def Newton_interpolation(y:List[float], x: List[float]) -> str:
    """
    牛顿插值法,n个插值点构造n次的插值函数
    :param y: 传入的插值点y
    :param x: 传入的插值点x
    :return: 返回插值的函数
    """
    n = len(x)  # 插值点的个数
    # 构建差商表
    tab = np.zeros((n, n))
    tab[:, 0] = y[:]
    for j in range(1, n):
        for i in range(j, n):
            tab[i, j] = (tab[i, j - 1] - tab[i - 1, j - 1]) / (x[i] - x[i - j])
    print('差商表：\n', tab)
    p = tab[0, 0]
    s = 1
    t = sympy.symbols('x')
    for i in range(1, n):
        s *= (t - x[i-1])
        p = p + tab[i, i] * s
    print(type(sympy.expand(p)))
    return sympy.expand(p)


if __name__ == '__main__':
    x = [-1, 1, 2]
    y = [2, 1, 1]
    print('牛顿插值函数是：f(x) =', Newton_interpolation(y=y, x=x))
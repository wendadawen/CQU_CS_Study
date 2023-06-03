from functools import reduce
from typing import List
import sympy


def lagrange_interpolation(y:List[float], x: List[float]) -> str:
    """
    拉格朗日插值法,n个插值点构造n次的插值函数
    :param y: 传入的插值点y
    :param x: 传入的插值点x
    :return: 返回插值的函数
    """
    n = len(x)  # 插值点的个数
    t = sympy.symbols('x')
    l_up = f'(x - {x[0]})'
    for elem in x[1:]:
        l_up += f'*(x - {elem})'
    l_up = sympy.sympify(l_up)
    l = []
    for i in range(0, n):
        l_down = reduce(lambda v1, v2: v1*v2, [x[i] - x[j] for j in range(0, n) if i != j])
        l.append(l_up / (t - x[i]) / l_down)
    p = 0
    for i in range(0, n):
        p = p + l[i] * y[i]
    return sympy.expand(p)

if __name__ == '__main__':
    x = [-1, 1, 2]
    y = [2, 1, 1]
    print('拉格朗日插值函数是：f(x) =', lagrange_interpolation(y=y, x=x))
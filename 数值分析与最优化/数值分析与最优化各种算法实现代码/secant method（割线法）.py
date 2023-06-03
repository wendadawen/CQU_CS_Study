from typing import List
import sympy
from numpy import inf


def secant_method(y: str, x: List[float], iter: int) -> float:
    """
    :param y: "cos(x) + x**2 + sin(x)"
    :param x: 初始值, [x0, x1]，传入两个
    :param iter: 迭代次数
    :return:
    """
    y = sympy.sympify(y)  # 转化sympy.sympify对象

    x0 = x[0]
    y0 = sympy.N(y.subs('x', x[0]))
    xn = x[1]

    for it in range(1, iter + 1):
        yn = sympy.N(y.subs('x', xn))
        xn = xn - (xn - x0) / (yn - y0) * sympy.N(y.subs('x', xn))
        print(f"第{it}次迭代结果：", xn)
    return xn


if __name__ == '__main__':
    print(secant_method(y='x**3 - x**2 - 1', x=[1.5, 2.0], iter=10))

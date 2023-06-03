import sympy
from numpy import inf


def Newton_downhill_method(y: str, x: float, iter: int, Lambda: float) -> float:
    """
    :param y: "cos(x) + x**2 + sin(x)"
    :param x: 初始值
    :param iter: 迭代次数
    :return:
    """
    y = sympy.sympify(y)  # 转化sympy.sympify对象
    dy = sympy.diff(y, sympy.symbols('x'))  # 导数

    y_pre = inf
    for it in range(1, iter + 1):
        y_now = sympy.N(y.subs('x', x))
        x1 = x - y_now / sympy.N(dy.subs('x', x))
        if y_pre > abs(y_now):
            x = x1
        else:
            x = Lambda * x1 + (1 - Lambda) * x
        print(f"第{it}次迭代结果：", x)
    return x


if __name__ == '__main__':
    print(Newton_downhill_method(y='x**3 - x**2 - 1', x=1.5, iter=10, Lambda=0.9))

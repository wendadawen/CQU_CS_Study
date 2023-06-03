import sympy


def Newton_method(y: str, x: float, iter: int) -> float:
    """
    :param y: "cos(x) + x**2 + sin(x)"
    :param x: 初始值
    :param iter: 迭代次数
    :return:
    """
    y = sympy.sympify(y)  # 转化sympy.sympify对象
    dy = sympy.diff(y, sympy.symbols('x'))  # 导数
    for it in range(1, iter + 1):
        x = x - sympy.N(y.subs('x', x)) / sympy.N(dy.subs('x', x))
        print(f"第{it}次迭代结果：", x)
    return x


if __name__ == '__main__':
    print(Newton_method(y='x**3 - x**2 - 1', x=1.5, iter=10))

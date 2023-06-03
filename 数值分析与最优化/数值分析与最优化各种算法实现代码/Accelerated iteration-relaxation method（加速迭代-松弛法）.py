import sympy


def relaxation_method(fai: str, x: float, iter: int) -> float:
    """
    :param fai: "cos(x) + x**2 + sin(x)"
    :param x: 初始值
    :param iter: 迭代次数
    :return:
    """
    fai = sympy.sympify(fai)  # 转化sympy.sympify对象
    d_fai = sympy.diff(fai, sympy.symbols('x'))  # 对每个变量的偏导数
    for it in range(1, iter + 1):
        w = 1 / (1 - sympy.N(d_fai.subs('x', x)))
        x1 = sympy.N(fai.subs('x', x))
        x = (1 - w) * x + w * x1
        print(f"第{it}次迭代结果：", x)
    return x

if __name__ == '__main__':
    print(relaxation_method(fai='1 + 1 / (x**2)', x=1.5, iter=10))
    print("________________________________")
    print(relaxation_method(fai='(1 + x**2)**(1/3)', x=1.5, iter=10))
    print("________________________________")
    print(relaxation_method(fai='sqrt(1 / (x - 1))', x=1.5, iter=10))
    print("________________________________")
    print(relaxation_method(fai='sqrt(x**3 - 1)', x=1.5, iter=10))

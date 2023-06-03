import sympy


def Atiken_method(fai: str, x: float, iter: int) -> float:
    """
    :param fai: "cos(x) + x**2 + sin(x)"
    :param x: 初始值
    :param iter: 迭代次数
    :return:
    """
    fai = sympy.sympify(fai)  # 转化sympy.sympify对象
    for it in range(1, iter + 1):
        y = sympy.N(fai.subs('x', x))
        z = sympy.N(fai.subs('x', y))
        if z - 2 * y + x == 0:
            return x
        x = x - (y - x)**2 / (z - 2 * y + x)
        print(f"第{it}次迭代结果：", x)
    return x

if __name__ == '__main__':
    print(Atiken_method(fai='1 + 1 / (x**2)', x=1.5, iter=10))
    print("________________________________")
    print(Atiken_method(fai='(1 + x**2)**(1/3)', x=1.5, iter=10))
    print("________________________________")
    print(Atiken_method(fai='sqrt(1 / (x - 1))', x=1.5, iter=10))
    print("________________________________")
    print(Atiken_method(fai='sqrt(x**3 - 1)', x=1.5, iter=10))

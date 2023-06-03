from typing import List
import sympy


# 注意目标函数满足连续可导
def gradient_descent(y: str, x: List[float], iter: int, alpha: float) -> List[float]:
    """
    梯度下降法
    例子：三元函数
    y = "cos(x1) + x1**2 + sin(x2) - x3**2"
    x = [1, 2, 3]
    :param y: 多元变量请（x1,x2,x3...）
    :param x: 初始值，多元变量
    :param iter: 迭代次数
    :param alpha: 学习率
    :return: 返回迭代结果
    """
    n = len(x)  # 变量个数
    y = sympy.sympify(y)  # 转化sympy.sympify对象
    dy = []  # 对每个变量的偏导数
    x_var = []  # 多元变量的symbol
    for i in range(1, n + 1):
        x_var.append(sympy.symbols('x' + str(i)))
        dy.append(sympy.diff(y, x_var[-1]))
    print("偏导函数：", dy)
    for i in range(0, iter):
        x_val = [(x_var[i], x[i]) for i in range(0, n)]
        x = [sympy.N(x[i] - alpha * dy[i].subs(x_val)) for i in range(0, n)]  # N函数将符号结果转化为数值结果
        print(f"第{i+1}次迭代：", x)
    return x


if __name__ == '__main__':
    x = [1, 2, 3]
    y = "cos(x1) + x1**2 + sin(x2) - x3**2"
    gradient_descent(y=y, x=x, iter=100, alpha=0.3)

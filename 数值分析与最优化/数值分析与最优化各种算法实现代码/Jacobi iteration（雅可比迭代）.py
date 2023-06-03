import numpy as np


def Jacobi_iteration(A: np.matrix, b: np.matrix, iter: int)->np.matrix:
    mat = np.concatenate((-A, b), axis=1)
    n = len(mat)
    for i in range(0, n):
        if mat[i, i] == 0:
            print("主元为0！")
            return np.mat([])
        else:
            mat[i] /= -mat[i, i]
            mat[i, i] = 0
    x = np.matrix(np.random.rand(n, 1))  # 初始值
    for it in range(1, iter + 1):
        x = mat[:, :-1] * x + mat[:, -1]
        print(f"第{it}次迭代的结果：\n", x)
    return x

if __name__ == '__main__':
    A = np.mat([[10, -1, -2],
                  [-1, 10, -2],
                  [-1, -1, 5]], dtype="float64")
    b = np.mat([[7.2], [8.3], [4.2]], dtype="float64")
    Jacobi_iteration(A, b, 20)
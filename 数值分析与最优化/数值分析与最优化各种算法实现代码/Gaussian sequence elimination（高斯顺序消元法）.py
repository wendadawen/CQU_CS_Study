import numpy as np

def Gaussian_sequence_elimination(A: np.matrix, b: np.matrix)->np.matrix:
    """
    高斯顺序消元法
    Ax = b
    :param A: 系数矩阵
    :param b: 参数矩阵
    :return: 结果X
    """
    # 将两个矩阵沿着列方向拼接
    mat = np.concatenate((A, b), axis=1)
    print("初始的方程组的矩阵：")
    print(mat)
    n = len(b)
    for i in range(1, n):
        if mat[i, i] ==  0:
            print("消元过程中出现主元为0的情况，不能使用高斯顺序消元法！")
            return np.mat([])
        else:
            mat[i:, i-1:] -= (mat[i:, i-1] / mat[i-1, i-1]) * mat[i-1, i-1:]
    print("高斯顺序消元后的矩阵:")
    print(mat)
    # 回代
    x = np.matrix(np.random.rand(n, 1))
    x[n-1, 0] = mat[n-1, n] / mat[n-1, n-1]
    for i in range(n-2, -1, -1):
        x[i, 0] = (mat[i, n] - mat[i, i+1: n] * x[i+1:, 0]) / mat[i, i]
    return x

if __name__ == '__main__':
    matrix_a = np.mat([
        [2.0, 1.0, 2.0],
        [5.0, -1.0, 1.0],
        [1.0, -3.0, -4.0]], dtype=float)
    matrix_b = np.mat([5, 8, -4], dtype=float).T
    print("该方程组的解：\n", Gaussian_sequence_elimination(matrix_a, matrix_b))

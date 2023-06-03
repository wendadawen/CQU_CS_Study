import numpy as np
import  copy


def LU_decomposition_of_a_matrix(mat: np.matrix) -> (np.matrix, np.matrix):
    """
    矩阵的LU分解，返回L和U矩阵
    :param mat: 待分解的矩阵
    :return: (L, U)
    """
    U = copy.copy(mat)
    n = len(U)
    L = np.matrix(np.identity(n))
    for i in range(1, n):
        if U[i, i] == 0:
            print("消元分解过程中出现主元为0的情况，该矩阵不能LU分解！")
            return np.mat([])
        else:
            L[i:, i - 1] = U[i:, i - 1] / U[i-1, i-1]
            U[i:, i - 1:] -= L[i:, i - 1] * U[i - 1, i - 1:]

    return L, U

if __name__ == '__main__':
    matrix_a = np.mat([
        [2.0, 1.0, 2.0],
        [5.0, -1.0, 1.0],
        [1.0, -3.0, -4.0]], dtype=float)

    L, U = LU_decomposition_of_a_matrix(matrix_a)
    print("L矩阵:\n", L)
    print("U矩阵:\n", U)

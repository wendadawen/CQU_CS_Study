import numpy as np
import math


# 矩阵的列范式
def column_norm(mat: np.matrix) -> float:
    return max([sum([abs(mat[i, j]) for i in range(mat.shape[0])]) for j in range(mat.shape[1])])


# 矩阵的行范数
def row_norm(mat: np.matrix) -> float:
    return max([sum([abs(mat[i, j]) for j in range(mat.shape[1])]) for i in range(mat.shape[0])])


# 矩阵的2-范数
def two_norm(mat: np.matrix) -> float:
    return math.sqrt(max(np.linalg.eig(mat.T * mat)[0]))


# F-范数
def F_norm(mat: np.matrix) -> float:
    return math.sqrt(np.sum(np.multiply(mat, mat)))


if __name__ == '__main__':
    mat = np.mat([
        [1, -2],
        [-3, 4]
    ])
    print(column_norm(mat))
    print(row_norm(mat))
    print(two_norm(mat))
    print(F_norm(mat))
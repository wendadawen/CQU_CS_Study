#pragma once//防止头文件重复包含
#include <iostream>
#include <vector>
using namespace std;

class Fraction
{
	friend Fraction  operator+(const Fraction& frac1, const Fraction& frac2);//运算符重载加号
	friend Fraction  operator-(const Fraction& frac1, const Fraction& frac2);//运算符重载减号
	friend Fraction  operator*(const Fraction& frac1, const Fraction& frac2);//运算符重载乘号
	friend Fraction  operator/(const Fraction& frac1, const Fraction& frac2);//运算符重载除号
	friend bool operator==(const Fraction& frac1, const Fraction& frac2);//运算符重载==
	friend bool operator>(const Fraction& frac1, const Fraction& frac2);//运算符重载>
	friend bool operator<(const Fraction& frac1, const Fraction& frac2);//运算符重载<
	friend ostream& operator<<(ostream& cout, const Fraction& frac);//运算符重载输出
	friend istream& operator>>(istream& cin, Fraction& frac);//运算符重载输入
public:

	//初始化与结束操作
	Fraction();//无参构造函数
	Fraction(int n, int d);//有参构造函数
	Fraction(const Fraction& frac);//复制构造函数
	~Fraction();//析构函数

	//分数的设置与获取
	void setFraction(int n, int d);//设置分子分母
	int getNumer();//获取分子
	int getDeno();//获取分母
	void RdcFrac();//约分

	//软件功能
	void ExitSystem();//退出软件
	void FractionSort();//分数排序
	void FractionCalculate();//分数计算
private:

	//Fraction的元素
	int numer;//分子
	int deno;//分母
};
#pragma once//��ֹͷ�ļ��ظ�����
#include <iostream>
#include <vector>
using namespace std;

class Fraction
{
	friend Fraction  operator+(const Fraction& frac1, const Fraction& frac2);//��������ؼӺ�
	friend Fraction  operator-(const Fraction& frac1, const Fraction& frac2);//��������ؼ���
	friend Fraction  operator*(const Fraction& frac1, const Fraction& frac2);//��������س˺�
	friend Fraction  operator/(const Fraction& frac1, const Fraction& frac2);//��������س���
	friend bool operator==(const Fraction& frac1, const Fraction& frac2);//���������==
	friend bool operator>(const Fraction& frac1, const Fraction& frac2);//���������>
	friend bool operator<(const Fraction& frac1, const Fraction& frac2);//���������<
	friend ostream& operator<<(ostream& cout, const Fraction& frac);//������������
	friend istream& operator>>(istream& cin, Fraction& frac);//�������������
public:

	//��ʼ�����������
	Fraction();//�޲ι��캯��
	Fraction(int n, int d);//�вι��캯��
	Fraction(const Fraction& frac);//���ƹ��캯��
	~Fraction();//��������

	//�������������ȡ
	void setFraction(int n, int d);//���÷��ӷ�ĸ
	int getNumer();//��ȡ����
	int getDeno();//��ȡ��ĸ
	void RdcFrac();//Լ��

	//�������
	void ExitSystem();//�˳����
	void FractionSort();//��������
	void FractionCalculate();//��������
private:

	//Fraction��Ԫ��
	int numer;//����
	int deno;//��ĸ
};
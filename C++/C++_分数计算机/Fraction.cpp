#include "Fraction.h"


//�������캯��
Fraction::Fraction()
{
	this->numer = 1;
	this->deno = 1;
}
Fraction::Fraction(int n, int d=1 )
{
		this->numer = n;
		this->deno = d;
}
Fraction::Fraction(const Fraction& frac)
{
	*this = frac;
}


//��������
Fraction::~Fraction()
{

}


//���÷����ķ��Ӻͷ�ĸ
void Fraction::setFraction(int n, int d=1)
{
		this->numer = n;
		this->deno = d;
}


//������ȡ�����ķ���
int Fraction::getNumer()
{
	return this->numer;
}


//������ȡ�����ķ�ĸ
int Fraction::getDeno()
{
	if (this->deno == 0)
	{
		throw ("��ĸ����Ϊ�㣡���������룡");
	}
	return this->deno;
}


//�����ļӼ��˳�
Fraction operator+(const Fraction& frac1, const Fraction& frac2)//�ӷ�
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.deno + frac2.numer * frac1.deno;
	temp.deno = frac1.deno * frac2.deno;
	temp.RdcFrac();
	return temp;
}
Fraction operator-(const Fraction& frac1, const Fraction& frac2)//����
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.deno - frac2.numer * frac1.deno;
	temp.deno = frac1.deno * frac2.deno;
	temp.RdcFrac();
	return temp;
}
Fraction operator*(const Fraction& frac1, const Fraction& frac2)//�˷�
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.numer;
	temp.deno = frac1.deno * frac2.deno;
	temp.RdcFrac();
	return temp;
}
Fraction operator/(const Fraction& frac1, const Fraction& frac2)//����
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.deno;
	temp.deno = frac1.deno * frac2.numer;
	temp.RdcFrac();
	return temp;
}


//�������߼������
bool operator==(const Fraction& frac1, const Fraction& frac2)//���ڵ��ж�
{
	Fraction temp1, temp2;
	temp1 = frac1; temp1.RdcFrac();
	temp2 = frac2; temp2.RdcFrac();
	if (temp1.deno==temp2.deno&&temp1.numer==temp2.numer)
	{
		return true;
	}
	else
	{
		return false;
	}
}
bool operator>(const Fraction& frac1, const Fraction& frac2)//���ڵ��ж�
{
	Fraction temp01, temp02;
	temp01 = frac1;
	temp02 = frac2;
	temp01.numer = temp01.numer * temp02.deno;
	temp02.numer = temp02.numer * temp01.deno;
	return temp01.numer > temp02.numer;
}
bool operator<(const Fraction& frac1, const Fraction& frac2)//С�ڵ��ж�
{
	Fraction temp01, temp02;
	temp01 = frac1;
	temp02 = frac2;
	temp01.numer = temp01.numer * temp02.deno;
	temp02.numer = temp02.numer * temp01.deno;
	return temp01.numer < temp02.numer;
}


//�������������
ostream& operator<<(ostream& cout, const Fraction& frac)//����������
{
	if (frac.deno == 1)
	{
		cout << frac.numer ;
	}
	else if(frac.deno==0)
	{
		return cout;
	}
	else
	    cout << frac.numer << "/" << frac.deno ;
	return cout;
}
istream& operator>>(istream& cin, Fraction& frac)
{
	char ch = '/',temp_01;
	cin >> frac.numer >> ch >> frac.deno;
	try
	{
		temp_01=ch;
		if (temp_01 != '/')
			throw("����������������Զ�ת��Ϊ��/��");
	}
	catch (const char* err)
	{
		cout << err << endl;
	}
	return cin;
}


//������Լ��
void Fraction::RdcFrac()
{
		int min = 0, max = 0;
		if (this->numer > this->deno)
		{
			min = this->deno;
			max = this->numer;
		}
		else
		{
			min = this->numer;
			max = this->deno;
		}
		int temp = 0;
		for (int i = min; i > 0; i--)
		{
			if (max % i == 0 && min % i == 0)
			{
				temp = i;
				break;
			}
		}
		this->deno /= temp;
		this->numer /= temp;
}


//�˳����
void Fraction::ExitSystem()
{
	cout << "��ӭ�´�ʹ��" << endl;
	system("pause");
	exit(0);
}



//��������
void Fraction::FractionCalculate()
{
	while (true)
	{
		cout << "�������������ʽ ����1/2+1/3�س���������#�ż�������һ��Ŀ¼������q�˳�����" << endl;
		Fraction Frac1;
		Fraction Frac2;
		char str,temp_01,temp_02;
		if (!(cin >> Frac1 >> str >> Frac2))
		{
			str = getchar();//��ȡ�������ַ�
			cin.clear();//����������־λ
			cin.ignore(9999, '\n');//��ջ�����
			if (str == '#')
			{
				system("cls");
				break;
			}
			else if (str == 'q')
			{
				cout << "��ӭ�´�ʹ��" << endl;
				system("pause");
				exit(0);
			}
			else
			{
				cout << "����������������룡" << endl;
				continue;
			}
		}
		temp_01 = str;

 		try
		{
			Frac1.getDeno();
			Frac2.getDeno();
			temp_01 =str;
			if (temp_01 != '/' && temp_01 != '*' && temp_01 != '-' && temp_01 != '+')
				throw 1;
		}
		catch (const char * err)
		{
			cout << err <<endl;
			continue;
		}
		catch (const int a)
		{
			cout << "�����������������������룡" << endl;
			continue;
		}

		if (str == '+')
		{
				cout << "=" << Frac1 + Frac2 << endl;
		}
		else if (str == '-')
		{
				cout << "=" << Frac1 - Frac2 << endl;
		}
		else if (str == '*')
		{
				cout << "=" << Frac1 * Frac2 << endl;
		}
		else if (str == '/')
		{
				cout << "=" << Frac1 / Frac2 << endl;
		}
		else
		{
			cout << "��������������,����������!" << endl;
		}
	}
}


//����������
void Fraction::FractionSort()
{
	while (true)
	{
	L2:
		bool flag = false;
		vector <Fraction> frac;
		Fraction hn;
		cout << "������һ��������ö��Ÿ�����������С���������÷���<��β���ɴ�С�����÷���>��β����1 / 2��1 / 4��3 / 5<�س�>)����" << endl;
		cout << "����#�ż�������һ��Ŀ¼,����q�˳�����" << endl;
		
		char ch;
		//�������
		while (true)
		{
			if (!(cin >> hn >> ch))
			{
				ch = getchar();
				cin.clear();
				cin.ignore(9999, '\n');
				frac.clear();
				if (ch == '#')
				{
					system("cls");
					flag = true;
					break;
				}
				else if (ch == 'q')
				{
					cout << "��ӭ�´�ʹ��" << endl;
					system("pause");
					exit(0);
				}
				else if (ch != '#')
				{
					cout << "����������������룡" << endl;
					goto L2;
				}
			}
			if (ch == ',')
			{
				frac.push_back(hn);
			}
			else if (ch == '>' || ch == '<')
			{
				frac.push_back(hn);
				break;
			}
			else
			{
				cout << "�����������������һ�������" << endl;
				goto L2;
			}
		}
		if (flag)
		{
			break;
		}

		//�����ϵ����
		if (ch == '<')
		{
			Fraction min_frac = frac[0];
			for (int i = 0; i < frac.size()-1; i++)//ð����������
			{
				for (int j = 0; j < frac.size() - 1 - i; j++)
				{
					if (frac[j] > frac[j + 1])
					{
						Fraction temp = frac[j];
						frac[j] = frac[j + 1];
						frac[j + 1] = temp;
					}
				}
			}
		}
		else if (ch == '>')
		{
			Fraction min_frac = frac[0];
			for (int i = 0; i < frac.size() - 1; i++)//ð�����򣬽���
			{
				for (int j = 0; j < frac.size() - 1 - i; j++)
				{
					if (frac[j] < frac[j + 1])
					{
						Fraction temp = frac[j];
						frac[j] = frac[j + 1];
						frac[j + 1] = temp;
					}
				}
			}
		}
		for (int i = 0; i < frac.size(); i++)
		{
			if (i != frac.size()-1)
			{
				cout << frac[i]<<" ";
			}
			else if(i==frac.size()-1)
			{
				cout << frac[i] << endl;
			}
		}
	}
}

#include "Fraction.h"


//三个构造函数
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


//析构函数
Fraction::~Fraction()
{

}


//设置分数的分子和分母
void Fraction::setFraction(int n, int d=1)
{
		this->numer = n;
		this->deno = d;
}


//单独获取分数的分子
int Fraction::getNumer()
{
	return this->numer;
}


//单独获取分数的分母
int Fraction::getDeno()
{
	if (this->deno == 0)
	{
		throw ("分母不能为零！请重新输入！");
	}
	return this->deno;
}


//分数的加减乘除
Fraction operator+(const Fraction& frac1, const Fraction& frac2)//加法
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.deno + frac2.numer * frac1.deno;
	temp.deno = frac1.deno * frac2.deno;
	temp.RdcFrac();
	return temp;
}
Fraction operator-(const Fraction& frac1, const Fraction& frac2)//减法
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.deno - frac2.numer * frac1.deno;
	temp.deno = frac1.deno * frac2.deno;
	temp.RdcFrac();
	return temp;
}
Fraction operator*(const Fraction& frac1, const Fraction& frac2)//乘法
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.numer;
	temp.deno = frac1.deno * frac2.deno;
	temp.RdcFrac();
	return temp;
}
Fraction operator/(const Fraction& frac1, const Fraction& frac2)//除法
{
	Fraction temp;
	temp.numer = frac1.numer * frac2.deno;
	temp.deno = frac1.deno * frac2.numer;
	temp.RdcFrac();
	return temp;
}


//分数的逻辑运算符
bool operator==(const Fraction& frac1, const Fraction& frac2)//等于的判断
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
bool operator>(const Fraction& frac1, const Fraction& frac2)//大于的判断
{
	Fraction temp01, temp02;
	temp01 = frac1;
	temp02 = frac2;
	temp01.numer = temp01.numer * temp02.deno;
	temp02.numer = temp02.numer * temp01.deno;
	return temp01.numer > temp02.numer;
}
bool operator<(const Fraction& frac1, const Fraction& frac2)//小于的判断
{
	Fraction temp01, temp02;
	temp01 = frac1;
	temp02 = frac2;
	temp01.numer = temp01.numer * temp02.deno;
	temp02.numer = temp02.numer * temp01.deno;
	return temp01.numer < temp02.numer;
}


//分数的输入输出
ostream& operator<<(ostream& cout, const Fraction& frac)//分数的输入
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
			throw("分数符号输入错误！自动转化为‘/’");
	}
	catch (const char* err)
	{
		cout << err << endl;
	}
	return cin;
}


//分数的约分
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


//退出软件
void Fraction::ExitSystem()
{
	cout << "欢迎下次使用" << endl;
	system("pause");
	exit(0);
}



//分数计算
void Fraction::FractionCalculate()
{
	while (true)
	{
		cout << "请输入分数计算式 （如1/2+1/3回车），输入#号键返回上一层目录，输入q退出程序：" << endl;
		Fraction Frac1;
		Fraction Frac2;
		char str,temp_01,temp_02;
		if (!(cin >> Frac1 >> str >> Frac2))
		{
			str = getchar();//提取缓存区字符
			cin.clear();//清除流对象标志位
			cin.ignore(9999, '\n');//清空缓存区
			if (str == '#')
			{
				system("cls");
				break;
			}
			else if (str == 'q')
			{
				cout << "欢迎下次使用" << endl;
				system("pause");
				exit(0);
			}
			else
			{
				cout << "输入错误！请重新输入！" << endl;
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
			cout << "运算符号输入错误！请重新输入！" << endl;
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
			cout << "运算符号输入错误,请重新输入!" << endl;
		}
	}
}


//分数的排序
void Fraction::FractionSort()
{
	while (true)
	{
	L2:
		bool flag = false;
		vector <Fraction> frac;
		Fraction hn;
		cout << "请输入一组分数，用逗号隔开，如需由小到大排序用符号<结尾，由大到小排序用符号>结尾（如1 / 2，1 / 4，3 / 5<回车>)，请" << endl;
		cout << "输入#号键返回上一层目录,输入q退出程序：" << endl;
		
		char ch;
		//输入分数
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
					cout << "欢迎下次使用" << endl;
					system("pause");
					exit(0);
				}
				else if (ch != '#')
				{
					cout << "输入错误！请重新输入！" << endl;
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
				cout << "输入错误！请重新输入一组分数！" << endl;
				goto L2;
			}
		}
		if (flag)
		{
			break;
		}

		//输入关系符号
		if (ch == '<')
		{
			Fraction min_frac = frac[0];
			for (int i = 0; i < frac.size()-1; i++)//冒泡排序，升序
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
			for (int i = 0; i < frac.size() - 1; i++)//冒泡排序，降序
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

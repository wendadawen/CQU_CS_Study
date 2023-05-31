#include <iostream>
using namespace std;
#include "Fraction.h"
int main()
{
	while (true)
	{
		//创建负责调用软件功能的对象manager
		Fraction manager;

		cout << "请选择功能 （键入1或者2或者0）：" << endl;
		cout << "0.退出程序" << endl;
		cout << "1.分数计算" << endl;
		cout << "2.分数排序" << endl;

		//用户输入选项
		int choic =0;
		if (!(cin >> choic))
		{
			cin.clear();
			cin.ignore(9999, '\n');
			system("cls");
			cout << "输入错误,输入任意键返回上一步操作" << endl;
			system("pause");
			continue;
		}
		switch (choic)
		{
		case 0://退出功能
			manager.ExitSystem();
			break;
		case 1://计算功能
			manager.FractionCalculate();
			break;
		case 2://排序功能
			manager.FractionSort();
			break;
		default:
			cout << "输入错误,输入任意键返回上一步操作" << endl;
			system("pause");//按任意键继续
			system("cls");//清屏
			break;
		};
	}
	system("pause");
	return 0;
}
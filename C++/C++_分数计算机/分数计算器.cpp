#include <iostream>
using namespace std;
#include "Fraction.h"
int main()
{
	while (true)
	{
		//�����������������ܵĶ���manager
		Fraction manager;

		cout << "��ѡ���� ������1����2����0����" << endl;
		cout << "0.�˳�����" << endl;
		cout << "1.��������" << endl;
		cout << "2.��������" << endl;

		//�û�����ѡ��
		int choic =0;
		if (!(cin >> choic))
		{
			cin.clear();
			cin.ignore(9999, '\n');
			system("cls");
			cout << "�������,���������������һ������" << endl;
			system("pause");
			continue;
		}
		switch (choic)
		{
		case 0://�˳�����
			manager.ExitSystem();
			break;
		case 1://���㹦��
			manager.FractionCalculate();
			break;
		case 2://������
			manager.FractionSort();
			break;
		default:
			cout << "�������,���������������һ������" << endl;
			system("pause");//�����������
			system("cls");//����
			break;
		};
	}
	system("pause");
	return 0;
}
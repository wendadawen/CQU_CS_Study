import pandas as pd
import os
import csv
import re

'''
一些说明：
    小组成员：文红兵，苟书祥，牟正强，耿协铭
    1、文件统一编码为：UTF-8
    2、sql语句请严格符合以下例子，关键词请大写，其他小写，空格严格遵守以下例子：
            create_database :   CREATE DATABASE demo ;
            create_table :      CREATE TABLE demo.demo_table (name varchar(50),age int,gender varchar(1)) ;
            insert :            INSERT INTO demo.demo_table VALUES (张三,21,男) ;
            delete :            DELETE FROM demo.demo_table WHERE name=张三 ;
            update :            UPDATE demo.demo_table SET name=李四,age=18 WHERE name=张三 ;
            query :             SELECT name,age,gender FROM demo.demo_table WHERE name=张三 and age=21 ;
                          或者   SELECT name,age,gender FROM demo.demo_table ;  # 查询全部结果
'''


def create_database(sql):
    """
    创建数据库，直接在当前路径(当前.py文件所在路径)下创建数据库
    :param sql: CREATE DATABASE demo ;
    :return: None
    """
    database_name = sql[16:-1].strip()
    if not os.path.exists(database_name):
        os.mkdir(database_name)
        print(f'{database_name}数据库成功创建！')
    else:
        print(f'{database_name}数据库已经存在！')  # 数据库不能重名


def create_table(sql):
    """
    新建一个表
    :param sql: CREATE TABLE demo.demo_table (name varchar(50),age int,gender varchar(1)) ;
    :return: None
    """
    index_Dot, index_bracket = sql.index('.'), sql.index('(')
    attributes_all = sql[index_bracket + 1:-3]
    attributes_respect = attributes_all.split(',')
    attributes_list = []
    for attributes in attributes_respect:
        idx = attributes.index(' ')
        attributes_list.append(attributes[:idx])
    database_name = sql[13:index_Dot + 1]
    table_name = sql[index_Dot + 1: index_bracket - 1]
    table_path = './' + database_name + '/' + table_name + '.csv'
    if os.path.exists(table_path):
        print(f"表{table_name}已经存在！")
    else:
        with open(table_path, 'w', newline='', encoding='UTF-8') as file:
            writer = csv.writer(file)
            writer.writerow(attributes_list)
            print(f"表{table_name}创建成功！")


def insert(sql):
    """
    向表中插入数据
    :param sql: INSERT INTO demo.demo_table VALUES (张三,21,男) ;
    :return: None
    """
    idx_dot, idx_bracket = sql.index('.'), sql.index('(')
    database = sql[12:idx_dot]  # 获取数据库名
    if os.path.exists(database):
        table_name = sql[idx_dot + 1:idx_bracket - 8]  # 获取表名
        table_path = './' + database + '/' + table_name + '.csv'
        if os.path.exists(table_path):
            values = sql[idx_bracket + 1:-3].split(',')
            with open(table_path, 'a', newline='', encoding='UTF-8') as file:
                writer = csv.writer(file)
                writer.writerow(values)  # 将数据写入最后一行
                print("数据插入成功！")
        else:
            print("数据库" + database + "不存在表" + table_name + "!")
    else:
        print("不存在数据库" + database + "!")


def delete(sql):
    """
    数据库删除记录
    注意：代码中delete_row应修改为=where(sql),返回的是行数，在这里，csv文件属性名行为第0行,数据是第1行
    :param sql: DELETE FROM demo.demo_table WHERE name=张三 ;
    :return: None
    """
    idx_dot = sql.index('.')
    database = sql[12:idx_dot]  # 获取数据库名
    table_name = sql[idx_dot + 1:].split(' WHERE')[0]  # 获取表名
    if os.path.exists(database):
        table_path = './' + database + '/' + table_name + '.csv'
        if os.path.exists(table_path):
            delete_row = where(sql)
            if not delete_row:  # 删除的行不存在
                print('数据不存在！')
                return None
            delete_rowNew = [num - 1 for num in delete_row]  # 适应python的编号
            data = pd.read_csv(table_path, encoding='UTF-8')  # 用pandas读入数据
            data.drop(delete_rowNew, inplace=True)  # 输出指定delete_row中对应的行
            data.dropna(inplace=True)  # 删除空行
            data.to_csv(table_path, index=False, encoding='UTF-8')  # 覆盖写
            print("数据删除成功！")
        else:
            print("数据库" + database + "不存在表" + table_name + "!")
    else:
        print("不存在数据库" + database + "!")


def update(sql):
    """
    update更新数据库语句
    :param sql: UPDATE demo.demo_table SET name=李四,age=18 WHERE name=张三 ;
    :return: None
    """
    idx_dot = sql.index('.')
    database = sql[7:idx_dot]  # 获取数据库名
    table_name = sql[idx_dot + 1:].split(' SET')[0]  # 获取表名
    if os.path.exists(database):
        table_path = './' + database + '/' + table_name + '.csv'
        if os.path.exists(table_path):
            update_row = where(sql)
            if not update_row:  # 更新的行不存在
                print('数据不存在！')
                return None
            condition = re.findall(r'SET(.*?)WHERE', sql)[0].strip()
            conditions = condition.split(',')
            dict = {item.split('=')[0]: item.split('=')[1] for item in conditions}
            data = pd.read_csv(table_path, encoding='UTF-8')
            for i in update_row:
                for key, value in dict.items():
                    data.loc[i - 1, key] = value
            data.to_csv(table_path, index=False, encoding='UTF-8')
            print("数据更新成功！")
        else:
            print("数据库" + database + "不存在表" + table_name + "!")
    else:
        print("不存在数据库" + database + "!")


def query(sql):
    """
    查询语句
    :param sql: SELECT name,age,gender FROM demo.demo_table WHERE name=张三 and age=21 ;
        或者     SELECT name,age,gender FROM demo.demo_table ;  # 查询全部结果
    :return:  None
    """

    # attribute : 列表，这条语句就是：[name, age, grade]
    attribute = sql.split('FROM')[0].split('SELECT')[1].strip().split(',')

    # database_name: 数据库的名字  table_name : 表的名字
    if 'WHERE' in sql:
        temp = sql.split('FROM')[1].split('WHERE')[0].strip().split(',')
    else:
        temp = sql.split('FROM')[1].split(';')[0].strip().split(',')

    # 处理多表联查，将联查的结果放在temp文件下，同时修改sql语句，方便where查询处理
    path = '.\\temp\\temp.csv'
    if not os.path.exists('.\\temp'):  # 创建临时的文件夹
        os.makedirs('.\\temp')
    fp = open(path, 'w')  # 相当于清空temp文件 或者 创建temp文件
    fp.close()
    columns = []  # 多表联查的属性
    content = [[]]  # 多表联查的内容
    for s in temp:
        tp = s.split('.')
        database_name = tp[0]
        table_name = tp[1]
        if not os.path.exists(database_name):
            print(f"{database_name}数据库不存在！")
            return None
        if not os.path.exists(f".\\{database_name}\\{table_name}.csv"):
            print(f"{table_name}表不存在！")
            return None
        path = '.\\' + database_name + '\\' + table_name + '.csv'
        data = pd.read_csv(path, encoding='UTF-8')
        columns += list(data.columns)
        content_temp = []
        for x in data.values:
            x = list(x)
            for t in content:
                if t:
                    content_temp.append(t + x)
                else:
                    content_temp.append(x)
        content = content_temp
    df = pd.DataFrame(content, columns=columns)  # 准备写入temp文件，方便where处理语句
    df.to_csv('.\\temp\\temp.csv', index=False, encoding='UTF-8')  # index=False，防止多加一列作为索引

    # 处理列
    columns = set(columns)
    for x in attribute:
        if x not in columns:
            print(f"不存在{x}属性!")
            return None

    # 查询到的数据行
    target_hang = []
    tag = False
    if 'WHERE' not in sql:
        tag = True
    else:
        sql = sql.replace(sql.split('FROM')[1].split('WHERE')[0].strip(), 'temp.temp')  # 修改sql语句，方便where查询处理
        target_hang = [0] + where(sql)
    print('===================================================================')
    if not tag:
        data = pd.read_csv('.\\temp\\temp.csv', skiprows=lambda x: x not in target_hang, usecols=attribute,
                           encoding='UTF-8')
    else:
        data = pd.read_csv('.\\temp\\temp.csv', usecols=attribute, encoding='UTF-8')
    if not data.values.size:
        print("无符合条件的查询结果！")
    else:
        print(data)
    print('===================================================================')
    return None


def helper(path, ll):
    """
    where函数的辅助函数，用来查找符合条件的行号
    :param path: 文件路径
    :param ll: sql以空格作为分隔符产生的列表，相当于是sql语句的信息
    :return: 返回符合条件的行号的列表，行号从1开始
    """
    rdata = pd.read_csv(path, encoding='UTF-8')
    cc = None
    for i, content in enumerate(ll):
        if content == 'WHERE':
            cc = ll[i + 1:]
            break
    ans = set()
    for content in cc:
        if content in ('and', 'or'):
            continue
        if '=' in content:
            col, val = content.split('=')
            q = []
            row = 0
            for data in rdata[col]:
                row += 1
                if str(data) == val:
                    q.append(row)
            if len(ans) == 0:
                ans = set(q)
            else:
                if 'and' in cc:
                    ans = ans & set(q)  # 集合的交运算，and
                elif 'or' in cc:
                    ans = ans | set(q)  # 集合的或运算，or
        elif '>' in content:
            col, val = content.split('>')
            q = []
            row = 0
            for data in rdata[col]:
                row += 1
                if data > int(val):
                    q.append(row)
            if len(ans) == 0:
                ans = set(q)
            else:
                if 'and' in cc:
                    ans = ans & set(q)
                elif 'or' in cc:
                    ans = ans | set(q)
        elif '<' in content:
            col, val = content.split('<')
            q = []
            row = 0
            for data in rdata[col]:
                row += 1
                if data < int(val):
                    q.append(row)
            if len(ans) == 0:
                ans = set(q)
            else:
                if 'and' in cc:
                    ans = ans & set(q)
                elif 'or' in cc:
                    ans = ans | set(q)
    return list(ans)


def where(sql):
    """
    通过sql语句返回查询到的数据索引项列表
    :param sql:string
    :return:list of index where fetch the limitation
    """
    ll = sql.split(' ')
    if ll[0] == "UPDATE":
        path = "." + "".join([("\\" + i) for i in ll[1].split('.')]) + ".csv"
        return helper(path, ll)

    elif ll[0] == "SELECT":
        path = "." + "".join([("\\" + i) for i in ll[3].split('.')]) + ".csv"
        return helper(path, ll)

    elif ll[0] == "DELETE":
        path = "." + "".join([("\\" + i) for i in ll[2].split('.')]) + ".csv"
        return helper(path, ll)
    else:
        return []


def controller(sql):
    """
    sql语句的控制器，完成对sql语句的解析，调用对应的功能。
    sql语句请严格符合以下例子，关键词请大写，其他小写，空格严格遵守以下例子：
            create_database :   CREATE DATABASE demo ;
            create_table :      CREATE TABLE demo.demo_table (name varchar(50),age int,gender varchar(1)) ;
            insert :            INSERT INTO demo.demo_table VALUES (张三,21,男) ;
            delete :            DELETE FROM demo.demo_table WHERE name=张三 ;
            update :            UPDATE demo.demo_table SET name=李四,age=18 WHERE name=张三 ;
            query :             SELECT name,age,gender FROM demo.demo_table WHERE name=张三 and age=21 ;
                          或者   SELECT name,age,gender FROM demo.demo_table ;  # 查询全部结果
    :param sql: sql 执行语句
    :return:  无返回值
    """
    print('*******************************************************************')
    print("sql : " + sql)
    if sql[0:15] == 'CREATE DATABASE':
        create_database(sql)
    elif sql[0:12] == 'CREATE TABLE':
        create_table(sql)
    elif sql[0:6] == 'INSERT':
        insert(sql)
    elif sql[0:6] == 'SELECT':
        query(sql)
    elif sql[0:6] == 'DELETE':
        delete(sql)
    elif sql[0:6] == 'UPDATE':
        update(sql)
    else:
        print("SQL语句输入错误！")
    return None


if __name__ == '__main__':


    test_sql = []

    # 创建数据库
    test_sql.append("CREATE DATABASE demo ;")

    # 创建二维表
    test_sql.append("CREATE TABLE demo.demo_table (name varchar(50),age int,gender varchar(1)) ;")

    # 插入数据
    test_sql.append("INSERT INTO demo.demo_table VALUES (张三,21,男) ;")
    test_sql.append("INSERT INTO demo.demo_table VALUES (李四,19,男) ;")
    test_sql.append("INSERT INTO demo.demo_table VALUES (王五,18,女) ;")
    test_sql.append("INSERT INTO demo.demo_table VALUES (张八,22,男) ;")
    test_sql.append("INSERT INTO demo.demo_table VALUES (黎小军,23,男) ;")
    test_sql.append("INSERT INTO demo.demo_table VALUES (王文慧,20,女) ;")
    test_sql.append("SELECT name,age,gender FROM demo.demo_table ;")

    # 删除数据
    test_sql.append("DELETE FROM demo.demo_table WHERE name=张三 ;")
    test_sql.append("SELECT name,age,gender FROM demo.demo_table ;")
    test_sql.append("DELETE FROM demo.demo_table WHERE name=张三 ;")

    # 修改数据
    test_sql.append("UPDATE demo.demo_table SET name=aaa,age=100,gender=男 WHERE name=李四 ;")
    test_sql.append("SELECT name,age,gender FROM demo.demo_table ;")
    test_sql.append("UPDATE demo.demo_table SET name=aaa,age=100,gender=男 WHERE name=张三 ;")

    # 查询数据
    test_sql.append("SELECT name,age FROM demo.demo_table WHERE age>20 or age<20 ;")
    test_sql.append("SELECT name,age FROM demo.demo_table WHERE age=20 or age=23 ;")
    test_sql.append("SELECT name,gender FROM demo.demo_table WHERE age<20 ;")
    test_sql.append("SELECT name,gender FROM demo.demo_table WHERE gender=女 ;")
    test_sql.append("SELECT name,age,gender FROM demo.demo_table WHERE name=张八 and age=22 ;")
    test_sql.append("SELECT name,age,gender FROM demo.demo_table WHERE gender=男 and age<20 ;")

    # 多表查询
    test_sql.append("CREATE TABLE demo.demo_table2 (tea_name varchar(50),tea_age int,tea_gender varchar(1)) ;")
    test_sql.append("INSERT INTO demo.demo_table2 VALUES (张老师,21,男) ;")
    test_sql.append("INSERT INTO demo.demo_table2 VALUES (李老师,19,男) ;")
    test_sql.append("SELECT name,age,gender,tea_name,tea_age,tea_gender FROM demo.demo_table,demo.demo_table2 WHERE gender=男 ;")

    for sql in test_sql:
        controller(sql)


    # while True:
    #     sql = input("请输入sql执行语句：")
    #     controller(sql)

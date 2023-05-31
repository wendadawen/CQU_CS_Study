# 入门指南

[(4条消息) python安装包国内镜像，pip使用国内镜像_我的征途是星辰的博客-CSDN博客_python安装包国内镜像](https://blog.csdn.net/u011107575/article/details/109901086)

[Python 30分钟入门指南 · luogu-dev/cyaron Wiki · GitHub](https://github.com/luogu-dev/cyaron/wiki/Python-30分钟入门指南)

```python
# 用井字符开头的是单行注释

""" 多行字符串用三个引号
    包裹，也常被用来做多
    行注释
"""

####################################################
## 1. 原始数据类型和运算符
####################################################

# 整数
3  # => 3

# 算术没有什么出乎意料的
1 + 1  # => 2
8 - 1  # => 7
10 * 2  # => 20

# 但是除法例外，会自动转换成浮点数
35 / 5  # => 7.0
5 / 3  # => 1.6666666666666667

# 整数除法的结果都是向下取整
5 // 3     # => 1
5.0 // 3.0 # => 1.0 # 浮点数也可以
-5 // 3  # => -2
-5.0 // 3.0 # => -2.0

# 浮点数的运算结果也是浮点数
3 * 2.0 # => 6.0

# 模除
7 % 3 # => 1

# x的y次方
2**4 # => 16

# 用括号决定优先级
(1 + 3) * 2  # => 8

# 布尔值
True
False

# 用not取非
not True  # => False
not False  # => True

# 逻辑运算符，注意and和or都是小写
True and False #=> False
False or True #=> True

# 整数也可以当作布尔值
0 and 2 #=> 0
-5 or 0 #=> -5
0 == False #=> True
2 == True #=> False
1 == True #=> True

# 用==判断相等
1 == 1  # => True
2 == 1  # => False

# 用!=判断不等
1 != 1  # => False
2 != 1  # => True

# 比较大小
1 < 10  # => True
1 > 10  # => False
2 <= 2  # => True
2 >= 2  # => True

# 大小比较可以连起来！
1 < 2 < 3  # => True
2 < 3 < 2  # => False

# 字符串用单引双引都可以
"这是个字符串"
'这也是个字符串'

# 用加号连接字符串
"Hello " + "world!"  # => "Hello world!"

# 字符串可以被当作字符列表
"This is a string"[0]  # => 'T'

# 用.format来格式化字符串
"{} can be {}".format("strings", "interpolated")

# 可以重复参数以节省时间
"{0} be nimble, {0} be quick, {0} jump over the {1}".format("Jack", "candle stick")
#=> "Jack be nimble, Jack be quick, Jack jump over the candle stick"

# 如果不想数参数，可以用关键字
"{name} wants to eat {food}".format(name="Bob", food="lasagna") #=> "Bob wants to eat lasagna"

# 如果你的Python3程序也要在Python2.5以下环境运行，也可以用老式的格式化语法
"%s can be %s the %s way" % ("strings", "interpolated", "old")

# None是一个对象
None  # => None

# 当与None进行比较时不要用 ==，要用is。is是用来比较两个变量是否指向同一个对象。
"etc" is None  # => False
None is None  # => True

# None，0，空字符串，空列表，空字典都算是False
# 所有其他值都是True
bool(0)  # => False
bool("")  # => False
bool([]) #=> False
bool({}) #=> False


####################################################
## 2. 变量和集合
####################################################

# print是内置的打印函数
print("I'm Python. Nice to meet you!")

# 在给变量赋值前不用提前声明
# 传统的变量命名是小写，用下划线分隔单词
some_var = 5
some_var  # => 5

# 访问未赋值的变量会抛出异常
# 参考流程控制一段来学习异常处理
some_unknown_var  # 抛出NameError

# 用列表(list)储存序列
li = []
# 创建列表时也可以同时赋给元素
other_li = [4, 5, 6]

# 用append在列表最后追加元素
li.append(1)    # li现在是[1]
li.append(2)    # li现在是[1, 2]
li.append(4)    # li现在是[1, 2, 4]
li.append(3)    # li现在是[1, 2, 4, 3]
# 用pop从列表尾部删除
li.pop()        # => 3 且li现在是[1, 2, 4]
# 把3再放回去
li.append(3)    # li变回[1, 2, 4, 3]

# 列表存取跟数组一样
li[0]  # => 1
# 取出最后一个元素
li[-1]  # => 3

# 越界存取会造成IndexError
li[4]  # 抛出IndexError

# 列表有切割语法
li[1:3]  # => [2, 4]
# 取尾
li[2:]  # => [4, 3]
# 取头
li[:3]  # => [1, 2, 4]
# 隔一个取一个
li[::2]   # =>[1, 4]
# 倒排列表
li[::-1]   # => [3, 4, 2, 1]
# 可以用三个参数的任何组合来构建切割
# li[始:终:步伐]

# 用del删除任何一个元素
del li[2]   # li is now [1, 2, 3]

# 列表可以相加
# 注意：li和other_li的值都不变
li + other_li   # => [1, 2, 3, 4, 5, 6]

# 用extend拼接列表
li.extend(other_li)   # li现在是[1, 2, 3, 4, 5, 6]

# 用in测试列表是否包含值
1 in li   # => True

# 用len取列表长度
len(li)   # => 6


# 元组是不可改变的序列
tup = (1, 2, 3)
tup[0]   # => 1
tup[0] = 3  # 抛出TypeError

# 列表允许的操作元组大都可以
len(tup)   # => 3
tup + (4, 5, 6)   # => (1, 2, 3, 4, 5, 6)
tup[:2]   # => (1, 2)
2 in tup   # => True

# 可以把元组合列表解包，赋值给变量
a, b, c = (1, 2, 3)     # 现在a是1，b是2，c是3
# 元组周围的括号是可以省略的
d, e, f = 4, 5, 6
# 交换两个变量的值就这么简单
e, d = d, e     # 现在d是5，e是4


# 用字典表达映射关系
empty_dict = {}
# 初始化的字典
filled_dict = {"one": 1, "two": 2, "three": 3}

# 用[]取值
filled_dict["one"]   # => 1


# 用keys获得所有的键。因为keys返回一个可迭代对象，所以在这里把结果包在list里。我们下面会详细介绍可迭代。
# 注意：字典键的顺序是不定的，你得到的结果可能和以下不同。
list(filled_dict.keys())   # => ["three", "two", "one"]


# 用values获得所有的值。跟keys一样，要用list包起来，顺序也可能不同。
list(filled_dict.values())   # => [3, 2, 1]


# 用in测试一个字典是否包含一个键
"one" in filled_dict   # => True
1 in filled_dict   # => False

# 访问不存在的键会导致KeyError
filled_dict["four"]   # KeyError

# 用get来避免KeyError
filled_dict.get("one")   # => 1
filled_dict.get("four")   # => None
# 当键不存在的时候get方法可以返回默认值
filled_dict.get("one", 4)   # => 1
filled_dict.get("four", 4)   # => 4

# setdefault方法只有当键不存在的时候插入新值
filled_dict.setdefault("five", 5)  # filled_dict["five"]设为5
filled_dict.setdefault("five", 6)  # filled_dict["five"]还是5

# 字典赋值
filled_dict.update({"four":4}) #=> {"one": 1, "two": 2, "three": 3, "four": 4}
filled_dict["four"] = 4  # 另一种赋值方法

# 用del删除
del filled_dict["one"]  # 从filled_dict中把one删除


# 用set表达集合
empty_set = set()
# 初始化一个集合，语法跟字典相似。
some_set = {1, 1, 2, 2, 3, 4}   # some_set现在是{1, 2, 3, 4}

# 可以把集合赋值于变量
filled_set = some_set

# 为集合添加元素
filled_set.add(5)   # filled_set现在是{1, 2, 3, 4, 5}

# & 取交集
other_set = {3, 4, 5, 6}
filled_set & other_set   # => {3, 4, 5}

# | 取并集
filled_set | other_set   # => {1, 2, 3, 4, 5, 6}

# - 取补集
{1, 2, 3, 4} - {2, 3, 5}   # => {1, 4}

# in 测试集合是否包含元素
2 in filled_set   # => True
10 in filled_set   # => False


####################################################
## 3. 流程控制和迭代器
####################################################

# 先随便定义一个变量
some_var = 5

# 这是个if语句。注意缩进在Python里是有意义的
# 印出"some_var比10小"
if some_var > 10:
    print("some_var比10大")
elif some_var < 10:    # elif句是可选的
    print("some_var比10小")
else:                  # else也是可选的
    print("some_var就是10")


"""
用for循环语句遍历列表
打印:
    dog is a mammal
    cat is a mammal
    mouse is a mammal
"""
for animal in ["dog", "cat", "mouse"]:
    print("{} is a mammal".format(animal))

"""
"range(number)"返回数字列表从0到给的数字
打印:
    0
    1
    2
    3
"""
for i in range(4):
    print(i)

"""
while循环直到条件不满足
打印:
    0
    1
    2
    3
"""
x = 0
while x < 4:
    print(x)
    x += 1  # x = x + 1 的简写

# 用try/except块处理异常状况
try:
    # 用raise抛出异常
    raise IndexError("This is an index error")
except IndexError as e:
    pass    # pass是无操作，但是应该在这里处理错误
except (TypeError, NameError):
    pass    # 可以同时处理不同类的错误
else:   # else语句是可选的，必须在所有的except之后
    print("All good!")   # 只有当try运行完没有错误的时候这句才会运行


# Python提供一个叫做可迭代(iterable)的基本抽象。一个可迭代对象是可以被当作序列
# 的对象。比如说上面range返回的对象就是可迭代的。

filled_dict = {"one": 1, "two": 2, "three": 3}
our_iterable = filled_dict.keys()
print(our_iterable) # => range(1,10) 是一个实现可迭代接口的对象

# 可迭代对象可以遍历
for i in our_iterable:
    print(i)    # 打印 one, two, three

# 但是不可以随机访问
our_iterable[1]  # 抛出TypeError

# 可迭代对象知道怎么生成迭代器
our_iterator = iter(our_iterable)

# 迭代器是一个可以记住遍历的位置的对象
# 用__next__可以取得下一个元素
our_iterator.__next__()  #=> "one"

# 再一次调取__next__时会记得位置
our_iterator.__next__()  #=> "two"
our_iterator.__next__()  #=> "three"

# 当迭代器所有元素都取出后，会抛出StopIteration
our_iterator.__next__() # 抛出StopIteration

# 可以用list一次取出迭代器所有的元素
list(filled_dict.keys())  #=> Returns ["one", "two", "three"]



####################################################
## 4. 函数
####################################################

# 用def定义新函数
def add(x, y):
    print("x is {} and y is {}".format(x, y))
    return x + y    # 用return语句返回

# 调用函数
add(5, 6)   # => 印出"x is 5 and y is 6"并且返回11

# 也可以用关键字参数来调用函数
add(y=6, x=5)   # 关键字参数可以用任何顺序


# 我们可以定义一个可变参数函数
def varargs(*args):
    return args

varargs(1, 2, 3)   # => (1, 2, 3)


# 我们也可以定义一个关键字可变参数函数
def keyword_args(**kwargs):
    return kwargs

# 我们来看看结果是什么：
keyword_args(big="foot", loch="ness")   # => {"big": "foot", "loch": "ness"}


# 这两种可变参数可以混着用
def all_the_args(*args, **kwargs):
    print(args)
    print(kwargs)
"""
all_the_args(1, 2, a=3, b=4) prints:
    (1, 2)
    {"a": 3, "b": 4}
"""

# 调用可变参数函数时可以做跟上面相反的，用*展开序列，用**展开字典。
args = (1, 2, 3, 4)
kwargs = {"a": 3, "b": 4}
all_the_args(*args)   # 相当于 foo(1, 2, 3, 4)
all_the_args(**kwargs)   # 相当于 foo(a=3, b=4)
all_the_args(*args, **kwargs)   # 相当于 foo(1, 2, 3, 4, a=3, b=4)


# 函数作用域
x = 5

def setX(num):
    # 局部作用域的x和全局域的x是不同的
    x = num # => 43
    print (x) # => 43

def setGlobalX(num):
    global x
    print (x) # => 5
    x = num # 现在全局域的x被赋值
    print (x) # => 6

setX(43)
setGlobalX(6)


# 函数在Python是一等公民
def create_adder(x):
    def adder(y):
        return x + y
    return adder

add_10 = create_adder(10)
add_10(3)   # => 13

# 也有匿名函数
(lambda x: x > 2)(3)   # => True

# 内置的高阶函数
map(add_10, [1, 2, 3])   # => [11, 12, 13]
filter(lambda x: x > 5, [3, 4, 5, 6, 7])   # => [6, 7]

# 用列表推导式可以简化映射和过滤。列表推导式的返回值是另一个列表。
[add_10(i) for i in [1, 2, 3]]  # => [11, 12, 13]
[x for x in [3, 4, 5, 6, 7] if x > 5]   # => [6, 7]

####################################################
## 5. 类
####################################################


# 定义一个继承object的类
class Human(object):

    # 类属性，被所有此类的实例共用。
    species = "H. sapiens"

    # 构造方法，当实例被初始化时被调用。注意名字前后的双下划线，这是表明这个属
    # 性或方法对Python有特殊意义，但是允许用户自行定义。你自己取名时不应该用这
    # 种格式。
    def __init__(self, name):
        # Assign the argument to the instance's name attribute
        self.name = name

    # 实例方法，第一个参数总是self，就是这个实例对象
    def say(self, msg):
        return "{name}: {message}".format(name=self.name, message=msg)

    # 类方法，被所有此类的实例共用。第一个参数是这个类对象。
    @classmethod
    def get_species(cls):
        return cls.species

    # 静态方法。调用时没有实例或类的绑定。
    @staticmethod
    def grunt():
        return "*grunt*"


# 构造一个实例
i = Human(name="Ian")
print(i.say("hi"))     # 印出 "Ian: hi"

j = Human("Joel")
print(j.say("hello"))  # 印出 "Joel: hello"

# 调用一个类方法
i.get_species()   # => "H. sapiens"

# 改一个共用的类属性
Human.species = "H. neanderthalensis"
i.get_species()   # => "H. neanderthalensis"
j.get_species()   # => "H. neanderthalensis"

# 调用静态方法
Human.grunt()   # => "*grunt*"


####################################################
## 6. 模块
####################################################

# 用import导入模块
import math
print(math.sqrt(16))  # => 4.0

# 也可以从模块中导入个别值
from math import ceil, floor
print(ceil(3.7))  # => 4.0
print(floor(3.7))   # => 3.0

# 可以导入一个模块中所有值
# 警告：不建议这么做
from math import *

# 如此缩写模块名字
import math as m
math.sqrt(16) == m.sqrt(16)   # => True

# Python模块其实就是普通的Python文件。你可以自己写，然后导入，
# 模块的名字就是文件的名字。

# 你可以这样列出一个模块里所有的值
import math
dir(math)


####################################################
## 7. 高级用法
####################################################

# 用生成器(generators)方便地写惰性运算
def double_numbers(iterable):
    for i in iterable:
        yield i + i

# 生成器只有在需要时才计算下一个值。它们每一次循环只生成一个值，而不是把所有的
# 值全部算好。这意味着double_numbers不会生成大于15的数字。
#
# range的返回值也是一个生成器，不然一个1到900000000的列表会花很多时间和内存。
#
# 如果你想用一个Python的关键字当作变量名，可以加一个下划线来区分。
range_ = range(1, 900000000)
# 当找到一个 >=30 的结果就会停
for i in double_numbers(range_):
    print(i)
    if i >= 30:
        break
```

# 进阶及技巧

### enumerate

`enumerate()` 是 Python 内置函数之一，用于在可迭代对象（例如列表、元组、字符串等）上遍历时，同时获取每个元素的索引和元素值。

具体而言，`enumerate()` 函数的语法为：

```python
enumerate(iterable, start=0)
```

其中：

- `iterable`：表示要遍历的可迭代对象；
- `start`：表示索引起始值，默认为 0。

该函数返回一个枚举对象，其中每个元素都是一个由索引和对应元素值组成的元组。

接下来请看一个示例，演示如何通过 `enumerate()` 访问列表中的元素以及其对应的索引：

```python
fruits = ['apple', 'banana', 'orange']
for index, fruit in enumerate(fruits):
    print(index, fruit)
```

运行结果如下：

```
0 apple
1 banana
2 orange
```

### dict

#### 常用的字典操作

1. 创建字典：

可以直接用大括号 {} 创建一个空字典，或者使用 dict() 函数从其他序列或以关键字参数的形式创建字典，例如：

``` python
# 创建空字典
d1 = {}
# 从列表创建字典
d2 = dict([(1, 'apple'), (2, 'orange')])
# 以关键字参数形式创建字典
d3 = dict(name='Alice', age=25, city='Beijing')
```

2. 访问字典中的元素：

通过键来访问字典中的元素，例如：

``` python
fruits = {'apple': 3, 'banana': 2, 'orange': 1}
print(fruits['apple'])   # 输出 3
print(fruits.get('kiwi'))   # 输出 None
```

3. 更新字典：

可以通过赋值给已有的键 或添加新的键值对来更新字典中的元素，例如：

``` python
fruits = {'apple': 3, 'banana': 2, 'orange': 1}
fruits['apple'] = 4   # 更新值
fruits['kiwi'] = 2   # 添加新键值对
print(fruits)   # 输出 {'apple': 4, 'banana': 2, 'orange': 1, 'kiwi': 2}
```

4. 删除字典元素：

可以使用 del 语句删除某个键值对或整个字典，例如：

``` python
fruits = {'apple': 3, 'banana': 2, 'orange': 1}
del fruits['orange']   # 删除一个键值对
print(fruits)   # 输出 {'apple': 3, 'banana': 2}

del fruits   # 删除整个字典
```

5. 字典常用方法：

- `keys()`：返回一个包含所有键的列表；
- `values()`：返回一个包含所有值的列表；
- `items()`：返回一个包含所有键值对的列表。

``` python
fruits = {'apple': 3, 'banana': 2, 'orange': 1}
print(fruits.keys())   # 输出 dict_keys(['apple', 'banana', 'orange'])
print(fruits.values())   # 输出 dict_values([3, 2, 1])
print(fruits.items())   # 输出 dict_items([('apple', 3), ('banana', 2), ('orange', 1)])
```

#### 字典推导式

可以在创建新的字典时非常方便地使用现有字典和迭代器。通过字典推导式，我们可以根据一定的规则快速创建一个字典对象。下面是一个简单的示例：

```python
names = ['Tom', 'Jerry', 'Spike']
ages = [5, 4, 6]
name_age_map = {name: age for name, age in zip(names, ages)}

print(name_age_map) # 输出 {'Tom': 5, 'Jerry': 4, 'Spike': 6}
```

在上面的示例中，我们使用了字典推导式来创建一个将名字映射到年龄的字典对象。具体来说，我们首先使用 `zip()` 函数将两个列表 `names` 和 `ages` 合并成一个元素为 `(name, age)` 的元组列表；然后，在字典推导式中，我们以 `name: age` 的方式将每个元素加入到字典中。

#### 例子

1. 词频统计

可以使用 Python 字典来实现词频统计。例如，统计一篇文章中每个单词出现的次数：

```python
text = "This is a sample text with several words. It is used to demonstrate the usage of Python dictionary."
words = text.split()  # 将文章拆分成单词列表
freq = {}
for word in words:
    if word not in freq:
        freq[word] = 1
    else:
        freq[word] += 1
print(freq)
```

输出结果为：

```python
{'This': 1, 'is': 2, 'a': 1, 'sample': 1, 'text': 1, 'with': 1, 'several': 1, 'words.': 1, 'It': 1, 'used': 1, 'to': 1, 'demonstrate': 1, 'the': 1, 'usage': 1, 'of': 1, 'Python': 1, 'dictionary.': 1}
```

2. 合并两个字典

我们可以使用`update()`方法将一个字典合并到另一个字典中。例如：

```python
my_dict1 = {'name': 'Lucy', 'age': 25}
my_dict2 = {'gender': 'female', 'occupation': 'engineer'}
my_dict1.update(my_dict2)
```

3. 在字典中查找某个键是否存在

可以使用`in`关键字或者`has_key()`方法在字典中查找某个键是否存在。例如：

```python
if 'name' in my_dict:
    print('Name is in the dictionary.')

if my_dict.has_key('gender'):
    print('Gender is in the dictionary.')
```

4. 访问字典中不存在的键值对时，使用`setdefault()`方法避免出现KeyError异常

`setdefault()`方法可以获取字典中指定键的值，如果该键不存在，则返回默认值并将其添加到字典中。例如：

```python
country = my_dict.setdefault('country', 'China')
```

上述代码中，如果`country`这个键不存在于`my_dict`中，那么`setdefault()`方法将返回默认值`'China'`并将其添加到字典中。

5. 使用`fromkeys()`方法创建新字典

可以使用`fromkeys()`方法根据指定的键列表和默认值创建新字典。例如：

```python
new_dict = dict.fromkeys(['name', 'age', 'gender'], 'Unknown')
```

此时`new_dict`字典将包含三个键（'name'、'age'、'gender'）和对应的默认值（'Unknown'）。

#### defaultdict

下面是一个defaultdict的例子：

```python
from collections import defaultdict

#定义默认值为int类型的空字典
nums = defaultdict(int)
print(nums[0])  #输出0，因为默认值为int类型，所以不存在键0时返回0
nums[1] += 1    #给键1赋值为1
nums[2] += 2    #给键2赋值为2
print(nums)     #输出defaultdict(<class 'int'>, {1: 1, 2: 2})
```

 正在为您搜索：defaultdict python举例用法、多举例几个

好的，下面再举几个例子：

1. 使用defaultdict统计字符串中每个字符的出现次数

```python
from collections import defaultdict

s = "hello, world"
counter = defaultdict(int)  # 定义默认值为0的空字典
for c in s:
    counter[c] += 1  # 统计字符出现次数
print(counter)  
```

在上面的例子中，我们通过`defaultdict(int)`定义了一个默认值为0的空字典`counter`，然后通过遍历字符串中的每个字符，将每个字符出现的次数累加到对应的键上，最终输出了每个字符的出现次数。因为`defaultdict(int)`的默认值是0，所以我们不需要判断一个字符是否出现过，直接加上去就可以了。

2. **使用defaultdict给数据分组**

```python
from collections import defaultdict

data = [("apple", 1), ("banana", 2), ("apple", 3), ("orange", 4), ("banana", 5)]
groups = defaultdict(list)  # 定义默认值为列表类型的空字典
for key, value in data:
    groups[key].append(value)  # 将相同键的数据放到同一组里
print(groups)  
```

在上面的例子中，我们通过`defaultdict(list)`定义了一个默认值为列表类型的空字典`groups`，然后遍历数据中的每个键值对，将相同键的数据放到同一组里。因为`defaultdict(list)`的默认值是一个空列表`[]`，所以我们可以直接使用`append()`方法向列表中添加元素，无需判断键是否存在。

3. 使用defaultdict实现多级字典的自动创建

```python
from collections import defaultdict

nested_dict = lambda: defaultdict(nested_dict)  # 定义多级字典的创建函数
d = nested_dict()  # 创建一个三级字典
# 给二级字典赋值
d['a']['b']['d']['c'] = 2
d['a']['b']['e']['c']['d'] = 3
# 输出结果
print(d['a']['b']['d']['c'])
```

在上面的例子中，我们通过定义一个多级字典的创建函数`nested_dict`，可以方便地创建多层嵌套的字典。因为`defaultdict(nested_dict)`的默认值是一个新的`nested_dict`，所以我们可以通过链式赋值的方式自动创建多级字典。

### set

`set`是Python中的一种内置数据类型，用于表示一组无序、独特的元素。

我们可以在Python中使用内置函数来操作`set`数据类型，例如：

- `set()`：创建一个新的空集合。
- `set(iterable)`：根据可迭代项（如列表、元组、字符串等）创建一个新的集合。集合中的元素必须是独特的，因此会自动去重。
- `len(set)`：返回集合中元素的数量。
- `x in set`：测试元素`x`是否包含在集合中。
- `set.add(x)`：将元素`x`添加到集合中。如果元素已经存在，则不执行任何操作。
- `set.remove(x)`：从集合中删除元素`x`。如果元素不存在，则引发`KeyError`异常。
- `set.clear()`：从集合中删除所有元素。

下面是在Python中使用`set`的一些示例：

```python
# 创建一个新的空集合
my_set = set()

# 根据可迭代项创建一个新的集合
my_set = set([1, 2, 3, 4])

# 检查元素是否在集合中
5 in my_set  # False

# 添加元素到集合中
my_set.add(5)

# 从集合中删除元素
my_set.remove(1)

# 获取集合中元素的数量
len(my_set)
```

集合支持一些常见的数学运算，例如并集、交集和差集等：

```python
set1 = {1, 2, 3}
set2 = {3, 4, 5}

union_set = set1 | set2  # 并集：{1,2,3,4,5}
intersect_set = set1 & set2  # 交集：{3}
diff_set = set1 - set2  # 差集：{1,2}
```

### eval

```python
>>> eval("[1,2,3,4,5]")  # eval
[1, 2, 3, 4, 5]
>>> eval("(1,2,3,4,5)")
(1, 2, 3, 4, 5)
>>> eval("2 + 2")
4
>>> eval("{1,2,3,4,5,6}")
{1, 2, 3, 4, 5, 6}
>>> eval("{1:1,2:2,3:3,4:4,5:5}")
{1: 1, 2: 2, 3: 3, 4: 4, 5: 5}
```

### copy

```python
>>> import copy
>>> a = [1,2,3,[4,5]]
>>> b = copy.copy(a)
>>> c = copy.deepcopy(a)
>>> a[3][0] = "hey"
>>> print(b,c)
[1, 2, 3, ['hey', 5]] [1, 2, 3, [4, 5]]`
```

### sorted

`sorted()` 函数的语法如下：

```python
sorted(iterable, key=None, reverse=False)
```

`iterable` 参数即要排序的可迭代对象；

`key` 参数是一个可选的函数，用于为每个元素提供一个用于排序的键(key)。例如，可以使用 `key=len` 来指定按照元素的长度进行排序，或者使用 `key=str.lower` 来对字符串元素进行不区分大小写的排序。`reverse` 参数是一个可选的布尔值，用于指定是否进行倒序排列。如果 `reverse=True`，则进行降序排列。

下面是一个例子，展示了如何使用 `sorted()` 函数按照字符串长度进行升序排序：

```python
words = ['apple', 'banana', 'cherry', 'durian']
sorted_words = sorted(words, key=len)
print(sorted_words)
```

输出结果为：

```
['apple', 'banana', 'cherry', 'durian']
```

再举一个例子，展示了如何使用 `sorted()` 函数对字典按照值进行排序：

```python
prices = {'apple': 0.5, 'banana': 0.3, 'cherry': 0.8, 'durian': 1.2}
sorted_prices = sorted(prices.items(), key=lambda x: x[1])
print(sorted_prices)
```

在这个例子中，我们首先使用 `items()` 方法将字典转换为包含键值对的列表，然后使用 lambda 表达式指定按照值排序。输出结果为：

```
[('banana', 0.3), ('apple', 0.5), ('cherry', 0.8), ('durian', 1.2)]
```

### bisect

#### insert

`bisect` 是一个 Python 内置模块 `bisect` 中的函数，它是用于处理已排序列表的模块之一。`bisect` 可以利用二分查找算法来查找元素在有序列表中的位置，或者将元素插入到有序列表中的合适位置。`bisect` 模块还有很多其他函数，比如 `bisect_left()` 和 `bisect_right()` 等，它们可以根据使用场景不同进行选择。

下面是一个例子，演示如何使用 `bisect` 模块中的 `bisect()` 函数实现对已排序列表的插入操作：

```python
import bisect

numbers = [1, 3, 4, 6, 8, 9]
bisect.insort(numbers, 7)
print(numbers)
```

输出结果为：

```
[1, 3, 4, 6, 7, 8, 9]
```

在这个例子中，我们首先导入了 `bisect` 模块，然后定义了一个已排序列表 `numbers`。接着，我们使用 `insort()` 函数将数字 7 插入到 `numbers` 中的合适位置，从而得到了修改后的已排序列表。

需要注意的是，`insort()` 函数是就地操作，即修改原始列表，而且只能用于已排序列表。如果要向未排序列表中插入元素并保持有序，则应该先使用 `sort()` 函数对列表进行排序，然后再使用 `insort()` 函数插入元素。

需要注意的是，如果要将元素插入到已排序列表中，应该使用 `insort_left()`   `insort_right()` 

#### binsect

`bisect_left()` :相当于lower_bound

`bisect_right()` :相当于upper_bound

下面是一个示例，演示如何使用 `bisect_left()` 函数和 `bisect_right()` 函数来实现二分查找：

```python
import bisect

numbers = [1, 3, 4, 6, 6, 8, 9]
x = 6

pos_left = bisect.bisect_left(numbers, x)
pos_right = bisect.bisect_right(numbers, x)

print(f"The leftmost index of {x} is {pos_left}")
print(f"The rightmost index of {x} is {pos_right}")
```

输出结果为：

```
The leftmost index of 6 is 3
The rightmost index of 6 is 5
```

### lambda

lambda表达式的语法如下：

```python
lambda arguments: expression
```

其中，arguments为参数列表，用逗号分隔；expression为表达式，用于计算并返回结果。

例如，以下代码定义了一个lambda表达式，将传入的两个数字相加并返回结果：

```python
sum = lambda x, y: x + y
print(sum(3, 4))    # 输出结果为7
```

lambda表达式常常与Python内置的高阶函数（如map、filter、reduce等）一起使用，以便快速、简洁地完成各种数据处理任务。

**当然可以，下面提供一些lambda表达式的示例：**

1. 列表排序

```python
numbers = [1, 3, 2, 5, 4]
sorted_numbers = sorted(numbers, key=lambda x: x)
print(sorted_numbers)  # 输出 [1, 2, 3, 4, 5]
```

这里使用了sorted函数和lambda表达式，将列表中的元素按照从小到大的顺序进行排序。

2. 列表筛选

```python
fruits = ['apple', 'banana', 'orange', 'kiwi', 'pineapple']
filtered_fruits = list(filter(lambda x: len(x) > 5, fruits))
print(filtered_fruits)  # 输出 ['banana', 'orange', 'pineapple']
```

这里使用了**filter函数和lambda表**达式，筛选出列表中长度大于5的元素。

3. 字典根据值排序

```python
scores = {'Alice': 95, 'Bob': 82, 'Cathy': 74, 'David': 88}
sorted_scores = dict(sorted(scores.items(), key=lambda x: x[1], reverse=True))
print(sorted_scores)  # 输出 {'Alice': 95, 'David': 88, 'Bob': 82, 'Cathy': 74}
```

这里使用了字典的items方法、sorted函数和lambda表达式，将字典按照值从大到小排序。注意，这里通过reverse参数设置为True表示降序排列。

**好的，下面再提供几个lambda表达式的实例：**

1. 列表切片

```python
numbers = [1, 2, 3, 4, 5]
sliced_numbers = list(map(lambda x: x * 2, numbers[1:4]))
print(sliced_numbers)  # 输出 [4, 6, 8]
```

这里使用了map函数和lambda表达式，对列表中索引为1到3的元素进行乘2操作。

2. 字典过滤

```python
scores = {'Alice': 95, 'Bob': 82, 'Cathy': 74, 'David': 88}
filtered_scores = {k: v for k, v in scores.items() if v >= 90}
print(filtered_scores)  # 输出 {'Alice': 95}
```

这里使用了字典推导式和lambda表达式，筛选出字典中值大于等于90的键值对。

3. 计算平均数

```python
numbers = [1, 2, 3, 4, 5]
average = (lambda x: sum(x) / len(x))(numbers)
print(average)  # 输出 3.0
```

这里使用了lambda表达式，并将其作为匿名函数立即执行，计算出列表中所有元素的平均数。



### map

`map()` 函数是 Python 内置函数之一，用于将一个可迭代对象（比如列表、元组等）中的每个元素应用于一个指定的函数上，并返回一个新的可迭代对象。`map()` 函数的语法为：

```python
map(function, iterable, ...)
```

其中，`function` 是要应用的函数，`iterable` 是要迭代的对象，可以有多个 `iterable` 参数。`map()` 函数会依次将 `iterable` 中的元素传递给 `function` 函数进行处理，并将处理结果按顺序存储在一个新的可迭代对象中。如果有多个 `iterable` 参数，则 `function` 函数需要对应接收相同个数的参数。

下面是一个简单的示例代码，用于说明 `map()` 函数的用法：

```python
# 将列表中的每个元素乘以 2，并返回一个新的列表
numbers = [1, 2, 3, 4, 5]
result = map(lambda x: x * 2, numbers)
print(list(result))  # 输出 [2, 4, 6, 8, 10]

# 将两个列表中的元素相加，并返回一个新的列表
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = map(lambda x, y: x + y, list1, list2)
print(list(result))  # 输出 [5, 7, 9]

# 网格最大值
print(max(map(max, grid)))
```

在上面的代码中，我们使用了 `map()` 函数将 `lambda` 函数应用于指定的列表中，并返回一个新的列表。在第一个示例中，我们将列表中的每个元素乘以 2，得到了一个包含新元素的列表；在第二个示例中，我们将两个列表中的元素相加，得到了一个新的列表。

### filter

`filter`是Python中的一个内置函数，用于过滤序列中的元素。其基本语法如下：

```python
filter(function, iterable)
```

`filter`函数会依次将`iterable`中的元素传递给`function`函数进行判断，最终返回一个由所有“真值”元素组成的迭代器。

以下是使用Python中`filter`函数的示例：

```python
# 定义一个函数，用于判断奇数
def is_odd(num):
    return num % 2 == 1

# 使用filter函数过滤出序列中的奇数
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
result = filter(is_odd, nums)
print(list(result))  # [1, 3, 5, 7, 9]

# 可以使用Lambda表达式代替函数
result = filter(lambda x: x > 5, nums)
print(list(result))  # [6, 7, 8, 9]
```

### reduce

`reduce`是Python中的一个内置函数，它通过对序列中的元素进行迭代和归并操作，实现将多个值合并为单个结果的目的。具体来说，`reduce`函数用于将一个可迭代对象中的所有元素依次传入到指定的函数中进行计算，其中该函数需要接受两个参数，分别代表当前的累积结果和下一个元素，最终返回一个单一结果。

`reduce`函数需要导入`functools`模块才能使用。以下是使用Python中`reduce`函数的示例：

```python
from functools import reduce

# 计算列表中所有元素的和
numbers = [1, 2, 3, 4, 5]
result = reduce(lambda x, y: x + y, numbers)
print(result)  # 15

# 计算列表中所有元素的乘积
numbers = [1, 2, 3, 4, 5]
result = reduce(lambda x, y: x * y, numbers)
print(result)  # 120
```



### zip

Python中的zip函数是将多个可迭代对象中的元素按照相同的索引位置进行打包，返回一个由元组组成的zip对象，可以通过list等方法转换为列表形式。例如：

```python
a = [1, 2, 3]
b = ['a', 'b', 'c']
c = zip(a, b)
print(list(c))
```

输出结果为：`[(1, 'a'), (2, 'b'), (3, 'c')]`

这里的a和b都是可迭代对象，通过zip函数将它们对应的元素进行打包，最终生成了一个由元组组成的列表。

### all

`all()` 是 Python 内置函数之一，它可以用于检查可迭代对象中的所有元素是否都为 True。

具体使用方法如下：

```python
all(iterable)
```

其中，`iterable` 表示可迭代对象，如列表、元组、字典等。如果 `iterable` 中的所有元素都为 True，则返回 True；否则返回 False。

举个例子，如果我们要检查一个列表中的所有元素是否都为 True，可以使用 `all()` 函数：

```python
mylist = [True, True, True]
x = all(mylist)
print(x)   # 输出 True
```

在上面的代码中，`all()` 函数检查 `mylist` 中的所有元素是否都为 True，返回 True。另外，`all()` 函数还支持其他可迭代对象，如元组、集合等。

### any

any() 函数用于判断给定的可迭代参数 iterable 是否全部为 False，则返回 False，如果有一个为 True，则返回 True。

元素除了是 0、空、FALSE 外都算 TRUE。

函数等价于：

```python
def any(iterable):
    for element in iterable:
        if element:
            return True
    return False
```

### 优先队列

```python
heapq.heappop(q)
heapq.heappush(q)
```

Python还提供了一个`queue`模块，其中的`PriorityQueue`类可以对元素进行排序，从而实现优先队列的功能。下面是一个使用`queue.PriorityQueue`实现优先队列的例子：

```python
import queue

# 定义一个优先队列
pq = queue.PriorityQueue()
pq.put((3, "C"))
pq.put((1, "A"))
pq.put((4, "D"))
pq.put((2, "B"))

# 依次弹出队列中的元素
while not pq.empty():
    print(pq.get())
```

在上面的例子中，我们通过`queue.PriorityQueue()`定义了一个优先队列，然后通过`put()`方法向队列中添加元素，每个元素是一个元组，其中元组的第一个元素为关键字，第二个元素为值。通过`get()`方法弹出队列中的元素，因为队列会自动根据关键字排序，所以每次弹出的元素都是当前队列中关键字最小的元素。输出的结果为：

```
(1, 'A')
(2, 'B')
(3, 'C')
(4, 'D')
```

**对于自定义的类使用优先队列，在入队的时候需要根据类的某一属性进行比较。**

方法：使用重载方法__lt__，__lt__是python中用于进行特定比较的方法。

例如：

```python
import queue
class person(object):
    def __init__(self,name,score):
        self.name = name
        self.score = score
    def __lt__(self, other):
        return self.score > other.score


p1 = person("张三",15)
p2 = person("李四",23)
p3 = person("王五",12)
p4 = person("朱五",32)
que = queue.PriorityQueue()
que.put(p1)
que.put(p2)
que.put(p4)
que.put(p3)

print(que.get().name)
print(que.get().name)
print(que.get().name)
print(que.get().name)
```

其中，__lt__定义了根据score属性进行从大到小的排列。即当PriorityQueue入队一个类实例的时候，会自动根据score属性进行比较。

### Counter

Python的counter是一个计数器工具，它可以用来统计序列中每个元素出现的次数。counter是Python标准库collections模块提供的一个类，使用非常方便。

以下是一个例子：

```python
from collections import Counter

string = "hello world"
count = Counter(string)

print(count)
```

上述代码输出结果为：

```
Counter({'l': 3, 'o': 2, ' ': 1, 'h': 1, 'e': 1, 'w': 1, 'r': 1, 'd': 1})
```

这表示在字符串"hello world"中，字符'l'出现了3次，字符'o'出现了2次，空格出现了1次，其他字符各自出现了1次。

除了字符串，counter还可以用于各种容器类型，如列表、元组、集合等，以及字典等映射类型。需要注意的是，在使用counter时，它会将所有元素转化成哈希值存储，因此只有可哈希的元素才能被计数。

### nonlocal

`nonlocal` 是 Python 中的一个关键字，用于在嵌套函数中访问外层函数的局部变量。当在内层函数中声明 `nonlocal` 关键字后，Python 会按照 LEGB 规则在上一级函数中查找同名变量，并将其作为当前内层函数中的变量来使用。如果没有找到同名变量，则会抛出 `UnboundLocalError` 异常。

例如，下面的代码中的 `inner_func` 函数可以访问 `outer_func` 函数中的 `x` 变量：

```python
def outer_func():
    x = 1

    def inner_func():
        nonlocal x
        x += 1
        print(x)

    inner_func()  # 输出 2

outer_func()
```

# spiders

## 基础知识

### URL

scheme://[username:passward@]hostname[:port] [/path] [;parameters] [?query] [#fragment]

### General

Remote Address：远程服务器地址和端口

Referrer Policy：Referrer 判别策略

### Request Headers

Accept：指定客户端可以接受哪些类型的信息

Accept-Language：指定客户端可以接受的语言类型

Accept-Encoding：指定客户端可以接受的内容编码，一般不加，加了返回加密文件

Host：URL的原始服务器或者网关的位置

Cookies：维持当前会话的信息

Referer：用于标识请求是从那个页面发过来的，服务器做防盗链，源统计处理

User-Agent：简称UA，标识客户端使用的操作系统，浏览器及版本信息

Content-Type：表示请求的内容，text/html表示HTML，image/gif表示GIF图片，**POST请求提交数据需要正确的填写内容**

### Response Headers

Date：标识响应产生的时间

Content-Encoding：指定内容的编码

Server：服务器的信息，名称版本等

Content-Type：指定返回的数据类型

Set-Cookies：设置Cookies，浏览器下次访问会携带

Expires：响应过期时间

### 其他 

1. css 用link标签，JavaScript用script标签

# Requests

测试网站：https://www.httpbin.org

只支持HTTP/1.1

如果需要HTTP/2.0，需要用httpx库，书本P73

### 基本使用

```python
import requests

params = {}
params['name'] = 'wendadawen'
params['age'] = 15

url = 'https://www.httpbin.org/get'

res = requests.get(url=url, verify=False, params=params)
print(res.text)  # res.json()

```

```python
import requests

data = {}
data['name'] = 'wendadawen'
data['age'] = 15

url = 'https://www.httpbin.org/post'

res = requests.post(url=url, verify=False, data=data)
print(res.text)  # res.json()

```

### 添加请求头

```python
import requests

url = 'https://www.httpbin.org/post'
headers= {
    'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Mobile Safari/537.36 Edg/112.0.1722.39'
}
res = requests.post(url=url, verify=False, headers=headers)
print(res.json())

```

### 文件上传

```python
import requests

url = 'https://www.httpbin.org/post'
files = {
    'file' : open('favicon.ico', 'rb')
}
res = requests.post(url=url, verify=False, files=files)
print(res.json())

```

### Session维持

```python
import requests

url = 'https://www.httpbin.org/cookies/set/number/123456789'

s = requests.Session()
s.get(url=url)
res = s.get(url='https://www.httpbin.org/cookies')
print(res.json())
```

### 超时设置

```python
import requests

url = 'https://www.httpbin.org/get'

res = requests.get(url=url, timeout=3)
print(res.text)  # res.json()

```

### 身份认证

```python
import requests

url = 'https://ssr3.scrape.center/'

res = requests.get(url=url, verify=False, auth=('admin', 'admin'))
print(res.text)

```

### 代理设置

```python
import requests

url = 'https://ssr3.scrape.center/'

proxies = {
    'http': 'http://ip:port',
    'https': 'http://ip:port'
}

res = requests.get(url=url, verify=False, proxies=proxies)
print(res.text)

```

# Selenium

[Selenium 的安装 ](https://cuiqingcai.com/33043.html)：pip install -i https://pypi.tuna.tsinghua.edu.cn/simple selenium

ChromeDriver下载：https://chromedriver.storage.googleapis.com/index.html

把exe文件放在python的Scripts目录下

### 基本使用

**[Selenium 常用函数总结_selenium函数_从零开始的数据猿的博客-CSDN博客](https://blog.csdn.net/a12355556/article/details/112299751)**

```python
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.alert import Alert

brower = webdriver.Chrome()
```

### 查找元素

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
brower = webdriver.Chrome()

url = 'http://www.baidu.com/'
brower.get(url)

print(brower.page_source)   # 获取源码

res = brower.find_element(By.ID, 'hotsearch-refresh-btn')
print(res.text)
```

```python
find_element_by_class_name：根据class定位
find_element_by_css_selector：根据css定位
find_element_by_id：根据id定位
find_element_by_link_text：根据链接的文本来定位
find_element_by_name：根据节点名定位
find_element_by_partial_link_text：根据链接的文本来定位，只要包含在整个文本中即可
find_element_by_tag_name：通过tag定位
find_element_by_xpath：使用Xpath进行定位
PS：把element改为elements会定位所有符合条件的元素，返回一个List
比如：find_elements_by_class_name
```

### 节点操作

```python
import time
from selenium import webdriver
from selenium.webdriver.common.by import By

brower = webdriver.Chrome()
brower.get('https://www.taobao.com')
input = brower.find_element(By.ID, 'q')
input.send_keys('iphone')
time.sleep(1)
input.clear()
input.send_keys('ipad')
button = brower.find_element(By.CLASS_NAME, 'btn-search')
button.click()
```

**节点还可以获取信息**

```python
node.get_attribute('src')
node.text
node.id
node.location
node.tag_name
node.size
```

### 鼠标动作

```python
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys


driver = webdriver.Chrome()
driver.get("https://www.baidu.com/")

search_button = driver.find_element(By.ID, "su")

# 单击某个节点
ActionChains(driver).click(search_button).perform()

# 单击某个节点并按住不放
ActionChains(driver).click_and_hold(search_button).perform()

# 右键单击某个节点
ActionChains(driver).context_click(search_button).perform()

# 双击某个节点
ActionChains(driver).double_click(search_button).perform()

# 按住某个节点拖拽到另一个节点
source = driver.find_element(By.ID,"source")
target = driver.find_element(By.ID,"target")
ActionChains(driver).drag_and_drop(source, target).perform()

# 按住节点按偏移拖拽
source = driver.find_element(By.ID, "source")
ActionChains(driver).drag_and_drop_by_offset(source, 100, 100).perform()

# 按下特殊键，只能用(Control, Alt and Shift)，比如Ctrl+C
ActionChains(driver).key_down(Keys.CONTROL).send_keys('c').key_up(Keys.CONTROL).perform()

# 释放鼠标按钮
ActionChains(driver).release().perform()

# 暂停所有的输入多少秒
ActionChains(driver).pause(1).perform()

# 移动鼠标到某个节点的位置
element = driver.find_element(By.ID, "element")
ActionChains(driver).move_to_element(element).perform()

# 鼠标移到某个节点并偏移
element = driver.find_element(By.ID, "element")
ActionChains(driver).move_to_element_with_offset(element, 10, 25).perform()

# 重置操作
ActionChains(driver).reset_actions().perform()

# 模拟按键，比如输入框节点.send_keys(Keys.CONTROL,'a')
input_box = driver.find_element(By.ID, "input_box")
ActionChains(driver).send_keys_to_element(input_box, Keys.CONTROL, 'a').perform()

# 设置输入框内容
ActionChains(driver).send_keys_to_element(input_box, 'Hello World!').perform()

```

### 弹窗和切换Frame

```python
from selenium.webdriver.common.alert import Alert

# 获取当前窗口
driver = webdriver.Chrome()

# 切换到对话框
alert = Alert(driver)

# 确认对话框
alert.accept()

# 关闭对话框
alert.dismiss()

# 给对话框传入值
alert.send_keys("Hello World")

# 获取对话框文本
text = alert.text
```

```python
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.alert import Alert


driver = webdriver.Chrome()
driver.get("https://www.runoob.com/try/try.php?filename=jqueryui-api-droppable")

driver.switch_to.frame('iframeResult')
source = driver.find_element(By.ID, 'draggable')
target = driver.find_element(By.ID, 'droppable')
ActionChains(driver).drag_and_drop(source, target).perform()

alert = Alert(driver)
alert.accept()
```

### 页面前进后退

```python
driver.forward() #前进
driver.back() # 后退
#打印当前url
print(driver.current_url)
```

### 页面截图

```python
driver.save_screenshot(“截图.png”)
```

### 设置代理

```python
from selenium import webdriver
from selenium.webdriver import ChromeOptions

option = ChromeOptions()
proxy = '127.0.0.1:7890'
option.add_argument('--proxy-server=http://' + proxy)
brower = webdriver.Chrome(options=option)

brower.get('https://www.httpbin.org/get')
print(brower.page_source)
brower.close()

```

### 延时等待

```python
brower.implicitly_wait(10)
```

### 选项卡管理

```python
brower.execute_script('window.open()')  # 新开一个选项卡
driver.switch_to.window(driver.window_handles[1])#切换窗口
```

### 反屏蔽

```python
from selenium import webdriver
from selenium.webdriver import ChromeOptions

option = ChromeOptions()
option.add_experimental_option('excludeSwitches', ['enable-aautomation'])
option.add_experimental_option('useAutomationExtension', False)
brower = webdriver.Chrome(options=option)
brower.execute_cdp_cmd('Page.addScriptToEvaluateOnNewDocument',{
    'source': 'Object.defineProperty(navigator, "webdriver", {get: () => undefined})'
})

brower.get('https://antispider1.scrape.center')
```

### 无头模式和窗口大小

```python
from selenium import webdriver
from selenium.webdriver import ChromeOptions

option = ChromeOptions()
option.add_argument('--headless')
brower = webdriver.Chrome(options=option)

brower.maximize_window()  # 最好设置窗口大小
print(brower.get_window_size())
brower.set_window_size(800, 600)  # 最好设置窗口大小
print(brower.get_window_size())

brower.get('http://www.baidu.com')
brower.save_screenshot('hi.png')
```



# 正则表达式

[练习网站](https://regexone.com/)

### match

从头开始匹配

```python
import re

s = '123456adasd'
res = re.match('^(\d+)\w+', s)
print(res.group())  # 123456adasd
print(res.span())  # (0, 11)
print(res.group(1))  # 123456
print(res.span(1))  # (0, 6)
```

### 修饰符

| re.I         | re.S          | re.M               |
| ------------ | ------------- | ------------------ |
| 不区分大小写 | 使 . 匹配换行 | 多行匹配，影响^和$ |

```python
import re

s = '123456adasd'
res = re.match('^(\d+)\w+', s, re.S)
```

### 转义匹配

```python
import re

s = '123456()adasd'
res = re.match('\w+\(\)\w+', s)
print(res.group())
```

### Search

和match不相同的是，search不是从开头匹配

search 只匹配第一个

```python
import re

s = '123456()adasd'
res = re.search('\(\)', s)
print(res.group())
print(res.span())  # (6, 8)
```

### Findall

返回所有匹配成功的列表

```python
import re

s = '123456()adasd'
res = re.findall('\w', s)
# ['1', '2', '3', '4', '5', '6', 'a', 'd', 'a', 's', 'd']
print(res)
```

### Sub

替换字符串所有匹配的结果

```python
import re

s = '123456()adasd'
s = re.sub('\w', '', s)
print(s)  # ()
```

### Compile

```python
import re

s = '123456()adasd'
regex = re.compile('\w', re.S)
res = re.findall(regex, s)
# ['1', '2', '3', '4', '5', '6', 'a', 'd', 'a', 's', 'd']
print(res)
```



# MySql

### 准备

**pip install pymysql**

```python
    db = pymysql.connect(host='localhost', user='root', password='wendadawen', port=3306, db='spiders')
    cursor = db.cursor()
    keys = ', '.join(data.keys())
    values = ', '.join(['%s']*len(data))
    sql = 'INSERT INTO ss1_scrape_result({keys}) values({values})'.format(keys=keys, values=values)
    try:
        cursor.execute(sql, tuple(data.values()))
        db.commit()
    except:
        db.rollback()
    db.close()
```

1、注意创建游标 cursor

2、对表的更新删除插入操作需要 db.commit()

3、对表的查询操作不需要db.commit，需要取出数据cursor.fetchchall()

```python
sql = 'SELECT * FROM student'
cursor.execute(sql)  # 查询信息
data = cursor.fetchall()
print(data)
```



### DDL 

#### 数据库操作

``` sql
show databases ; // 查询所有数据库
select database() ;  // 查询当前数据库
create database [if not exists] 数据库名字 [default charset 字符集] [collate 排序规则] ;  // 创建数据库
drop database [if exists] 数据库名字 ;  // 删除数据库
use 数据库名字 ; // 使用数据库，切换数据库
```

#### 二维表操作

```sql
show tables ; // 查询当前数据库的所有表
desc 表名 ;  // 查询表结构
show create table 表名 ;  // 查询指定表的建表语句
alter table 表名 rename to 新表名 ; // 修改表名
drop table [if exists] 表名 ; // 删除表
truncate table 表名 ; // 删除指定表，并重新创建该表

create table 表名(
	id int [comment '注释'],
    name varchar(50),
    age int,
    gender varchar(1)
) [comment 表注释] ;

show create table 表名 ; // 显示注释
```

``` sql
alter table 表名 add 字段名 类型 [comment 注释] ;  // 增加属性
alter table 表名 modify 字段名 新数据类型 ; // 修改数据类型
alter table 表名 change 旧字段名 新字段名 型数据类型 [comment 注释] [约束] ;  // 修改字段名和字段类型
alter table 表名 drop 字段名 ; 删除字段
```

### DML

```sql
 insert into 表名(字段1， 字段2) values(值1, 值2) ; // 添加数据
 insert into 表名 values(值1, 值2) ; // 添加数据
 insert into 表名(字段名1，字段名2) values(值1，值2)(值1，值2) ; // 添加多组数据
 insert into 表名 values(值1，值2)(值1，值2)(值1，值2) ; // 添加多组数据
```

```sql
update 表名 set 字段名1=值1， 字段名2=值2 [where 条件]
```

```sql
delete from 表名 [where 条件]
```



### DQL

```sql
select 
	字段列表[as]
from
	表名列表[as]
where
	条件列表
group by
	分组字段列表
having
	分组后条件列表
order by
	排序字段列表(asc 升序)(desc 降序)
limit
	分页参数(起始索引编号，每页的长度)
```

```sql
distinct 字段名 ; // 去除重复记录
```

![屏幕截图 2023-03-16 160543](../../../文红兵的快乐学习/课程学习/数据库系统概念/MySql/MySql.assets/屏幕截图 2023-03-16 160543.png)

![屏幕截图 2023-03-16 161839](../../../文红兵的快乐学习/课程学习/数据库系统概念/MySql/MySql.assets/屏幕截图 2023-03-16 161839.png)

![屏幕截图 2023-03-16 164439](../../../文红兵的快乐学习/课程学习/数据库系统概念/MySql/MySql.assets/屏幕截图 2023-03-16 164439.png)

### DCL

```sql
use mysql ; select * from user ; // 查询有多少用户
// 主机名写 % 是可以在任意主机登录
create user '用户名'@'主机名' identified by '密码' ; // 创建用户
alter user '用户名'@'主机名' identified with mysql_native_password by '密码' ;  // 修改用户密码
drop user '用户名'@'主机名' ; // 删除用户
```

![屏幕截图 2023-03-16 181353](../../../文红兵的快乐学习/课程学习/数据库系统概念/MySql/MySql.assets/屏幕截图 2023-03-16 181353.png)

```sql
show grants for '用户名'@'主机名' ;  // 查询权限
grant 权限列表 on 数据库名.表名 to '用户名'@'主机名' ; // 授予权限
revoke 权限列表 on 数据库名.表名 from '用户名'@'主机名' ;  // 撤销权限,可以用*，如*.*
```

# OS模块

```python
import os
os.getcwd()   # 获取当前路径
path = r"D:\Pictures\壁纸"
png_list = os.listdir(path)  # 列出当前文件夹的所有文件

for paths, dirs, files in os.walk(path):  # 返回当前路径，文件夹，文件
    print(paths)
    print(dirs)
    print(files)

os.path.exists(path)  # 路径是否存在
if os.path.exists(path) :
    path = os.path.join(os.getcwd() , r"\文大大文")
    if not os.path.exists(os.getcwd() + r"\文大大文") :
        os.makedirs(os.getcwd() + r"\文大大文")  # 创建文件
    else:
        print("exist")

os.path.join(os.getcwd() , "文大大文")  # 合并路径
os.path.split(os.getcwd() + r"\文大大文")  # 分割相对路径和绝对路径
os.path.isdir(path)  # 是否是文件夹
os.path.isfile(path) # 是否是文件

```

# Matplotlib

## 基本使用

```python
plt.figure() 

plt.scatter(new_data['sepal_size'],new_data['petal_size'])

plt.xlabel('size of sepal')
plt.ylabel('size of petal')
plt.title('Size of Sepal vs Size of Petal')

plt.show()
```



## 介绍

Matplotlib 是专门用于开发 2D 图表（包括 3D 图表）的 python 库

对应的 JS 库有 D3 echarts

官网：[Matplotlib(opens new window)](https://matplotlib.org/index.html)

## 三层结构

容器层

1. 画板层 Canvas
2. 画布层 Figure
3. 绘图层/坐标系

辅助显示层

图像层

## 折线图 plot

以折线的上升或下降来表示统计数量的增减变化的统计图

特点：能够显示数据的变化趋势，反映事物的变化情况。（变化）

```python
# 温度变化折线图
import matplotlib.pyplot as plt
%matplotlib inline
import random

# 1、准备数据
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

# 中文显示问题
plt.rcParams['font.sans-serif']=['SimHei'] #用来正常显示中文标签
plt.rcParams['axes.unicode_minus']=False #用来正常显示负号

# 2、创建画布
plt.figure(figsize=(20,8),dpi=80)

# 3、绘制图像
plt.plot(x, y_shanghai, color="r",linestyle='-.',label="上海")
plt.plot(x, y_beijing, color="b",label="北京")

# 显示图例
plt.legend()
# plt.legend(loc="lower left")
# plt.legend(loc=4)

# 修改x y刻度
x_label = ["11分{}秒".format(i) for i in x]
plt.xticks(x[::5],x_label[::5])
plt.yticks(range(0,40,5))

# 显示网格
plt.grid(linestyle='--', alpha=0.5)

# 添加描述 标题
plt.xlabel("时间")
plt.ylabel("温度")
plt.title("上海、北京11点0分到12点之间的温度变化图示")

# 4、显示图像
plt.show()
```

### 多坐标系

```python
figure, axes = plt.subplots(nrows=1, ncols=1, **fig_kw)
```

```python
# 温度变化折线图
import matplotlib.pyplot as plt
%matplotlib inline
import random

# 1、准备数据
x = range(60)
y_shanghai = [random.uniform(15,18) for i in x]
y_beijing = [random.uniform(1,3) for i in x]

# 2、创建画布
# plt.figure(figsize=(20,8),dpi=80)
figure, axes = plt.subplots(nrows=1,ncols=2,figsize=(20,8),dpi=80)

# 3、绘制图像
axes[0].plot(x, y_shanghai, color="r",linestyle='-.',label="上海")
axes[1].plot(x, y_beijing, color="b",label="北京")

# 显示图例
axes[0].legend()
axes[1].legend()
# plt.legend(loc="lower left")
# plt.legend(loc=4)

# 修改x y刻度
x_label = ["11分{}秒".format(i) for i in x]
axes[0].set_xticks(x[::5])
axes[0].set_xticklabels(x_label[::5])
axes[0].set_yticks(range(0,40,5))
axes[1].set_xticks(x[::5])
axes[1].set_xticklabels(x_label[::5])
axes[1].set_yticks(range(0,40,5))

# 显示网格
axes[0].grid(linestyle='--', alpha=0.5)
axes[1].grid(linestyle='--', alpha=0.5)

# 添加描述 标题
axes[0].set_xlabel("时间")
axes[0].set_ylabel("温度")
axes[0].set_title("上海11点0分到12点之间的温度变化图示")

axes[1].set_xlabel("时间")
axes[1].set_ylabel("温度")
axes[1].set_title("北京11点0分到12点之间的温度变化图示")

# 4、显示图像
plt.show()
```

### 数学函数

```python
import matplotlib.pyplot as plt
%matplotlib inline
import numpy as np

# 1、准备x、y数据
x = np.linspace(-1,1,1000)
y = 2 * x * x

# 2、创建画布
plt.figure(figsize=(20,8), dpi=80)

# 3、绘制图像
plt.plot(x, y)

plt.grid(linestyle="--",alpha=0.5)

plt.show()
```



## 散点图 scatter

用两组数据构成多个坐标点，考察坐标点的分布，判断两变量之间是否存在某种关联或总结坐标点的分布模式。

特点：判断变量之间是否存在数量关联趋势，展示离群点（分布规律）

```python
# 1、准备数据
x = [225.98, 247.07, 253.14, 457.85, 241.58, 301.01,  20.67, 288.64,
       163.56, 120.06, 207.83, 342.75, 147.9 ,  53.06, 224.72,  29.51,
        21.61, 483.21, 245.25, 399.25, 343.35]

y = [196.63, 203.88, 210.75, 372.74, 202.41, 247.61,  24.9 , 239.34,
       140.32, 104.15, 176.84, 288.23, 128.79,  49.64, 191.74,  33.1 ,
        30.74, 400.02, 205.35, 330.64, 283.45]
# 2、创建画布
plt.figure(figsize=(20, 8), dpi=80)

# 3、绘制图像
plt.scatter(x, y)

# 4、显示图像
plt.show()
```



## 柱状图 bar

排列在工作表的列或行中的数据可以绘制到柱状图中。

特点：绘制连离散的数据，能够一眼看出名个数据的大小，比较数据之间的差别（统计/对比）

```python
# 1、准备数据
movie_names = ['雷神3：诸神黄昏','正义联盟','东方快车谋杀案','寻梦环游记','全球风暴', '降魔传','追捕','七十七天','密战','狂兽','其它']
tickets = [73853,57767,22354,15969,14839,8725,8716,8318,7916,6764,52222]

# 2、创建画布
plt.figure(figsize=(20, 8), dpi=80)

# 3、绘制柱状图
x_ticks = range(len(movie_names))
plt.bar(x_ticks, tickets, color=['b','r','g','y','c','m','y','k','c','g','b'])

# 修改x刻度
plt.xticks(x_ticks, movie_names)

# 添加标题
plt.title("电影票房收入对比")

# 添加网格显示
plt.grid(linestyle="--", alpha=0.5)

# 4、显示图像
plt.show()
```



## 直方图 histogram

由一系列高度不等的纵向条纹或线段表示数据分布的情况。一般用横轴表示数据范围，纵轴表示分布情况。

特点：绘制连续性的数据展示一组或者多组数据的分布状况（统计）

直方图牵涉统计学的概念，首先要对数据进行分组，然后统计每个分组内数据元的数量。在坐标系中，横轴标出每个组的端点，纵轴表示频数，每个矩形的高代表对应的频数，称这样的统计图为频数分布直方图。

### 直方图与柱状图的区别

1. 直方图展示数据的分布，柱状图比较数据的大小（最根本的区别）
2. 直方图 X 轴为定量数据，柱状图 X 轴为分类数据
3. 直方图柱子无间隔，柱状图柱子有间隔
4. 直方图柱子宽度可不一，柱状图柱子宽度须一致

```python
# 需求：电影时长分布状况
# 1、准备数据
time = [131,  98, 125, 131, 124, 139, 131, 117, 128, 108, 135, 138, 131, 102, 107, 114, 119, 128, 121, 142, 127, 130, 124, 101, 110, 116, 117, 110, 128, 128, 115,  99, 136, 126, 134,  95, 138, 117, 111,78, 132, 124, 113, 150, 110, 117,  86,  95, 144, 105, 126, 130,126, 130, 126, 116, 123, 106, 112, 138, 123,  86, 101,  99, 136,123, 117, 119, 105, 137, 123, 128, 125, 104, 109, 134, 125, 127,105, 120, 107, 129, 116, 108, 132, 103, 136, 118, 102, 120, 114,105, 115, 132, 145, 119, 121, 112, 139, 125, 138, 109, 132, 134,156, 106, 117, 127, 144, 139, 139, 119, 140,  83, 110, 102,123,107, 143, 115, 136, 118, 139, 123, 112, 118, 125, 109, 119, 133,112, 114, 122, 109, 106, 123, 116, 131, 127, 115, 118, 112, 135,115, 146, 137, 116, 103, 144,  83, 123, 111, 110, 111, 100, 154,136, 100, 118, 119, 133, 134, 106, 129, 126, 110, 111, 109, 141,120, 117, 106, 149, 122, 122, 110, 118, 127, 121, 114, 125, 126,114, 140, 103, 130, 141, 117, 106, 114, 121, 114, 133, 137,  92,121, 112, 146,  97, 137, 105,  98, 117, 112,  81,  97, 139, 113,134, 106, 144, 110, 137, 137, 111, 104, 117, 100, 111, 101, 110,105, 129, 137, 112, 120, 113, 133, 112,  83,  94, 146, 133, 101,131, 116, 111,  84, 137, 115, 122, 106, 144, 109, 123, 116, 111,111, 133, 150]

# 2、创建画布
plt.figure(figsize=(20, 8), dpi=80)

# 3、绘制直方图
distance = 2
group_num = int((max(time) - min(time)) / distance)

plt.hist(time, bins=group_num, density=True)

# 修改x轴刻度
plt.xticks(range(min(time), max(time) + 2, distance))

# 添加网格
plt.grid(linestyle="--", alpha=0.5)

# 4、显示图像
plt.show()
```



## 饼图 pie

用于表示不同分类的占比情况，通过弧度大小来对比各种分类。

特点：分类数据的占比情况（占比）

```python
# 1、准备数据
movie_name = ['雷神3：诸神黄昏','正义联盟','东方快车谋杀案','寻梦环游记','全球风暴','降魔传','追捕','七十七天','密战','狂兽','其它']

place_count = [60605,54546,45819,28243,13270,9945,7679,6799,6101,4621,20105]

# 2、创建画布
plt.figure(figsize=(20, 8), dpi=80)

# 3、绘制饼图
plt.pie(place_count, labels=movie_name, colors=['b','r','g','y','c','m','y','k','c','g','y'], autopct="%1.2f%%")

# 显示图例
plt.legend()

plt.axis('equal')

# 4、显示图像
plt.show()
```

# Numpy

## 基本使用

```python
# 创建ndarray
arr = np.array([
    [1,2,3],
    [3,4,5],
    [5,6,7]
])

# shape
arr.shape

# size
arr.size

# dtype
arr.dtype

# 修改type
arr.astype("float32")

# 常见ndarray
np.ones((3,3))
np.zeros((3,3))

# 快速生成一维array
np.linspace(-10, 10, 100)
np.arange(-10, 10, 1)

# 随机数
np.random.uniform(low = -1, high = 1, size = 100)
np.random.normal(0, 1, (3,3))
np.random.randn((6,4))

# 修改形状
arr.reshape((10, 8)) # 返回新的ndarray,原始数据没有改变
arr.resize((10, 8)) # 没有返回值，对原始的ndarray进行了修改

# 去重
np.unique(arr)

# 矩阵运算
np.dot(arr1, arr2)
```



## 介绍

Numpy (Numerical Python) 是一个开源的 Python 科学计算库，用于快速处理任意维度的数组。

Numpy 支持常见的数组和矩阵操作。对于同样的数值计算任务，使用 Numpy 比直接使用 Python 要简洁的多。

Numpy 使用 ndarray 对象来处理多维数组，该对象是一个快速而灵活的大数据容器。

## ndarray

NumPy 提供了一个 N 维数组类型 ndarray，它描述了相同类型的"items"的集合

### 优势

1. 存储风格
    - ndarray - 相同类型 - 通用性不强
    - list - 不同类型 - 通用性很强
2. 并行化运算
    - ndarray 支持向量化运算
3. 底层语言
    - Numpy 底层使用 C 语言编写，内部解除了 GIL（全局解释器锁），其对数组的操作速度不受 Python 解释器的限制，效率远高于纯 Python 代码。

### 属性

| 属性名字         | 属性解释                   |
| ---------------- | -------------------------- |
| ndarray.shape    | 数组维度的元组             |
| ndarray.ndim     | 数组维数                   |
| ndarray.size     | 数组中的元素数量           |
| ndarray.itemsize | 一个数组元素的长度（字节） |
| ndarray.dtype    | 数组元素的类型             |

在创建 ndarray 的时候，如果没有指定类型，默认：整数 int64/int32 浮点数 float64/float32

### 使用

```python
import numpy as np
score = np.array([[80, 89, 86, 67, 79],
[78, 97, 89, 67, 81],
[90, 94, 78, 67, 74],
[91, 91, 90, 67, 69],
[76, 87, 75, 67, 86],
[70, 79, 84, 67, 84],
[94, 92, 93, 67, 64],
[86, 85, 83, 67, 80]])
print(type(score))
print(score.shape)
print(score.dtype)
```



```python
# 创建数组的时候指定类型
np.array([1.1, 2.2, 3.3], dtype="float32")
```

## 基本操作

### 生成数组

#### 1、生成 0 和 1 的数组

```python
np.zeros(shape=(3, 4), dtype="float32") # 生成一组0
np.ones(shape=[2, 3], dtype=np.int32) # 生成一组1
```



#### 2、从现有数组生成

```python
data1 = np.array(score) # 深拷贝
data2 = np.asarray(score) # 浅拷贝
data3 = np.copy(score) # 深拷贝
```



#### 3、生成固定范围的数组

```python
np.linspace(0, 10, 5) # 生成[0,10]之间等距离的5个数
np.arange(0, 11, 5) # [0,11)，5为步长生成数组
```



#### 4、生成随机数组

```python
# 生成均匀分布的一组数[low,high)
data1 = np.random.uniform(low=-1, high=1, size=1000000)
# 生成正态分布的一组数，loc：均值；scale：标准差
data2 = np.random.normal(loc=1.75, scale=0.1, size=1000000)
```



### 数组的索引、切片

```python
stock_change = np.random.normal(loc=0, scale=1, size=(8, 10))
# 获取第一个股票的前3个交易日的涨跌幅数据
print(stock_change[0, :3])
a1[1, 0, 2] = 100000
```



### 形状修改

```python
stock_change.reshape((10, 8)) # 返回新的ndarray,原始数据没有改变
stock_change.resize((10, 8)) # 没有返回值，对原始的ndarray进行了修改
stock_change.T # 转置 行变成列，列变成行
```

### 类型修改

```python
stock_change.astype("int32")
stock_change.tostring() # ndarray序列化到本地
```



### 数组去重

```python
temp = np.array([[1, 2, 3, 4],[3, 4, 5, 6]])
np.unique(temp)
set(temp.flatten())
```

## ndarray 运算

### 逻辑运算

#### 运算符

```python
# 逻辑判断, 如果涨跌幅大于0.5就标记为True 否则为False
stock_change > 0.5
stock_change[stock_change > 0.5] = 1.1
```

#### 通用判断函数

```python
# 判断stock_change[0:2, 0:5]是否全是上涨的
np.all(stock_change[0:2, 0:5] > 0)
# 判断前5只股票这段期间是否有上涨的
np.any(stock_change[:5, :] > 0)
```

#### 三元运算符

```python
# np.where(布尔值，True的位置的值，False的位置的值)
np.where(temp > 0, 1, 0)
# 大于0.5且小于1
np.where(np.logical_and(temp > 0.5, temp < 1), 1, 0)
# 大于0.5或小于-0.5
np.where(np.logical_or(temp > 0.5, temp < -0.5), 11, 3)
```



### 统计运算

#### 统计指标函数

min,max,mean(均值),median(中位数),var(方差),std(标准差)

```python
temp.max(axis=0)
np.max(temp, axis=1)
```

返回最大值、最小值的位置

np.argmax(tem,axis=)

np.argmin(tem,axis=)

```python
np.argmax(temp, axis=-1)
```

### 数组间运算

#### 数组与数的运算

```python
arr = np.array([[1, 2, 3, 2, 1, 4], [5, 6, 1, 2, 3, 1]])
arr / 10
```



#### 数组与数组的运算

##### 广播机制

执行 broadcast 的前提在于，两个 nadarray 执行的是 element-wise 的运算，Broadcast 机制的功能是为了方便不同形状的 ndarray(numpy 库的核心数据结构)进行数学运算。

当操作两个数组时，numpy 会逐个比较它们的 shape(构成的元组 tuple)，只有在下述情况下，两个数组才能够进行数组与数组的运算。

- 维度相等
- shape（其中相对应的一个地方为 1）

#### 矩阵运算

英文 matrix，和 array 的区别是矩阵必须是 2 维的，但是 array 可以是多维的。

矩阵和二维数组的区别？

np.mat() 将数组转换成矩阵类型

矩阵乘法规则（M 行,N 列）x (N 行,L 列) = (M 行,L 列)

如果是 ndarray

```python
np.dot(data,data1)
np.matmul(data,data1)
data @ data1
```

如果是 martix

```python
data*data1
```

## 合并、分割

numpy.hstack 水平拼接

numpy.vstack 竖拼接

numpy.concatenate((a1,a2),axis=0) 水平|竖拼接

```python
# 分割
numpy.split(x,3) # 分三份
numpy.split(x,[3,4,6,10]) # 按索引分割
```

# Pandas

## 基本操作

```python
# 创建
dates = pd.date_range('today', periods=6)
arr = np.random.randn(6, 4)
columns = ['A', 'B', 'C', 'D']
pd.DataFrame(arr, index = dates, columns = columns)

# 定位
data1 = data.loc[data.index[:4], ["year", "passengers"]]
data['year'] # 列
data[["year", "passengers"]]

# 分组
data.groupby(["year"])["passengers"].sum()

# 索引
data.index

# 设置索引
data.set_index("year", drop=True)

# 添加列数据
data['new_data'] = xxx

# 添加行数据
data.loc['index'] = ["data1", 'data2']

# 删除行数据
data = data.drop(['index'])

# 删除列数据
data = data.drop(['列1'], axis = 1)

# 提取类别
sexs = data['sex'].unique()  # 男 ， 女

# 读取csv
pd.read_csv("test.csv")  
# 如果第一行没有表头，就默认作为index，如果都有表头，就自然索引
# 默认将第一行作为表头，pd.read_csv(header = None)可以没有表头
# index_col = False 代表用自然索引
pd.read_csv("test.csv", header = 0, index_col = False)
# names = ['列1', '列2'] 可以读取特定的列

# 处理NAN
np.any(pd.isnull(data)) # 判断有无NAN
data.dropna(inplace=True)  # 删除NAN列，True 原地修改
data.fill(0,inplace=True)  # 填充NAN为0，True 原地修改

# 转字典
data.to_dict(orient="records")  # 方便特征提取
```



## 介绍

- 2008 年 WesMcKinney 开发出的库
- 专门用于数据挖掘的开源 Python 库
- 以 Numpy 为基础，借力 Numpy 模块在计算方面性能高的优势
- 基于 matplotlib，能够简便的画图
- 独特的数据结构

### 为什么用？

- 便捷的数据处理能力
- 读取文件方便
- 封装了 Matplotlib、Numpy 的画图和计算

### 核心数据结构

- DataFrame
- Pannel
- Series

### DataFrame

#### 结构

既有行索引，又有列索引的二维数组

行索引，表明不同行，横向索引，叫 index

列索引，表明不同列，纵向索引，叫 columns

#### 常用属性

shape

index 行索引列表

columns 列索引列表

values 直接获取其中 array 的值

T 行列转置

#### 常用方法

head() 开头几行

tail() 最后几行

```python
import numpy as np
import pandas as pd
# 创建一个符合正态分布的10个股票5天的涨跌幅数据
stock_change = np.random.normal(0, 1, (10, 5))
pd.DataFrame(stock_change)
# 添加行索引
stock = ["股票{}".format(i) for i in range(10)]
pd.DataFrame(stock_change, index=stock)
# 添加列索引
date = pd.date_range(start="20200101", periods=5, freq="B")
data = pd.DataFrame(stock_change, index=stock, columns=date)

# 属性
print(data.shape)
print(data.index)
print(data.columns)
print(data.values)
data.T # 行列转置

# 方法
data.head(3) # 开头3行
data.tail(2) # 最后2行
```



####  索引的设置

```python
# 修改行列索引值
# data.index[2] = "股票88" 不能单独修改索引
stock_ = ["股票_{}".format(i) for i in range(10)]
data.index = stock_

# 重设索引
data.reset_index(drop=False) # drop=True把之前的索引删除

# 设置新索引
df = pd.DataFrame({'month': [1, 4, 7, 10],
                    'year': [2012, 2014, 2013, 2014],
                    'sale':[55, 40, 84, 31]})
# 以月份设置新的索引
df.set_index("month", drop=True)
# 设置多个索引，以年和月份
new_df = df.set_index(["year", "month"])
```



###  MultiIndex 与 Panel

####  MultiIndex

多级或分层索引对象

- index 属性
    - names: levels 的名称
    - levels: 每个 level 的元组值

```python
print(new_df.index)
print(new_df.index.names)
print(new_df.index.levels)
```



####  Panel

pandas.Panel(data=None,items=None,major_axis=None,minor_axis=None,copy=False,dtype=None)

存储 3 维数组的 Panel 结构

- items - axis 0，每个项目对应于内部包含的数据帧(DataFrame)。
- major_axis - axis 1，它是每个数据帧(DataFrame)的索引(行)。
- minor_axis - axis 2，它是每个数据帧(DataFrame)的列。

```python
p = pd.Panel(np.arange(24).reshape(4,3,2),
                 items=list('ABCD'),
                 major_axis=pd.date_range('20130101', periods=3),
                 minor_axis=['first', 'second'])
p["A"]
p.major_xs("2013-01-01")
p.minor_xs("first")
```



注：Pandas 从版本 0.20.0 开始弃用，推荐的用于表示 3D 数据的方法是 DataFrame 上的 MultiIndex 方法

###  Series

带索引的一维数组

####  属性

- index
- values

```python
# 创建
pd.Series(np.arange(3, 9, 2), index=["a", "b", "c"])
# 或
pd.Series({'red':100, 'blue':200, 'green': 500, 'yellow':1000})

sr = data.iloc[1, :]
sr.index # 索引
sr.values # 值
```



总结：DataFrame 是 Series 的容器，Panel 是 DataFrame 的容器

##  基本数据操作

###  索引操作

```python
data = pd.read_csv("./stock_day/stock_day.csv")
data = data.drop(["ma5","ma10","ma20","v_ma5","v_ma10","v_ma20"], axis=1) # 去掉一些不要的列
data["open"]["2018-02-26"] # 直接索引，先列后行
data[["open", "ma5"]]

data.loc["2018-02-26"]["open"] # 按名字索引
data.loc["2018-02-26", "open"]
data.iloc[1, 0] # 数字索引

# 组合索引
# 获取行第1天到第4天，['open', 'close', 'high', 'low']这个四个指标的结果
data.iloc[:4, ['open', 'close', 'high', 'low']] # 不能用了
data.loc[data.index[0:4], ['open', 'close', 'high', 'low']]
data.iloc[0:4, data.columns.get_indexer(['open', 'close', 'high', 'low'])]
```



### 赋值操作

```python
data.open = 100
data.iloc[1, 0] = 222
```



###  排序操作

排序有两种形式，一种对内容进行排序，一种对索引进行排序

####  内容排序

使用 df.sort_values(key=,ascending=)对内容进行排序

单个键或者多个键进行排序，默认升序

ascending=False:降序 True:升序

#### 索引排序

使用 df.sort_index 对索引进行排序

```python
data.sort_values(by="high", ascending=False) # DataFrame内容排序

data.sort_values(by=["high", "p_change"], ascending=False).head() # 多个列内容排序

data.sort_index().head()

sr = data["price_change"]

sr.sort_values(ascending=False).head()

sr.sort_index().head()
```



## DataFrame 运算

### 算术运算

```python
data["open"].add(3).head() # open统一加3  data["open"] + 3
data.sub(100).head() # 所有统一减100 data - 100
data["close"].sub(data["open"]).head() # close减open
```



### 逻辑运算

query(expr) expr:查询字符串

isin(values) 判断是否为 values

```python
data[data["p_change"] > 2].head() # p_change > 2
data[(data["p_change"] > 2) & (data["low"] > 15)].head()

data.query("p_change > 2 & low > 15").head()

# 判断'turnover'是否为4.19, 2.39
data[data["turnover"].isin([4.19, 2.39])]
```



### 统计运算

describe()

综合分析：能够直接得出很多统计结果，count,mean,std,min,max 等

```python
data.describe()
data.max(axis=0)
data.idxmax(axis=0) #最大值位置
```



#### 累计统计函数

cumsum 计算前 1/2/3/../n 个数的和

cummax 计算前 1/2/3/../n 个数的最大值

cummin 计算前 1/2/3/../n 个数的最小值

cumprod 计算前 1/2/3/../n 个数的积

```python
data["p_change"].sort_index().cumsum().plot()
```



### 自定义运算

apply(func, axis=0)

func: 自定义函数

axis=0: 默认按列运算，axis=1 按行运算

```python
data.apply(lambda x: x.max() - x.min())
```



## Pandas 画图

### pandas.DataFrame.plot

DataFrame.plot(x=None, y=None, kind='line')

- x: label or position, default None
- y: label, position or list of label, positions, default None
    - Allows plotting of one column versus another
- kind: str
    - 'line': line plot(default)
    - ''bar": vertical bar plot
    - "barh": horizontal bar plot
    - "hist": histogram
    - "pie": pie plot
    - "scatter": scatter plot
    - “boxplot”：箱线图

```python
data.plot(x="volume", y="turnover", kind="scatter")
data.plot(x="high", y="low", kind="scatter")
```



### pandas.Series.plot

```python
sr.plot(kind="line")
```



## 文件读取与存储

### CSV

```python
pd.read_csv("./stock_day/stock_day.csv", usecols=["high", "low", "open", "close"]).head() # 读哪些列

data = pd.read_csv("stock_day2.csv", names=["open", "high", "close", "low", "volume", "price_change", "p_change", "ma5", "ma10", "ma20", "v_ma5", "v_ma10", "v_ma20", "turnover"]) # 如果列没有列名，用names传入

data[:10].to_csv("test.csv", columns=["open"]) # 保存open列数据

data[:10].to_csv("test.csv", columns=["open"], index=False, mode="a", header=False) # 保存opend列数据，index=False不要行索引，mode="a"追加模式|mode="w"重写，header=False不要列索引
```



### HDF5

read_hdf()与 to_hdf()

HDF5 文件的读取和存储需要指定一个键，值为要存储的 DataFrame

pandas.read_hdf(path_or_buf, key=None, **kwargs)

从 h5 文件当中读取数据

- path_or_buffer: 文件路径
- key: 读取的键
- mode: 打开文件的模式
- reurn: The Selected object

DataFrame.to_hdf(path_or_buf, key, **kwargs)

```python
day_close = pd.read_hdf("./stock_data/day/day_close.h5")
day_close.to_hdf("test.h5", key="close")
```



### JSON

read_json()

pandas.read_json(path_or_buf=None,orient=None,typ="frame",lines=False)

- 将 JSON 格式转换成默认的 Pandas DataFrame 格式
- orient: string,Indication of expected JSON string format.
    - 'split': dict like {index -> [index], columns -> [columns], data -> [values]}
    - 'records': list like [{column -> value}, ..., {column -> value}]
    - 'index': dict like {index -> {column -> value}}
    - 'columns': dict like {column -> {index -> value}}, 默认该格式
    - 'values': just the values array
- lines: boolean, default False
    - 按照每行读取 json 对象
- typ: default 'frame'，指定转换成的对象类型 series 或者 dataframe

```python
sa = pd.read_json("Sarcasm_Headlines_Dataset.json", orient="records", lines=True)

sa.to_json("test.json", orient="records", lines=True)
```



## 缺失值处理

- replace 实现数据替换
- dropna 实现缺失值的删除
- fillna 实现缺失值的填充
- isnull 判断是否有缺失数据 NaN

如何进行缺失值处理？

- 删除含有缺失值的样本
- 替换/插补数据

### 如何处理 NaN?

- 判断是否有 NaN
    - pd.isnull(df)
    - pd.notnull(df)
- 删除含有缺失值的样本
    - df.dropna(inplace=True) 默认按行删除 inplace:True 修改原数据，False 返回新数据，默认 False
- 替换/插补数据
    - df.fillna(value,inplace=True) value 替换的值 inplace:True 修改原数据，False 返回新数据，默认 False

```python
import pandas as pd
import numpy as np
movie = pd.read_csv("./IMDB/IMDB-Movie-Data.csv")
# 1）判断是否存在NaN类型的缺失值
np.any(pd.isnull(movie)) # 返回True，说明数据中存在缺失值
np.all(pd.notnull(movie)) # 返回False，说明数据中存在缺失值
pd.isnull(movie).any()
pd.notnull(movie).all()

# 2）缺失值处理
# 方法1：删除含有缺失值的样本
data1 = movie.dropna()
pd.notnull(data1).all()

# 方法2：替换
# 含有缺失值的字段
# Revenue (Millions)
# Metascore
movie["Revenue (Millions)"].fillna(movie["Revenue (Millions)"].mean(), inplace=True)
movie["Metascore"].fillna(movie["Metascore"].mean(), inplace=True)
```



### 不是缺失值 NaN

不是缺失值 NaN，有默认标记的

```python
# 读取数据
path = "https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data"
name = ["Sample code number", "Clump Thickness", "Uniformity of Cell Size", "Uniformity of Cell Shape", "Marginal Adhesion", "Single Epithelial Cell Size", "Bare Nuclei", "Bland Chromatin", "Normal Nucleoli", "Mitoses", "Class"]

data = pd.read_csv(path, names=name)

# 1）替换
data_new = data.replace(to_replace="?", value=np.nan)

# 2）删除缺失值
data_new.dropna(inplace=True)
```

## 数据离散化

### 什么是数据的离散化

连续属性的离散化就是将连续属性的值域上，将值域划分为若干个离散的区间，最后用不同的符号或整数 值代表落在每个子区间的属性值。

### 为什么要离散化

连续属性离散化的目的是为了简化数据结构，数据离散化技术可以用来减少给定连续属性值的个数。离散化方法经常作为数据挖掘的工具。

### 如何实现数据的离散化

1. 分组

    - 自动分组 sr = pd.qcut(data, bins)
    - 自定义分组 sr = pd.cut(data, [])

2. 将分组好的结果转换成 one-hot 编码（哑变量）

    pd.get_dummies(sr, prefix=)

```python
# 1）准备数据
data = pd.Series([165,174,160,180,159,163,192,184], index=['No1:165', 'No2:174','No3:160', 'No4:180', 'No5:159', 'No6:163', 'No7:192', 'No8:184'])
# 2）分组
# 自动分组
sr = pd.qcut(data, 3)
sr.value_counts()  # 看每一组有几个数据
# 3）转换成one-hot编码
pd.get_dummies(sr, prefix="height")

# 自定义分组
bins = [150, 165, 180, 195]
sr = pd.cut(data, bins)
# get_dummies
pd.get_dummies(sr, prefix="身高")
```

## 合并

### 按方向

pd.concat([data1, data2], axis=1) axis：0 为列索引；1 为行索引

### 按索引

pd.merge(left, right, how="inner", on=[]) on：索引

```python
left = pd.DataFrame({'key1': ['K0', 'K0', 'K1', 'K2'],
                        'key2': ['K0', 'K1', 'K0', 'K1'],
                        'A': ['A0', 'A1', 'A2', 'A3'],
                        'B': ['B0', 'B1', 'B2', 'B3']})

right = pd.DataFrame({'key1': ['K0', 'K1', 'K1', 'K2'],
                        'key2': ['K0', 'K0', 'K0', 'K0'],
                        'C': ['C0', 'C1', 'C2', 'C3'],
                        'D': ['D0', 'D1', 'D2', 'D3']})

pd.merge(left, right, how="inner", on=["key1", "key2"])

pd.merge(left, right, how="left", on=["key1", "key2"])

pd.merge(left, right, how="outer", on=["key1", "key2"])
```

## 交叉表与透视表

找到、探索两个变量之间的关系

### 交叉表

交叉表用于计算一列数据对于另外一列数据的分组个数（寻找两个列之间的关系）

pd.crosstab(value1, value2)

```python
data = pd.crosstab(stock["week"], stock["pona"])
data.div(data.sum(axis=1), axis=0).plot(kind="bar", stacked=True)
```



### 透视表

DataFrame.pivot_table([], index=[])

```python
# 透视表操作
stock.pivot_table(["pona"], index=["week"])
```



## 分组与聚合

分组与聚合通常是分析数据的一种方式，通常与一些统计函数一起使用，查看数据的分组情况。

DataFrame.groupby(key, as_index=False) key：分组的列数据，可以多个

```python
col =pd.DataFrame({'color': ['white','red','green','red','green'], 'object': ['pen','pencil','pencil','ashtray','pen'],'price1':[5.56,4.20,1.30,0.56,2.75],'price2':[4.75,4.12,1.60,0.75,3.15]})

# 进行分组，对颜色分组，price1进行聚合
# 用dataframe的方法进行分组
col.groupby(by="color")["price1"].max()

# 或者用Series的方法进行分组聚合
col["price1"].groupby(col["color"]).max()
```

# Seaborn

# Sklearn

"机器学习" and "sklearn_test.ipynb"






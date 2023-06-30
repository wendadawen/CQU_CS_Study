# 安装配置

[Go下载地址](https://studygolang.com/dl)

下载：$windows-amd64.zip$

直接解压就用，记得配置环境变量

$API文档查询：$[查询](https://studygolang.com/pkgdoc)

$IDE:$

- VSCode: 下载go配置环境变量直接写就完事了，缺点是不能直接运行，要配置插件，但是插件安装及其复杂，不推荐
- GoLand：官网下载安装，[破解]([GoLand 2022.2.4 破解版图文教程详解windows,mac,linux均适用（2022.11.7日亲测可用） - FrankStan - 博客园 (cnblogs.com)](https://www.cnblogs.com/fdw630/p/16866751.html)), 然后跟着这个：[GoLand 快速入门教程_恋喵大鲤鱼的博客-CSDN博客](https://blog.csdn.net/K346K346/article/details/105554216)

# 快速上手

- 运行代码用 go run xxx 或者 go build xxx

- go区分大小写
- go写程序类似python，不写分号
- 导入的包或者变量必须使用，不然报错
- 同一个目录下的**同级**的所有`go`文件应该属于一个包；
- 包的名称可以跟目录不同名，不过建议同名；
- 一个`Go`语言程序有且只有一个`main`函数，他是`Go`语言程序的入口函数，且必须属于`main`包，没有或者多于一个进行`Go语言`程序编译时都会报错；
- 需要注意的是 **{** 不能单独放在一行，所以以下代码在运行时会产生错误：

```go
package main
import (
	"fmt"
    "unsafe"
)
func main(){
   
}
```

# 变量

## 注意点和使用方式

注意点：

- 变量不赋值会有默认值
- 根据值自行判断值的类型，类型推导

变量的三种使用方式

```go
var num = 10 // 类型推导
var num int = 10  // 指定变量类型
num := 10  // 更加简便的写法，省略var，:=左边的变量应该是新定义的变量
```

多变量使用方式

```go
var n, m, p, q int  // 多变量指定类型相同
var n, s = 100, "string" // 不同类型
n, s := 100, "string"
```

一种简介的方式

```go
package main
import "fmt"
func main() {
	var (
		n = 100
		s = "string"
	)
	fmt.Println("n=", n, "s=", s)
}
```

## 数据类型

```go
fmt.Printf("%T", n) // 查看类型
```

`整数`：`int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 uintptr rune byte` 

- 使用细节，int字节数看系统，rune可以放中文字符，byte可以用放字符

`浮点数`：`float32 float64`

`字符串`：`string`

- golang没有专门的字符组成，而是由单个字节组成，使用utf-8解码
- golang字符串是不可以变的
- 可以用反引号把文本按原输出

`字符类型`：`var ch byte = 'a'` `var ch int= '文'`

- golang字符使用utf-8，uft-8兼容ascil
- 英文字母一个字节，中文3个字节

`布尔类型`：`bool`

- 只有一个字节
- 只能去true或者false

`复数`：`complex64 complex128`

## 数据类型转化

- golang没有隐式转化，只有显示转化

```go
T(val)  // 把val转化成为T类型
```

基本数据类型与string的转化

- `fmt.Sprintf()`返回转化后的字符串，格式化用v输出值，T输出类型

```go
package main

import "fmt"

func main() {
	tag := false
	var s = fmt.Sprintf("%v", tag)
	fmt.Printf("%v  %T", s, s)
}

```

- strconv包来转化

## 指针

- 获取变量地址用`&`

```go
var ptr *int = &num
```

- 取值

```go
var num = *ptr
```

# 标识符

- 当标识符（包括常量、变量、类型、函数名、结构字段等等）以一个大写字母开头，如：Group1，那么使用这种形式的标识符的对象就可以被外部包的代码所使用（客户端程序需要先导入这个包），这被称为导出（像面向对象语言中的 public）；标识符如果以小写字母开头，则对包外是不可见的，但是他们在整个包的内部是可见并且可用的（像面向对象语言中的 protected ）。
- `_`是特殊的关键词，表示忽略，不能使用

# 运算符

- 算术运算符和c++一样，只不过没有前置++或者- -，如：`-- a 或者 ++ a`
- 其他运算符和c++一摸一样

- golang没有三元运算符

# 获取键盘输入

- `fmt.Scanfln`读取一行数据
- `fmt.Scanf`读取

```go
package main
import "fmt"
func main() {
	var name string
	var age byte
	var sal float32
	var isPass bool
	_, _ = fmt.Scanf("%s %d %f %t\n", &name, &age, &sal, &isPass)
	fmt.Println(name, age, sal, isPass)
	_, _ = fmt.Scanln(&name)
	fmt.Println(name)
}
```

# 程序控制

## 分支控制

- golang支持在if中直接定义一个变量,只能在局部使用

```go
if age := 20; age > 18 { // 一条语句也必须带上括号
	// 执行代码
} else if age > 18 {
    
} else if age == 18 {
    
}
```

## switch

```go
	var key = 'a'
	switch key {
	case 'a', 'e', 'd':  // 多个选择，而且不用加break
		fmt.Println('a')
        fallthrough  // 穿透，顺序执行下一条语句，不需要判断下一条语句条件是否满足
	case 'b':
		fmt.Println('b')
	case 'c':
		fmt.Println('c')
	default:
		fmt.Println("else")
	}
```

## for循环控制

- 第一种写法

```go
for i := 1; i <= 10; i ++ {
    fmt.Println("hello world")
}
```

- 第二种写法

```go
j := 1
for j <= 10 {
    fmt.Println("hello world")
    j ++ 
}
```

- 第三中写法

```go
for {
    fmt.Println("hello world")
    if a == 1 {
        break;
    }
}
```

- for range遍历

```go
var s string = "hello world hello 北京"
for i := 0; i <= len(s); i ++ {  // 按字节输出，会乱码
    fmt.Println(s[i])
}
for index, val := range str {  // 按字符输出，不会乱码
    fmt.Println(val)
}
```

## break

- break可以跳出当前循环
- break也可以指定跳出多重循环`break label`

```go
lable2:
for i := 1; i <= 10; i ++ {
    label1: 
    for j := 1; j <= 10; j ++ {
        break label2   // 跳出二层循环，如果写label1就是跳出一层循环
    }
}
```

## continue

- 和c++一摸一样

# 函数

```go
func 函数名(形参列表)(返回值列表) {
    // 函数体
    return 返回值列表
}
```

```go
func cal(n int, m int) int {
    return n + m
}
```

- 支持对函数返回值命名

```go
func cal(n1 int, n2 int) (sum int, sub int) {
    sum = n1 + n2
    sub = n1 - n2
    return
}
```

- 基本数据类型和**数组**默认都是值传递，函数内修改不会影响到原本函数的值，值类型参数默认值传递，引用类型参数默认引用传递
- 函数本身也是一种数据类型，可以赋值给一个变量，该变量是一个函数类型的变量。

```go
func getsum(n1 int, n2 int) int {
    return n1 + n2
}
func main() {
    var a = getsum
    var res = a(10, 20)
    fmt.Println("res = ", res)
}
```

- 函数既然是一种数据类型，就可以作为形参

```go
func myFunc(fun func(int, int) int, n1 int, n2 int) int {
    return fun(n1, n2)
}
```

- 使用`_`作为占位符，忽略返回值
- Go支持可变参数，放在形参列表的最后

```go
func add(args... int) sum int {
    sum := 0
    for i := 0; i < len(args); i ++ {
        sum += args[i]
    }
    return
}
```

- 每一个源文件都可以包含一个init函数，它在main函数之前就被调用

```go
func init(){
    fmt.Println("初始化")
}
```

- 程序调用顺序 `全局变量 -> init()函数 -> main()函数`
- 匿名函数

``` go
// 第一种使用方式，创建匿名函数的时候就是使用
res1 := func (n1 int, n2 int) int {
    return n1 + n2
}(10, 20)  // res1 = 30

// 第二种匿名函数的使用方式，赋值给一个函数变量，多次使用
funvar := func (n1 int, n2 int) int {
    return n1 + n2
}
res2 := funvar(10, 20)  // res2 = 30

// 全局匿名函数
var (
    fun1 = func (n1 int, n2 int) int {
        return n1 + n2
    }
)
```

- 闭包就是一个函数和与其相关的引用环境组合的一个整体（实体）

```go
// 累加器
func AddUpper() func (int) int {
    var n int = 10
    return func (x int) int {
       	n += x
        return n
    }
}
// 调用
f := AddUpper()
f(1)  // 11
f(2)  // 13
f(3)  // 16
```

- 函数的 `defer`, 当go执行到一个defer时候，不会立即执行defer后的语句，而是将defer后的语句压入到一个栈中，然后继续执行函数下一条语句，当函数执行完毕后，再从defer栈中取出语句执行，在将defer后的语句压入栈中的时候，也会将相关的值拷贝同时入栈。该语句的最大价值就是函数执行完毕后可以及时释放资源

```go
func test() {
    file = openfile("test.txt")
    defer file.close()
}
```



# 包

- 每个go文件都属于一个包
- 包其实是一个虚拟概念，包的本质是文件夹
- 一般go文件所在的文件夹的名字和包名相同
- 可以取别名`import (othername "initname")`，取完别名后原名字就不能用了

```go
import (
	"fmt"
    util "go_code\chapter\fundemo"
)
```

- 同一个包下面不能有重名情况，例如变量和函数名，方法名等
- 如果要编译成为一个可执行文件，必须package是main
- 写库就不用main
- 变量名和函数名首字母大写代表public
- 导入包的时候路径的写法，首先编译器会从`GOROOT`寻找，再从`GOPATH`寻找包

# 自定义数据类型

```go
type myInt int
type mySum func(int, int) int
```

- myInt虽然是int，但是go还是认为是两种不同的数据类型

# 内置函数

```go
n := len(str)  // len
addr = new(int)  // new,分配一个零值的地址，主要分配值类型
addr = make(slice)  // 分配地址，主要分配引用类型
```

# 错误处理

通过`panic defer recover`捕获异常和处理异常

```go
func test() {
    defer func() {
        err := recover()  // recover()内置函数，可以捕获异常
        if err != nil {  // 如果捕获到异常
            fmt.Println("err =", err)
        }
    }()
    num1 := 10
    num2 := 0
    res := num1 / num2
    fmt.Println("res =", res)
}
```

- 自定义错误

```go
func readConf(name string) (err error) {
    if name == "config.ini" {
        // 读取...
        return nil
    } else {
        return errors.New("读取文件错误！！")
    }
}

func test(){
    err := readConf("config.ini")
    if err != nil {
        panic(err)  // 如果读取文件错误，直接终止程序
    } 
    fmt.Println("继续执行！")
}
```

# 数组

## 一维数组

- 数组是**值传递**方式
- 数组大小必须是一个常量大小，n也不行
- 数组的定义方式

```go
var arr1 [4]int
var arr2 = [3]int{1, 2, 3}
var arr3 = [...]int{1, 2, 3, 4}
var arr = [...]int{0: 1, 1:2, 2:3}
```

- 数组遍历

```go
for i := 0; i <= len(arr); i ++ {
    fmt.Println(arr[i])
}

for idx, val := range arr {
    fmt.Println(idx, val)
}
```

- 二维数组

```go
var arr [10][10]int
```



# 切片

- 切片： slice
- 切片是数组的引用，和数组类似
- 切片长度可以变化，可以理解成为一个动态变化的数组
- 常用使用方式

```go
slice := make([]int)
slice = append(slice, 10)
slice = append(slice, 20)
slice = append(slice, 30)
```

- 切片定义和使用方式

```go
// 第一种方式，数组我们自己可见
var arr[5]int = [...]int{1, 2, 3, 4, 5}
var slice = arr[1:3]  // 和python一样

// 第二种方式,底层自己创建一个数组，我们不可见
var slice []int = make([]int, 4, 10)  // 第三个参数是容量，可以不写，写了的话就要要求不小于len

// 第三种方式
var slice []int = []int{1, 2, 3}
```

- 切片可以看成一个结构体构成，由三个部分

```go
type slice struct {
    var ptr *int
    var len int
    var cap int
}
```

- 切片遍历和数组一摸一样
- `append`函数自动增长

```go
// 注意细节，append函数并不会在原来的切片进行修改，而是重新分配一个数组进行拷贝过去
var slice []int = []int{1, 2, 3}
slice = append(slice, 4)
slice = append(slice, 5)
slice = append(slice, slice...)  // 追加切片
```

- 切片的拷贝操作

```go
var arr1 []int = []int{1, 2, 3, 4, 5, 6, 7}
var arr2 []int = make([]int, 10)
copy(arr2, arr1)
```

**细节说明：**

- 切片使用和数组一样，但是仍然不能越界使用
- 切片使用和python几乎一样`arr[:2] arr[1:] arr[:]`
- 切片还可以继续切片，都指向同一个数组喔，修改都会变化

- `append`说明
    - go底层创建一个新的数组
    - 将原来的元素拷贝到新数组
    - newslice重新引用到新数组

- `string`和`slice`的关系

    - string底层就是一个byte数组，因此可以用slice切片
    - string是不可以变化的，因此切片可以不可更改
    - 如果需要修改字符串，先将字符串转化成为`rune`切片

    ```go
    // 这个方法可以处理英文和数字，但是不能处理中文
    str := "wendadawen"
    arr1 := str[0: 3]
    arr1 := []byte(str)
    arr1[0] = 'H'
    str = string(arr1)
    fmt.Println(str)
    // 下面这个方法可以处理中文
    str := "文大大文"
    arr1 := []rune(str)
    arr1[0] = '北'
    str = string(arr1)
    fmt.Println(str)
    ```

# map

- map是key-value数据结构，又称为关联数组，默认排序
- key可以是很多数据类型，例如bool，数字，string，指针，channel，还可以是结构，结构体，数组。
- key不能是slice，map，还有function，因为无法用==来判断
- map的使用

```go
var mp1 map[string] string
var mp2 map[string] int
var mp3 map[int]map[int]int  // 二维map
```

- 声明不会分配内存，初始化需要`make`，分配好内存后才能赋值和使用

```go
var mp map[string]string
mp["wendadawen"] = "wendadawen"  // 报错误
```

```go
// 正确写法
var mp map[string][string]
mp = make(map[string]string, 10)  // 第二个参数也可以不写，默认就是1个大小,自动扩容
mp["wendadawen"] = "wendadawen"
fmt.Println(mp)
```

- map的使用方式

```go
// 方式1
var mp map[string]int
mp = make(map[string]int)

// 方式2
var mp = make(map[string]int)

// 方式3
var mp map[string]int = map[string]int {
    "wendadawen1": 1,
    "wendadawen2": 2,
}
```

- map的增删改查

```go
// 增加和修改
mp["wendadawen"] = 1
// 删除  delete函数，存在就删除，不存在也不报错
delete(mp, "wendadawen") // 一次清空的话，遍历删除，或重新make一个
// 查询
val, ok = mp["wendadawen"]  // 若mp存在wendadawen，ok为true，否则为false,找不到不会自动添加进去
```

- map的遍历

```go
for key, val := range mp {
    fmt.Println(key, val)
}

// 二维的
mp := make(map[string]map[string]string)
mp["1"] = make(map[string]string)
mp["1"]["1"] = "1"
mp["2"] = make(map[string]string)
mp["2"]["2"] = "2"
for k, v := range mp {
    for k2, v2 := range v {
        fmt.Println(k2, v2)
    }
}
```

- map的大小

```go
len(mp)
```

- map切片

```go
slice := []map[string]string
slice = make([]map[string]string)
newElem := map[string][string] {
    "name": "wendadawen",
    "age": "18",
}
slice = append(slice, newElem)
```

**使用细节**

- map是引用类型，遵守引用类型传递机制

# 结构体

- 结构体的使用

```go
type Cat struct {
    Name string  // 大写代表public
    Age int
    Color string
}

var cat Cat
cat.Name = "波斯猫"
cat.Age = 14

cat1 := Car {
    Name: "小猫",
    Age: 29,
    Color: "绿色",
}
```

- 结构体是**值类型**，不是引用类型，但是虽然是值类型，如果属性是引用类型，例如slice，也会同时修改的

```go
cat2 := cat
```

- 结构体的声明

```go
type Person struct {
    Name string
    Age int
}
// 方式1
var p1 Person
// 方式2
p2 := Person{"wen", 20}
// 方式3
var pp *Person := new(Person)
(*PP).Name = "zhangsan"  // first
pp.Name = "zhangsan"  // 也可以这样写，正确的写法first的那一种，但是go做了优化，可以直接指针.Name
// 方式4
var pp *Person = &Person{}
```

**注意事项**

- 结构体的所有属性在内存中连续分布
- 结构体之间可以强转化，但是要求字段类型和字段名字完全相同
- 结构体的每一个字段都可以写一个反射

```go
type Person struct {
    Name string 'json:"name"'
    Age int 'json:"age"'
}
// 转化为json字段的时候就是小写的name和age
```

- 工厂模式，给首字母小写的属性或者结构体提供一个函数，用于包外访问。

# 方法

- GoLang中的方法是作用在指定的数据类型上面的
- 方法的声明

```go
type Person struct {
    Name string
    Age int
}

func (p Person) test() {  // Person类型的一个方法，p Person 类似于函数传参
    fmt.Println("test()", p.Name)
}

var p Person  // 通过Person类型调用
p.Name = "wenhongbing"
p.test()
```

- 指针调用的话编译器进行了优化，简化调用

```go
type Person struct {
    Name string
    Age int
}

func (p *Person) test() {  // Person类型的一个方法，p Person 类似于函数传参
    fmt.Println("test()", p.Name)
}

var p Person  // 通过Person类型调用
p.Name = "wenhongbing"
p.test()  // 本来应该这样子调用： (&p).test()
```

- 方法的访问范围控制的规则和函数一样，首字母大写可以在本包和其它包访问，首字母小写只能在本包访问
- 若一个类型实现了`String()`方法，那么fmt.Println会直接调用这个函数

```go
func (p Person) String() string { 
	return p.Name
}
```

- 接收者是值类型时候，可以用指针类型调用该方法，反之亦然

# 继承

- 继承：特有的字段和特有的方法保留,所有的字段和方法都能使用，不管首字母大写还是小写

- 基本语法

```go
type Goods struct {
    Name string
    Price int
}

type Book struct {
    Goods         // 嵌套匿名结构体就是继承
    Writer string
}
```

- 使用

```go
var book Book
book.Goods.Name = "百年孤独"
book.Goods.Price = 101
book.Writer = "wenhongbing"

book1 := Book{
    Goods{"天下无敌", 98},
    "wendadawen",
}
```

- 上面的写法可以简化，采用就近访问原则

```go
var book Book
book.Name = "百年孤独"
book.Price = 101
book.Writer = "wenhongbing"
```

- 有多个匿名结构体，有两个匿名结构体的字段名相同，则必须指定结构体名，不然报错
- 可以嵌套结构体指针，效率更高

```go
type Goods struct {
    Name string
    Price int
}

type Book struct {
    *Goods         // 嵌套匿名结构体就是继承
    Writer string
}

book1 := Book{
    &Goods{"天下无敌", 98},
    "wendadawen",
}
```

# 接口

- `interface`类型可以定义一组方法，但是不需要实现，并且interface不能包含任何变量
- 基本语法

```go
type 接口名 interface {
    method1 () ()
    method2 () ()
}
```

- 别的自定义类型需要去实现接口的方法

```go
type Phone struct {
    
}
func (p Phone) method1() {
    
}
func (p Phone) methond2() {
    
}
```

- GoLang的接口不需要显式的思想，只需要一个变量，含有接口类型中的所有变量，那么这个变量就是思想这个接口

**注意事项：**

- 接口本身不能创建实例，但是可以指向一个实现了该接口的自定义数据类型的实例

```go
type Usb interface {
    Say()
}
type Phone struct {
    
}
func (p Phone) Say() {
    
}

func main () {
    var usb Usb  // 错误
    
    var p Phone
    var usb Usb = p  // 正确
    p.Say()
}
```

- 一个自定义类型只有实现了一个接口的所有数方法才能说实现了该接口
- 一个自定义类型可以实现多个接口
- GoLang接口中不能有任何的变量
- 一个接口可以继承多个别的接口，这个时候如果要实现子接口，那么父接口也要全部实现
- `interface`类型默认是一个指针（引用）类型，如果没有对interface初始化就使用，那么会输出nil
- 空接口interface{}没有任何方法，因此所有类型都实现了空接口，即我们可以把任何类型赋值给空接口

```go
var str string
var t interface{} = str 
var num float64 = 5.3
t = num
```



**例题：排序**

```go
type Hero struct {
    Name string
    Age int
}

type HeroSlice []Hero

func (hs HeroSlice) Len() int{
    return len(hs)
}
func (hs HeroSlice) Less(i, j int) bool {
    return hs[i].Age < hs[j].Age
}
func (hs HeroSlice)Swap(i, j int) {
    hs[i], hs[j] = hs[j], hs[i]
}

func main) {
    var heros HeroSlice
    sort.Sort(heros)
}
```

# 多态

- Go的多态通过接口实现

- 多态特征

    - 多态参数

        在前面的Usb接口中，既可以接受Phone，也可以接受Camera，就体现了Usb接口多态

    - 多态数组

        在Usb数组中，存放Phone结构体和Camera结构体变量，还可以调用变量的特有方法（采用类型断言）。

        ```go
        var usb Usb
        var p Phone
        usb = p
        if _, ok := usb.(Phone); ok == true { // 待检测的类型断言
            fmt.Println("yes")
        } else {
            fmt.Println("no")
        }
        ```

- 类型断言的实践

```go
// 用type关键词判断类型
switch x.(type) {
    case bool:
    	// bool operation
    case float64:
    	// float64 operation
    default:
    	// operation
}
```

# 文件操作

- 文件操作的包： `os`
- 打开文件与关闭文件

```go
// 打开文件 open 
file, err := os.Open("test.txt")  // 返回文件指针（file对象，file文件句柄）
if err := nil {
    fmt.Println("打开失败")
}
// 关闭文件 close
err = file.Close()
if err != nil {
    fmt.Println("关闭文件失败")
}
```

- 读取内容。

```go
// 打开文件 open 
file, err := os.Open("test.txt")  
// 关闭文件 close
defer err = file.Close()
reader := bufio.NewReader(file)  // 带缓冲区的reader
for {
    str, err := reader.ReadString('\n')
    if err == io.EOF {
        break
    }
    fmt.Println(str)
}
fmt.Println("文件读取完毕")
```

```go
// 一次性读取所有内容
filePath := "test.txt"
content, err := ioutil.ReadFile(filePath)
if err != nil {
    fmt.Println("发生错误")
}
fmt.Printf("%v", string(content))
```

- 写文件

```go
filePath := "test.txt"
file, err := os.OpenFile(filePath, os.O_WRONLY|os.O_CREATE, 0666)
if err != nil {
    fmt.Println("打开文件失败")
    return
}

str := "Hello, Gardon\n"
writer := bufio.NewWriter(file) // 这个方法是带缓存的，实际还未写到磁盘，需要Flush
for i := 0; i < 5; i++ {
    _, err := writer.WriteString(str)
    if err != nil {
        return
    }
}
err = writer.Flush()
if err != nil {
    return
}
```

# json

-   是现在主流的数据格式
-   js语言中，一切都是对象，任何数据类型都可以通过JSON来表示
-   JSON的键值对的键名写在前面并用`""`包裹，并用`:`分隔，紧接着是值

- JSON的序列化：将有键值对的数据类型序列化，如结构体，map，切片等

```go
type People struct {
	Name     string
	Age      int
	Birthday string
	Gender   string
}

func main() {
	p := People{
		Name:     "wen",
		Age:      19,
		Birthday: "2020.01.23",
		Gender:   "男",
	}
	str, err := json.Marshal(p)
	if err != nil {
		fmt.Println("序列化失败")
	}
	fmt.Println(string(str)) // {"Name":"wen","Age":19,"Birthday":"2020.01.23","Gender":"男"}
}
```

- 序列化struct时候tag的使用，注意结构体的字段名只有首字母大写才能被序列化，小写不可以

```go
type People struct {
	Name     string `json:"name"`
	Age      int    `json:"age"`
	Birthday string `json:"birthday"`
	Gender   string `json:"gender"`
}
```

- 反序列化

```go
type People struct {
	Name     string `json:"name"`
	Age      int    `json:"age"`
	Birthday string `json:"birthday"`
	Gender   string `json:"gender"`
}

func main() {
	str := `{"Name":"wen","Age":19,"Birthday":"2020.01.23","Gender":"男"}`
	var p People
	err := json.Unmarshal([]byte(str), &p)
	if err != nil {
		return
	}
	fmt.Println(p)
}
```

# 单元测试

百度去

# goroutine和channel

## goroutine

**进程与线程：**

- 进程就是程序在操作系统中的一次执行过程，是系统进行分配的基本单位
- 线程就是进程的一个执行实例，是程序执行的最小单元，它是比进程更小的能独立运行的基本单位
- 一个进程可以创建销毁多个线程，同一个进程的多个线程可以并发执行

- 一个程序至少一个进程，一个进程至少有一个线程

**并发与并行：**

- 多线程程序在单核上运行，就是并发（在微观层面只有一个任务在执行）
- 多线程程序在多核上运行，就是并行（在微观层面多个任务同时执行）

**Go协程和Go主线程：**

- Go的主线程（有的叫做线程/可以理解成进程）可以有多个协程
- Go协程的特点
    - 有独立的栈空间
    - 共享程序堆空间
    - 调度由用户控制
    - 协程是轻量级的线程
    - GoLang可以轻松开启上万协程

**快速入门：**

- 使用

```go
func test() {
	for i := 1; i <= 5; i++ {
		fmt.Println("test() hello world" + strconv.Itoa(i))
		time.Sleep(time.Second)
	}
}
func main() {
	go test()  // 开启一个协程
	for i := 1; i <= 5; i++ {
		fmt.Println("main() hello world" + strconv.Itoa(i))
		time.Sleep(time.Second)
	}
}
```

- 结果

```go
test() hello world1
main() hello world1
main() hello world2
test() hello world2
test() hello world3
main() hello world3
main() hello world4
test() hello world4
test() hello world5
main() hello world5
```

- 解释
    - go test()开启协程
    - 主线程和协程同时开始运行
    - 主线程结束程序就结束
    - 如果主线程结束了，而协程即使还没有执行完毕也会退出

**goroutine的调度模型：**

- MPG模式
    - M：操作系统的主线程（是物理线程）
    - P：协程执行需要的上下文
    - G：协程

- 可以自己设置运行CPU的数目，百度去

## channel

- goroutine出现的资源竞争的问题，如下

```go
package main

import (
	"fmt"
)

var (
	n                = 200
	arr  map[int]int = make(map[int]int, n)
)

func test(n int) {
	var res = 1
	for i := 1; i <= n; i++ {
		res += i
	}
	arr[n] = res
}
func main() {
	// 开启20个协程
	for i := 0; i < n; i++ {
		go test(i)
	}
	//time.Sleep(time.Second * 10)
	for i := 0; i < n; i++ {
		fmt.Println(arr[i])
	}
}
```

- 第一个解决方法，加全局锁

```go
package main

import (
	"fmt"
	"sync"
)

var (
	n                = 30
	arr  map[int]int = make(map[int]int)
	lock             = sync.Mutex{}
)

func test(n int) {
	var res = 1
	for i := 1; i <= n; i++ {
		res += i
	}
	lock.Lock() // 加锁
	arr[n] = res
	lock.Unlock() // 解锁
}
func main() {
	// 开启20个协程
	for i := 0; i < n; i++ {
		go test(i)
	}
	//time.Sleep(time.Second)

	for i := 0; i < n; i++ {
		lock.Lock()
		fmt.Println(arr[i])
		lock.Unlock()
	}

}
```

- 第二种方法，更加推荐，用管道（channel）
    - channel的本质是队列，多协程访问的时候不需要加锁，channel本身就是线程安全的，
    - channel是有类型的，一个string的channel只能存放string类型数据

```go
var strCh chan string
var mapch chan map[int]string
var perCh chan Person
var perC2 chan *Person
var intCh chan int = make(chan int, 3)  // 第二个参数是容量，且以后不可以增加
```

- 注意点
    - channel是引用类型
    - channel必须初始化才能写入数据
    - channel是有类型的，intChan只能写入整数int

- 写入数据

```go
intChan<- 10  // 向管道写入10，最多只能写入初始化的容量的大小
```

- 使用数据

```go
num, ok := <-intChan  // <-intChan
// ok 表示读数据是否成功
```

- channel的关闭，当channel关闭后，就不能向channel写入数据了，但是仍然可以从该channel读取数据

```go
close(intChan)
```

- channel的遍历，只能遍历一次
    - 在遍历的时候，如果channel没有关闭，则会出现deadlock的错误
    - 在遍历的时候，如果channel已经关闭，则会正常遍历数据，遍历完成后就推出遍历

```go
package main

import "fmt"

func main() {
	intChan := make(chan int, 100)
	for i := 1; i <= 100; i++ {
		intChan <- i
	}
	close(intChan)
	for v := range intChan {
		fmt.Println(v)
	}
	fmt.Println(len(intChan))
}
```

- channel的特殊机制，即使管道容量比较小，即使管道容量满了，只要编译器发现了有协程在取数据就不会出现deadlock（死锁）错误。因为管道会阻塞禁止写入数据，直到取出数据后才会继续写入。
- channel的特殊机制，即使管道没有数据，只要编译器发现了有协程再向管道写入数据就不会出现deadlock错误。
- 记得关闭管道
- 管道默认情况下是可读可写的双向管道。
- 管道也可声明为只写。

```go
var chan2 chan<-int
chan2 = make(chan int, 3)
```

- 管道也可声明为只读

```go
var chan2 <-chan int
num2 := <-chan2
```

- 只读只写可以写进函数参数里面，可以防止误操作，也可以提高效率，只读只写只是代表一种属性，不是代表一种数据类型

```go
func send(intChan chan<- int) {
    
}
func recv(intChan <-chan int) {
    
}
func main() {
    intChan := make(chan int, 10)
    go send(intChan)
    go recv(intChan)
}
```

- 使用select可以解决从管道取数据的阻塞问题
- goroutine中使用recover可以解决出现panic的问题

```go
defer func() {
    err := recover()  // recover()内置函数，可以捕获异常
    if err != nil {  // 如果捕获到异常
        fmt.Println("err =", err)
    }
}()
```



# goroutine和channel结合

- 读写同时操作

```go
package main

import "fmt"

var (
	n = 1000
)

func readData(intChan chan int, exitChan chan bool) {
	for {
		v, ok := <-intChan
		if !ok {
			break
		}
		fmt.Println(v)
	}
	// 读取数据完毕，即任务完成
	exitChan <- true
	close(exitChan)
}

func writeData(intChan chan int) {
	for i := 1; i <= n; i++ {
		intChan <- i
	}
	close(intChan)
}

func main() {
	intChan := make(chan int, n)
	exitChan := make(chan bool, 1)

	go writeData(intChan)
	go readData(intChan, exitChan)
	
	// 保证协程执行完毕
	for {
		if _, ok := <-exitChan; !ok {
			break
		}
	}
}
```

- 求1-200000的素数

```go
package main

import (
	"fmt"
	"time"
)

var (
	prime_n       = 1000000 // 素数的范围
	num_goroutine = 10       //协程的数目
	primeChan     = make(chan int, 10000)
	exitChan      = make(chan bool, prime_n)
	intChan       = make(chan int, 20000)
)

// 判断是否是素数
func isPrime(n int) {
	var tag bool
	for i := 2; i < n; i++ {
		if n%i == 0 {
			tag = true
			break
		}
	}
	if !tag {
		primeChan <- n
	}
}

// solve
func solve() {
	for {
		num, ok := <-intChan
		if !ok {
			break
		}
		isPrime(num)
	}
	exitChan <- true
}

func main() {
	start := time.Now()
	// 放数字
	go func() {
		for i := 2; i <= prime_n; i++ {
			intChan <- i
		}
		close(intChan)
	}()
	// 打开协程
	for i := 1; i <= num_goroutine; i++ {
		go solve()
	}
	// 保证协程完毕
	go func() {
		for i := 1; i <= num_goroutine; i++ {
			<-exitChan
		}
		// exitChan流出该数目后表示执行结束
		close(primeChan)
	}()
	// 取出素数
	for {
		num, ok := <-primeChan
		if !ok {
			break
		}
		fmt.Println(num)
	}
	end := time.Now()
	duration := end.Sub(start)

	fmt.Printf("程序运行时间：%v\n", duration)
}
```

# 反射

- 反射可以在运行时动态获取变量的各种信息，比如变量的类型，类别
- 如果是结构体变量，还可以获取到结构体本身的信息（包括字段，方法）
- 通过反射，可以修改变量的值，可以调用关联的方法
- 使用反射，需要import("reflect")

百度去，反正很强大

# 网络编程

- tracert www.baidu.com 可以跟踪经过的站点
- ip地址：每个internet上的主机和路由器都有一个ip地址，它包括网络号和主机号，ip地址有ipv4和ipv6，可以通过ipconfig查看

- 端口
    - 只要做服务程序，都必须监听一个端口
    - 该端口就是其他程序和该服务通讯的通道
    - 一台电脑有65536个端口
    - 一个端口被占用，就不能在被用了
    - 客服端发送数据使用的端口是系统随机分配的
    - `netstat -anb`指令可以查看
    - 0号是保留端口
    - 1-1024是固定端口，又叫有名端口，被某些程序固定使用，一般程序员不使用
    - 其他端口是动态端口，程序员可以使用

其他百度去

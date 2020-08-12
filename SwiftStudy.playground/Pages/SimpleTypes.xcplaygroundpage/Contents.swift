import UIKit

//https://www.hackingwithswift.com/100

//variables, simple data types, and string interpolation
//简单类型

//1.变量
//创建变量时分配值
var str = "Hello, playground"
str = "hehuimin"
type(of: str)

//使用类型注释
//Swift字符串区分大小写
var name: String
name = "hehuimin"

//2.字符串和整数
//这包含一个整数，因此Swift指定类型Int- “整数”的缩写。
var age = 27
// 如果您有大数字，Swift允许您使用下划线作为千位分隔符 - 它们不会更改数字，但它们确实使它更容易阅读。例如：
var population = 8_000_000

let doubleDecimal = 125.0 // 十进制，等价于1.25e2 (1.25*10^2），0.0125 = 1.25e-2
// 0xFp2  //十六进制，15*2的2^2

//字符串和整数是不同的类型，它们不能混合。所以，虽然str改为“再见” 是安全的，但我不能把它变成38，因为那Int不是一个String。
//str = 89

// 类型转换
let aa = name + String(age)

//3.多行字符串
//标准Swift字符串使用双引号，但您不能在其中包含换行符。
//如果你想要多行字符串，你需要稍微不同的语法：开头和结尾有三个双引号，如下所示
var str1 = """
This goes
over multiple
lines
"""
print(str1)

//Swift特别关注你如何编写引号：开始和结束三元组必须在它们自己的行上，但是开始和结束换行符不会包含在你的最终字符串中。
//如果你只想要多行字符串来整齐地格式化代码，并且你不希望这些换行符实际存在于你的字符串中，那么用a结束每一行\，如下所示：
var str2 = """
This goes \
over multiple \
lines
"""
print(str2)

// 字符类型，需指定类型，不指定类型默认是字符串类型
let character: Character = "d"

//4.Doubles and booleans 多精度和布尔
//“Double”是“双精度浮点数”的缩写，它是一种奇特的方式，它表示它包含小数值
var pi = 3.14
//Bool值，它们只包含true或false
var awesome = true

//5.字符串插值
//您可以在字符串中放置任何类型的变量 - 您只需要写一个反斜杠\，然后在括号中输入变量名。例如：
var score = 85
var str3 = "Your score was \(score)"
var result = "The test results are here: \(str3)"

//6.常量 let
/*
 1.只能赋值1次
 2.它的值不要求在编译时期确定，但使用之前必须赋值1次
 3.常量、变量在初始化之前，都不能使用的
 */
let taylor = "swift"

let number: Int
number = 10

//7.Type annotations
//指定数据类型  请注意，布尔值具有短类型名称Bool，与整数具有短类型名称的方式相同Int。
let album: String = "hehuimin"
let year: Int = 2019
let height: Double = 3.14
let taylorRocks: Bool = true

//8.标识符
/*
 1.标识符（比如常量名，变量名，函数名）几乎可以使用任何字符
 2.标识符不能以数字开头，不能包含空白字符、制表符、箭头等特殊字符
 */
let 🙃 = "happy"


// 字面量（Literal）
/*
 常见字面量的默认类型
 public typealias IntegerLiteralType = Int
 public typealias FloatLiteralType = Double
 public typealias BooleanLiteralType = Bool
 public typealias StringLiteralType = String
 
 swift自带的绝大部分类型，都支持直接通过字面量进行初始化
 Bool, Int, Float, Double, String, Array, Dictionary, Set, Optional等
 
 swif自带类型之所以能够通过字面量初始化，是因为他们遵守了对应的协议
 Bool: ExpressibleByBooleanLiteral
 Int: ExpressibleByIntegerLiteral
 ...
 */
extension Int: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = value ? 1 : 0
    }
}

var num: Int = true
print(num)


// 通配符模式(Wildcard Pattern)
/*
 _ 匹配任何值
 -? 匹配非nil值
 */

// 枚举模式
/*
 if case语句等价于只有1个case的switch语句
 */
func test () {
    let age2 = 2
    // 原来的写法
    if age2 >= 0 && age2 <= 9 {
        print("[0, 9]")
    }

    // 可以用if case 匹配
    if case 0...9 = age2 {
        print("[0, 9]")
    }
    
    guard case 0...9 = age2 else {
        return
    }

    print("[0, 9]")
    
    // 等价于以上2个方法
    switch age2 {
    case 0...9:
        print("[0, 9]")
    default:
        break
    }
    
    let ages: [Int?] = [2, 3, nil, 5]
    for case nil in ages {
        print("有nil值")
        break
    }
    
    let points = [(1, 0), (2, 1), (3, 0)]
    for case let (x, 0) in points {
        print(x) // 1 3
    }
}

// 可选模式
let nums: [Int?] = [nil, 2, 3, nil, 5]
for case let num? in nums {
    print(num) // 2 3 5
}

for num in nums {
    if let item = num {
        print(item)
    }
} // 2 3 5 等价于上面的for


// 表达式模式
/*
 可以通过重载运算符，自定义表达式模式的匹配规则
 */
struct Student {
    var score = 0, name = ""
    
    /// pattern:  case后面的内容
    /// value:  switch后面的内容
    /// 返回值Bool 是固定的
    static func ~= (pattern: Int, value: Student) -> Bool {
        value.score >= pattern
    }
    
    static func ~= (pattern: Range<Int>, value: Student) -> Bool {
        pattern.contains(value.score)
    }
    
    static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool {
        pattern.contains(value.score)
    }
}
var stu = Student(score: 20, name: "Jakc")
switch stu {
case 100: print(">= 100")
case 90: print(">= 90")
case 80..<90: print("(80, 90)")
case 60...79: print("(60, 79)")
case 0: print(">= 0")
default: break
}


func hasPrefix(_ prefix: String) -> ((String) -> Bool) {
//    return {
//        (str: String -> Bool) in
//        str.  hasPrefix(prefix)
//    }
    // 简写
    { $0.hasPrefix(prefix) }
}

func hasSuffix(_ suffix: String) -> ((String) -> Bool) {
    { $0.hasSuffix(suffix) }
}

extension String {
    static func ~= (pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}

var testStr = "123456"
switch testStr {
case hasPrefix("12"):
    print("以12开头")
case hasSuffix("56"):
    print("以56结尾")
default:
    break
}


// 可以使用where为模式增加匹配条件
// 可以在case, for, 关联类型, 泛型, 协议扩展等后面使用
let ages = [10, 20, 43, 23]
for age in ages where  age > 20 {
    print(age)
}


//总结
/*
 1.使用var和常量使用变量let。最好尽可能经常使用常量。
 2.字符串以双引号开头和结尾，但如果您希望它们跨多行运行，则应使用三组双引号。
 3.整数保持整数，双数保持小数，而布尔值保持真或假。
 4.字符串插值允许您从其他变量和常量创建字符串，将它们的值放在字符串中。
 5.Swift使用类型推断来分配每个变量或常量类型，但是如果需要，可以提供显式类型。
 */

extension Dictionary where Key == String, Value == Any {
    mutating func setupShareParams(title: String, content: String, thumbImage: String, url: String
        ) {
        updateValue(title, forKey: "title")
        updateValue(content, forKey: "content")
        updateValue(thumbImage, forKey: "thumbImage")
        updateValue(url, forKey: "url")
    }
}

var dict = [String: Any]()
dict.setupShareParams(title: "title", content: "content", thumbImage: "thumbImage", url: "url")
print(dict)

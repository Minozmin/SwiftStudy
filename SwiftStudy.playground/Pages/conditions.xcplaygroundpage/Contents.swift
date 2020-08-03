import UIKit

//https://www.hackingwithswift.com/100

//operators and confitions

//1.算术运算符 + - * / %
let firstScore = 12
let secondScore = 4
let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = firstScore % secondScore

//当谈到字符串时，+会将它们连接在一起
let name1 = "Tim McGraw"
let name2 = "Romeo"
let both = name1 + " and " + name2

//2.运行符重载
let meaningOfLine = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna"
let action = fakers + "fake"

let firstHalf = ["Join", "Paul"]
let seconHalf = ["George", "Ringo"]
let beatles = firstHalf + seconHalf

//注意：Swift是一种类型安全的语言，这意味着它不会让你混合类型。例如，您不能向字符串添加整数，因为它没有任何意义。

//3.复合赋值运算符 -= +=
var score = 95
score -= 5

//添加然后分配给
//获取当前值quote，为其添加"world"，然后将结果放回去quote
var quote = "hello "
quote += "world"

//4.比较运算符  == != > >= < <=
firstScore == secondScore
firstScore != secondScore
firstScore > secondScore
firstScore <= secondScore

//5.条件 if
// if  判断条件必须是bool类型
if firstScore + secondScore == 16 {
    print("true")
}else {
    print("false")
}

if firstScore - secondScore == 1 {
    print("a")
}else if firstScore - secondScore == 9 {
    print("b")
}else {
    print("c")
}

//6.组合条件 && ||
if firstScore > 5 && secondScore > 5 {
    print("Both are over 5")
}

if firstScore > 5 || secondScore > 5 {
    print("One of them is over 5")
}

//7.三元运算符 ?:
firstScore > secondScore ? true : false

//8.切换语句 switch
//default 不是必需的，如果能保证所有问题都处理完，比如用枚举时;其它情况下最好加上default
//默认可以不写break，并不会贯穿到后面的条件
//swift只会在每个case中运行代码。如果您希望执行继续下一个案例，请使用如下fallthrough关键字
let weather = "sunny"
switch weather {
case "rain":
    print("rain")
    fallthrough
case "snow":
    print("snow")
case "sunny":
    print("sunny")
    
default:
    print("Enjoy your day")
}

switch weather {
case "rain", "snow":
    print("rain")
default:
    print("Enjoy your day")
}


var age: Int? = .none
// 方法一
switch age {
case let a?:
    // a已经进行强解包了，是Int类型
    print("is", a)
case nil:
    print("is nil")
}
// 方法二
switch age {
case let .some(a):
    print("is", a)
case .none:
    print("is nil")
}
// 方法三
if let a = age {
    print("is", a)
} else {
    print("is nil")
}


//9.范围 range operators
//..< 半开放范围运算符，不包括最终值
//... 闭合范围运算符，包括最终值
// 区间匹配
let range = 10
switch range {
case 0..<5:
    print("0..<5")
case 5...8:
    print("5...8")
default:
    print("default")
}
// 元组匹配
let point = (1, 1)
switch point {
case (0, 0):
    print("0,0")
case (_, 0):
    print("x")
case (0, _):
    print("y")
default:
    print("other")
}
// 值绑定
let point1 = (2, 0)
switch point1 {
case (let x, 0):
    print(x);
case (0, let y):
    print(y)
case (let x, let y):
    print(x, y)
}

let point2 = (1, -1)
switch point1 {
case let(x, y) where x == y:
    print(x);
case let(x, y) where x == -y:
    print(y)
case let(x, y):
    print(x, y)
}


// 溢出运算符
/*
 1.swift的算数运算符出现溢出时会抛出运行时错误
 2.swift有溢出运算符（&+, &-, &*），用来支持溢出运算
 */
var v1 = UInt8.min // 0
var v2 = UInt8.max // 255
//var v3 = v1 + 1 // 会报错，因为溢出了
var v3 = v1 &- 1 // 255
var v4 = v2 &+ 1 // 0 溢出以后又会变回到0 255 + 1 - 256
var v5 = v2 &* 2 // 254


// 运算符重载（Operator Overload）
/*
 类、结构体、枚举可以为现有的运算符提供自定义的实现，这个操作叫做：运算符重载
 */
struct Point {
    var x = 0, y = 0
    
    // 建议写在对应的类型里面
    // 中缀运算符：在两个操作数中间(默认）
    static func +(p1: Point, p2: Point) -> Point {
        Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    static func -(p1: Point, p2: Point) -> Point {
        Point(x: p1.x - p2.x, y: p1.y - p2.y)
    }
    
    // 前缀运算符
    static prefix func -(p: Point) ->Point {
        Point(x: -p.x, y: -p.y)
    }
    
    static func +=(p1: inout Point, p2: Point) {
        p1 = p1 + p2
    }
    
    static prefix func ++(p: inout Point) -> Point {
        p += Point(x: 1, y: 1)
        return p
    }
    
    // 后缀运算符
    static postfix func ++(p: inout Point) -> Point {
        let temp = p
        p += Point(x: 1, y: 1)
        return temp
    }
    
    static func ==(p1: inout Point, p2: Point) -> Bool {
        (p1.x == p2.x) && (p1.y == p2.y)
    }
}

// 重载
var p1 = Point(x: 10, y: 20)
var p2 = Point(x: 11, y: 22)
var p3 = p1 + p2

// 结合性，先计算p1 + p2的值再 + p3
var p4 = p1 + p2 + p3
print("p3:", p3)
print("p4:", p4)


// Equatable
/*
 1.要想得知2个实例是否等价，一般做法是遵守Equatable协议，重载 == 运算符
 2.与些同时，等价于重载了 != 运算符
 3.swift为以下类型提供默认的 Equatable 实现
  -没有关联类型的枚举
  -只拥有遵守 Equatable 协议关联类型的枚举
  -只拥有遵守 Equatable 协议存储属性的结构体
 4.引用类型比较存储的地址值是否相等（是否引用着同一个对象），使用恒等运算符 ===（只适用引用类型）、!==
 */
class Person: Equatable {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.age == rhs.age
    }
}

var per1 = Person(age: 10)
var per2 = Person(age: 10)
print("==:", per1 == per2)
print("===:", per1 === per2)


// Comparable
/*
 1.要想比较2个实例的大小，一般做法是：
  -遵守 Comparable 协议
  -重载相应的运算符
 */


// 自定义运算符(Custom Operator)
/*
 1.可以自定义新的运算符：在全局作用域使用operator 进行声明
  -prefix operator 前缀运算符
  -postfix operator 后缀运算符
  -infix operator 中缀运算符 : 优先级组
 
 Apple文档参考：
 文档1：https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations
 文档2：https://docs.swift.org/swift-book/ReferenceManual/Declarations.html
 */

infix operator +-: PlusMinusPrecedence
precedencegroup PlusMinusPrecedence { // 优先级组
    associativity: none  // 结合性（letf\right\none）
    higherThan: AdditionPrecedence // 比谁的优先级高 AdditionPrecedence这个是不能乱写的，需要参数文档1
    lowerThan: MultiplicationPrecedence // 比谁的优先级低
    assignment: true // 代表在可选链操作中拥有跟赋值运算符一样的优先级
}

struct Animal {
    var x = 0, y = 0
    static func +-(_ a1: Animal, _ a2: Animal) -> Animal {
        Animal(x: a1.x + a2.x, y: a1.y - a2.y)
    }
}

var a1 = Animal(x: 10, y: 20)
var a2 = Animal(x: 5, y: 15)
var a3 = a1 +- a2
print("a3:", a3)




//总结
/*
 1.Swift有算术和比较的操作员; 他们大多像你已经知道的那样工作。
 2.算术运算符的复合变体可以修改它们的变量：+=，-=等等。
 3.您可以根据条件的结果使用if，else和else if运行代码。
 4.Swift有一个三元运算符，它将检查与真假代码块结合在一起。虽然您可能会在其他代码中看到它，但我不建议您自己使用它。
 5.如果您使用相同的值有多个条件，则使用它通常更清晰switch。
 6.您可以使用..<和...取决于是否应排除或包括最后一个数字。
 */

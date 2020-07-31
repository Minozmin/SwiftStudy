//: [Previous](@previous)

import UIKit
// 泛型
/*
 1.泛型可以将类型参数化，提高代码复用率，减少代码量
 2.泛型函数赋值给变量
 */

var n1 = 10
var n2 = 20

func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

swapValues(&n1, &n2)
print(n1, n2)

var s1 = "aaa"
var s2 = "bbb"
swapValues(&s1, &s2)
print(s1, s2)


func test<T1, T2>(_ t1: T1, _ t2: T2) {}
var fn: (Int, Double) -> () = test

// 泛型可以自定义名称，尽量可以有意义有点，比如以下是Elements的缩写
class Stack<E> {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E {
        elements.removeLast()
    }
    func top() -> E {
        elements.last!
    }
    func size() -> Int {
        return elements.count
    }
}

var inStack = Stack<Int>()
inStack.push(2)
var stringStack = Stack<String>()

struct Stack1<E> {
    var elements = [E]()
    mutating func push(_ element: E) {
        elements.append(element)
    }
    mutating func pop() -> E {
        elements.removeLast()
    }
    func top() -> E {
        elements.last!
    }
    func size() -> Int {
        return elements.count
    }
}

enum Score<T> {
    case point(T)
    case grade(String)
}

let score1 = Score<Int>.point(100)
let score2 = Score.point(99.0)
let score3 = Score<Int>.grade("A")



// 关联类型（Associated Type）
/*
 1.关联类型的作用：给协议中用到的类型定义一个占位名称
 2.协议中可以拥有多个关联类型
 */
protocol Stackable {
    associatedtype Element // 关联类型，类似泛型
//    associatedtype Element1 // 多个关联类型时
    func push(_ element: Element) // 加mutating表示将来可能是struct继承这个协议
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}

// 指定类型
class StringStack: Stackable {
    // 给关联值类型设定真实类型，可省略不写
//    typealias Element = String
    
    var elements = [String]()
    func push(_ element: String) {
        elements.append(element)
    }
    func pop() -> String {
        elements.removeLast()
    }
    func top() -> String {
        elements.last!
    }
    func size() -> Int {
        elements.count
    }
}

var ss = StringStack()
ss.push("Jack")
ss.push("Rose")

// 泛型
class Stack2<E>: Stackable {
//    typealias Element = E
    
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E {
        elements.removeLast()
    }
    func top() -> E {
        elements.last!
    }
    func size() -> Int {
        elements.count
    }
}


// 类型约束
protocol Runnable {}
class Person {}
func swapValues<T: Person & Runnable>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

protocol Sleepable {
    associatedtype Element: Equatable
}

class Sleep<E: Equatable>: Sleepable {
    typealias Element = E
}

func equal<S1: Sleepable, S2: Sleepable>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element: Hashable {
    return false
}

var sp1 = Sleep<Int>()
var sp2 = Sleep<Int>()
var sp3 = Sleep<String>()
equal(sp1, sp2)
//equal(sp1, sp3) // Int 跟 String 不相等，所以会报错


// some 不透明类型  解决协议中带有关联类型时报错
/*
 如果协议中包含关联类型，遵守这个协议的类如果返回协议对象：
 解决方案：
 1.使用泛型
 2.使用some关键字声明一个不透明类型
  -some限制只能返回一种类型
  -some除了用在返回值类型上，一般还可以用在属性类型上
 */

//: [Next](@next)

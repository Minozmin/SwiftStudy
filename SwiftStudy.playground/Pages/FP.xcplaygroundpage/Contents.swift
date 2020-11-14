//: [Previous](@previous)

import Foundation

// 函数式编程 （Funtional Programming）
/*
 函数式编程 （Funtional Programming，简称FP）是一种编程范式，也就是如何编写程序的方法论
 主要思想：把计算过程尽量分解成一系列的可复用函数的调用
 主要特征：函数是“第一等公民”
  -函数与其它数据类型一样的地位，可以赋值给其它变量，也可以作为函数参数，函数返回值
 */

var num = 1
// 假如要实现这个方法 ((num + 3) * 5 - 1) % 10 / 2
func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
func sub(_ v: Int) -> (Int) -> Int { { $0 - v } }
func multiple(_ v: Int) -> (Int) -> Int { { $0 * v } }
func divide(_ v: Int) -> (Int) -> Int { { $0 / v } }
func mod(_ v: Int) -> (Int) -> Int { { $0 % v } }

// 函数合成
/*
func compose(_ f1: @escaping (Int) -> Int,
             _ f2: @escaping (Int) -> Int)
    -> (Int) -> Int { { f2(f1($0)) } }
*/

infix operator >>>: AdditionPrecedence
func >>><A, B, C>(_ f1: @escaping (A) -> B,
                  _ f2: @escaping (B) -> C)
    -> (A) -> C { { f2(f1($0)) } }

let fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
print(fn(num)) // 4


// 高阶函数
/*
 高阶函数至少满足下列一个条件的函数：
 -接受一个或多个函数作为输入（map、filter、reduce等）
 -返回一个函数
 比如上面的add、sub等方法
 */



// 柯里化（Currying）
/*
 -将一个接受多参数的函数变换为一系列只接受单个参数的函数
 
 Array、Optional的map方法接收的参数就是一个柯里化函数
 */

// 传统函数
func sub1(_ v1: Int, _ v2: Int) -> Int {
    v1 - v2
}
sub1(20, 10) // 10

// 柯里化
func sub2(_ v: Int) -> (Int) -> Int { { $0 - v } }
sub2(10)(20) // 10


func add3(_ v1: Int, _ v2: Int, _ v3: Int) -> Int {
    v1 + v2 + v3
}
add3(10, 20, 30) // 60

func add3(_ v3 : Int) -> (Int) -> (Int) -> Int {
    return { v2 in
        return { v1 in
            return v1 + v2 + v3
        }
    }
}
add3(30)(20)(10) // 60


// 传统函数转柯里化
prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    return { b in
        return { a in
            return fn(a, b)
        }
    }
    
    // 简写
//    { b in { a in fn(a, b) }
}

(~{ (v1, v2) -> Int in
    v1 + v2
})(20)(10) // 30

(~sub1)(20)(10) // -10


// 函子（Functor）
/*
 像Array、Optional这样支持map运算的类型，称为函子
 */


// 适用函子（Applicative Functor）
/*
 对任意一个函子F，如果能支持以下运算，该函子就是一个适用函子
 
 func pure<A>(_ value: A) -> F<A>
 func <*><A, B>(fn: F<(A)->B>, value: F<A>) -> F<B>
 */


// 单子（Monad）
/*
 对任意一个类型F，如果能支持以下运算，那么就可以称为一个单子
 
 func pure<A>(_ value: A) -> F<A>
 func flatMap<A, B>(_ value: F<A>, _ FN: (A) -> F<B>) -> F<B>
 
 很显然，Array、Optional都是单子
 */



// 面向协议编程 POP
/*
 -优先考虑创建协议，而不是父类（基类）
 -优先考虑值类型（struct，enum），而不是引用类型（class）
 -巧用协议的扩展功能
 -不要为了面向协议而使用协议
 
 
 面向对象编程 OOP
 */

/// 前缀类型
struct HM<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// 利用协议扩展前缀属性
protocol HMCompatible {}
extension HMCompatible {
    var hm: HM<Self> {
        set {}
        get { HM(self) }
    }
    static var hm: HM<Self>.Type {
        set {}
        get { HM<Self>.self }
    }
}

/// 给字符串扩展功能
// 让String拥有hm前缀属性
extension String: HMCompatible {}

// 给String.hm、String().hm前缀扩展功能
extension HM where Base: ExpressibleByStringLiteral {
    var numberCount: Int {
        var count = 0
        for c in (base as! String) where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    
    mutating func run() {}
}
"123abc".hm.numberCount // 3
//"a".hm.run()  // 不能用字符串常量，如果要调用mutating 修饰的方法，还需实现set{}方法
var st = "a"
st.hm.run()


class Person {}
extension Person: HMCompatible {}

extension HM where Base: Person {
    func run() {
        print("run")
    }
}
var person = Person()
person.hm.run() // run


// 判断实例是否是数组
func isArray(_ value: Any) -> Bool {
    value is [Any]
}
isArray([1, 3]) // true
isArray(NSArray()) // true
isArray(NSMutableArray()) // true
isArray("134") // false


// 判断数组类型
protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}

func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}

isArrayType([Int].self) // true
isArrayType([Any].self) // true
isArrayType(NSArray.self) // true
isArrayType(NSMutableArray.self) // true
isArrayType(String.self) // false



// 响应式编程 RP
/* 也叫：函数响应式编程 FRP
 1.ReactiveCocoa
 -RAC,有oc、swift版本
 -官网：http://reactivecocoa.io/
 -github：https://github.com/ReactiveCocoa
          
 
 2.ReactiveX
 -Rx
 -RxSwfit、RxJS...
 -官网：http://reactivex.io/
 -github：https://github.com/ReactiveX
 */

// RxSwift
/*
 源码：https://github.com/ReactiveX/RxSwift
 中文文档：https://beeth0ven.github.io/RxSwift-Chinese-Documentation/
 
 需要导入
 import RxSwfit
 import RxCocoa
 
 模块说明
 -RxSwift：Rx标准API的Swift实现，不包括任何iOS相关的内容
 -RxCocoa：基于RxSwfit，给iOS UI控件扩展了很多Rx特性
 
 
 RxSwift的核心角色
 -Observable：负责发送事件（Event）
 -Observer：负责订阅Observable，监听Observable发送的事件（Event）
 
 Disposable
 -每当Observable被订阅时，都会返回一个Disposable实例，当调用Disposable的dispose，就相当于取消订阅
 -在不需要再接收事件时，建议取消订阅，释放资源，有3种常见方式取消订阅
 
 // 立即取消订阅（一次性订阅）
 observable.subscribe { event in
    print(event)
 }.dispose()
 
 // 当bag销毁（deinit）时，会自动调用Disposable实例的dispose
 observable.subscribe { event in
    print(event)
 }.disposed(by: bag)
 
 // self销毁时（deinit）时，会自动调用Disposable实例的dispose
 let _ = observable.takeUntil(self.rx.deallocated).subscribe { event in
    print(event)
 }
 
 */


//: [Next](@next)

//: [Previous](@previous)

import UIKit

// 访问控制 Access Control

/*
 // 访问控制
 1.在访问权限控制这块，Swift提供了5个不同的访问级别（以下是从高到低排列，实体指被访问级别修饰的内容，当前项目的Target称为模块））
 -open：允许在定义实体的模块、其它模块中访问，允许其它模块进行继承、重写（open只能用在类、类成员上）
/Users/hehuimin/Documents/GitHub/SwiftStudy/SwiftStudy.playground/Pages/Protocols.xcplaygroundpage -public：允许在定义实体的模块、其它模块中访问，不允许其它模块进行继承、重写
 -internal：只允许在定义实体的模块中访问，不允许在其它模块中访问
 -fileprivate：只允许在定义实体的源文件中访问
 -private：只允许在定义实体的封闭声明中访问
 
 2.绝大部分实体默认是 internal 级别
 
 // 访问级别的使用准则
 一个实体不可以被更低访问级别的实体定义，比如
  -变量\常量类型 >= 变量\常量
  -参数类型、返回值类型 >= 函数
  -父类 >= 子类
  -父协议 >= 子协议
  -原类型 >= typealias
  -原始值类型、关联值类型 >= 枚举类型
  -定义类型A时用到的其它类型 >= 类型A
  ...
 
 // 元组类型
 元组类型的访问级别是所有成员类型最低的那个
 
 // 泛型类型
 泛型类型的访问级别是 类型的访问级别 以及 所有泛型类型参数的访问级别 中最低的那个
 
 // 成员、嵌套类型
 类型的访问级别会影响成员（属性、方法、初始化器、下标）、嵌套类型的默认访问级别
  -一般情况下，类型为private或fileprivate，那么成员、嵌套类型默认也是private或fileprivate
  -一般情况下，类型为internal或public，那么成员、嵌套类型默认是internal
  -子类重写的成员访问级别必须 >= 父类的成员访问级别
  -直接在全局作用域下定义的private等价于fileprivate
 
 // getter、setter
 1.getter、setter默认自动接收它们所属环境的访问级别
 2.可以给setter单独设置一个比getter更低的访问级别，用以限制写的权限
 
 // 初始化器
 1.如果一个public类想在别一个模块调用编译生成的默认无参初始化器，必须显示提供public的无参初始化器，
  -因为public类的默认初始化器是internal级别
 2.required初始化器必须跟它所属类拥有相同的访问级别
 3.如果结构体有private\fileprivate的存储实例属性，那么它的成员初始化器也是private\fileprivate
  -否则默认就是internal
 
 // 枚举类型的case
 1.不能给enum的每个case单独设置访问级别
 2.每个case自动接收enum的访问级别
  -public enum定义的case也是public
 
 // 协议
 1.协议中定义的要求自动接收协议的访问级别，不能单独设置访问级别
  -public协议定义的要求也是public
 2.协议实现的访问级别必须 >= 类型的访问级别，或者 >= 协议的访问级别
 
 // 扩展
 1.如果有显式设置扩展的访问级别，扩展添加的成员自动接收扩展的访问级别
 2.如果没有显式设置扩展的访问级别，扩展添加的成员的默认访问级别，跟直接在类型中定义的成员一样
 3.可以单独给扩展添加的成员设置访问级别
 4.不能给用于遵守协议的扩展显式设置扩展的访问级别
 
 5.在同一个文件中的扩展，可以写成类似多个部分的类型声明
 */

class Test {
    // Dog 的 private 访问级别在 Test{} 范围内
    private struct Dog {
        // age 的 private 访问级别在 Dog {} 范围内
        private var age: Int = 0
        // 跟随 Dog 的 private 访问级别
        func run() {}
    }
    
    private struct Person {
        var dog: Dog = Dog()
        mutating func wald() {
            dog.run()
        }
    }
    
    private func test0() {}
    
    // 只读，不能写
    private(set) var num = 0
}

var test = Test()
//test.num = 10 // 报错
print(test.num) // 可读

// 扩展
extension Test {
    private func testq1() {
        test0()
    }
}

// 协议
public protocol Runnable {
    func run()
}

public class Person: Runnable {
    // 如果不加public，默认是internal，所以会报错，需要手动标识public
    public func run() {
        
    }
}

// 将方法赋值给var、let
/*
 1.方法也可以像函数那样，赋值给一个let或var
 */
struct Dog {
    var age: Int
    func run(_ v: Int) {
        print("func run", age, v)
    }
    static func sleep(_ v: Int) {
        print("func sleep", v)
    }
}

// (Dog) -> ((Int) -> ())
var fn1 = Dog.run
// (Int) -> ()
var fn2 = fn1(Dog(age: 10))
fn2(30)

var f3 = Dog.sleep
f3(40)


// 内存管理
/*
 1.跟oc一样，swift也采取基于引用计数的ARC内存管理方案（针对堆空间）
 2.swift的ARC中有3种引用
  -强引用：默认情况下，引用都是强引用
  -弱引用：通过weak定义弱引用
   -必须是可选类型的var，因为实例销毁后，ARC会自动将弱引用设置为nil
   -ARC自动给弱引用设置nil时，不会触发属性观察器
  -无主引用：通过unowned定义无主引用
   -不会产生强引用，实例销毁后仍然存储着实例的内存地址（类似OC中的unsafe_unretained）
   -试图在实例销毁后访问无主引用，会产生运行时错误（野指针）
   -Fatal error: Attempted to read an unowned reference but object 0x0 was already deallocated
 
 // weak、unowned的使用限制
 weak、unowned只能用在类实例上面
 
 // autoreleasepool
 autoreleasepool {
   // 需要释放的代码
 }
 
 // 循环引用 Reference Cycle
 1.weak、unowned 都能解决循环引用的问题，unowned 要比 weak 少一些性能消耗
  -在生命周期中可能会变为 nil 的使用 weak
  -初始化赋值后再也不会变为 nil 的使用 unowned
 */

// 闭包的循环引用
/*
 1.闭包表达式默认会对用到的外层对象产生额外的强引用（对外层对象进行了retain操作）
 2.在闭包表达式的捕获列表声明weak或unowned引用，解决循环引用问题
 3.如果想在定义闭包属性的同时引用self，这个闭包必须是lazy的（因为在实例初始化完毕之后才能引用self）
 4.如果lazy属性是闭包调用的结果，那么不用考虑循环引用的问题（因为闭包调用后，闭包的生命周期就结束了）
 */
class Test3 {
    // 注释3
    lazy var eat: (() -> ()) = {
        [weak self] in
        self?.run() // 这里一定要强制用self调用run()，表示这个地方可能会造成循环引用
    }
    var fn: (() -> ())?
    func run() { print("run") }
    
    // 注释4
    var age: Int = 0
    lazy var getAge: Int = {
        self.age
    }()
    
    deinit {
        print("deinit")
    }
}

func method() {
    let test3 = Test3()
    // 会造成循环引用
    // test3.fn = { test3.run() }
    
    // 以下两种方法可以解决循环引用问题
    test3.fn = {
        [weak test3] in // [weak ap = test3] 可以取别名
        test3?.run()
    }
    test3.fn = {
        [unowned test3] in
        test3.run()
    }
    
    test3.eat()
}
method()


// @escaping
/*
 1.非逃逸闭包、逃逸闭包，一般都是当做参数传递给函数
  -非逃逸闭包：闭包调用发生在函数结束前，闭包调用在函数作用域内
  -逃逸闭包：闭包有可能在函数结束后调用，闭包调用逃离了函数的作用域，需要通过@escaping声明
 */
typealias Fn = () -> ()
// fn是非逃逸闭包
func test5(_ fn: Fn) {
    fn()
}
// fn是逃逸闭包
var gFn: Fn?
func test6(_ fn: @escaping Fn) {
    gFn = fn
}
// fn是逃逸闭包
func test7(_ fn: @escaping Fn) {
    DispatchQueue.global().async {
        fn()
    }
}

//: [Next](@next)

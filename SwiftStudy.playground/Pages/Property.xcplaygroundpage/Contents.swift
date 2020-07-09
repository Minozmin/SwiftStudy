//: [Previous](@previous)

import UIKit

// 属性
// 存储属性
/*
 1.类似于成员变量这个概念
 2.存储在实例的内存中
 3.结构体、类可以定义存储属性
 4.枚举不可以定义存储属性
 */
/*
 在创建类 或 结构体的实例时，必须为所有的存储属性设置一个合适的初始值
 -可以在初始化器里为存储属性设置一个初始值
 -可以分配一个默认的属性值作为属性定义的一部分
 */

struct Point {
    var x: Int
    var y: Int
}

var p = Point(x: 10, y: 20)
print(MemoryLayout.stride(ofValue: p))

// 计算属性
/*
 1.本质就是方法（函数）
 2.不占用实例的内存
 3.枚举、结构体、类都可以定义计算属性
 */
/*
 set 传入的新值默认叫做newValue，也可以自定义
 只读计算属性：只有get，没有set
 定义计算属性只能用var，不能用let;let代表常量，值是一成不变的；
 计算属性的值可能发生变化的（即使是只读计算属性）
 */
struct Circle {
    // 存储属性
    var radius: Double
    // 计算属性
    var diameter: Double {
//        set (newDiameter) {
//            radius = newDiameter / 2
//        }
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
    // 只读计算属性，可以省略get
    var read: Double {
        get {
           radius * 3
        }
    }
//    var read: Double { radius * 3 }
}

// 延迟存储属性 lazy
/*
 使用lazy可以定义一个延迟存储属性，在第一次用到属性的时候才会进行初始化
 -lazy属性必须是var，不能是let，let必须在实例的初始化方法完成之前就拥有值
 -如果多条线程同时第一次访问lazy属性，无法保证属性只能被初始化一次
 
 注意点：
 当结构体包含一个延迟存储属性时，只有var才能访问延迟存储属性
 -因为延迟属性初始化时需要改变结构体的内存
 */
class Car {
    init() {
        print("Car init!")
    }
    func run() {
        print("Car is running!")
    }
}

class Person {
    lazy var car = Car()
    init() {
        print("Person init!")
    }
    func goOut() {
        car.run()
    }
}

let person = Person()
print("------")
person.goOut()


// 属性观察器
/*
 可以为非lazy的var存储属性设置属性观察器
 willSet 会传递新值，默认叫newValue
 didSet 会传递旧值，默认叫oldValue
 在初始化器中设置属性值、属性定义时设置初始值都不会触发willSet和didSet
 */
struct Circle2 {
    var radius: Double {
        // 即将设置
        willSet {
            print("willSet", newValue)
        }
        // 已经设置完毕
        didSet {
            print("didSet", oldValue, radius)
        }
    }
    init() {
        self.radius = 1.0
        print("Circle2 init!")
    }
}

var cir2 = Circle2()
cir2.radius = 10.5

// 属性观察器和计算属性同样可以用在全局变量和局部变量上

// 类型属性
/*
 严格来说，属性可以分为
 1.实例属性（Instance Property）：只能通过实例去访问
 -存储实例类型（Stored Instance Property）：存储在实例的内存中，每个实例都有1份
 -计算实例属性（Computed Instance Property）
 
 2.类型属性（Type Property）：只能通过类型去访问
 -存储类型属性（Stored Type Property）：整个程序运行过程中，就只有1份内存（类似于全局变量）
 -计算类型属性（Computed Type Property）
 
 可以通过static定义类型属性
 如果是类，也可以用关键字class
 
 类型属性细节：
 -存储类型属性也需要设置初始值
 -存储类型属性默认就是lazy，会在第一次使用的时候才初始化；就算被多个线程同时访问，保证只会初始化一次
 -存储类型属性可以是let
 -枚举类型也可以定义类型属性（存储类型属性、计算类型属性），不可以定义存储实例属性
 */
struct Shape {
    static var count: Int = 0
}

Shape.count = 10

// 单例
class FileManager {
    public static let shared = FileManager() // 分配堆空间的代码只会调用一次
    
    func open() {
        print("FileManager open")
    }
}

FileManager.shared.open()

//: [Next](@next)

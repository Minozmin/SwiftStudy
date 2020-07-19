import UIKit

//https://www.hackingwithswift.com/100

//protocols, extensions, and proctol extensions

// 协议 protocol
/*
 1.协议可以用来定义方法、属性、下标的声明，协议可以被枚举、结构体、类遵守（多个协议之间用逗号隔开）
 2.协议中定义方法时不能有默认参数值
 3.默认情况下，协议中定义的内容必须全部都实现（也有办法只实现部分，后面补充）
 4.协议中定义属性时必须用var关键字
 5.实现协议时的属性权限要不小于协议中定义的属性权限
  -协议定义get，set，用var存储属性或get、set计算属性去实现
  -协议定义get，用任何属性都可以实现
 
 static、class
 为了保证通用，协议中必须用static定义类型方法、类型属性、类型下标
 
 mutating
 只有将协议中的实例方法标记为mutating
 -才允许结构体、枚举的具体实现修改自身内存
 -类在实现方法时不用加mutating，枚举、结构体才需要加mutating
 
 init
 1.协议中还可以定义初始化器init
  -非final类实现时必须加上required
 2.如果从协议实现的初始化器，刚好是重写了父类的指定初始化器
  -那么这个初始化器必须同时加required、override
 
 init、init?、init!
 1.协议中定义的init?、init!，可以用init、init?、init!去实现
 2.协议中定义的init，可以用init、init!去实现
 
 协议的继承
 1.一个协议可以继承其它协议
 
 协议组合  必须同是遵守&
 1.协议组合，可以包含1个类类型（最多1个）
 // 接收同时遵守Liveable、Runaabler协议的实例
 fun fn(obj: Liveable & Runaable) {}
 
 CaseIterable
 1.让枚举遵守CaseIterable协议，可以实现遍历枚举值
 */
protocol Drawable {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

class Person: Drawable {
    // 实现属性可以是存储属性或计算属性
//    var x: Int = 0
//    var y: Int = 0
    var x: Int {
        get { 0 }
        set {}
    }
    var y: Int { 0 }
    
    func draw() {
        print("person draw")
    }
    subscript(index: Int) -> Int {
        set {}
        get { index }
    }
}

// CaseIterable
/*
 让枚举遵守CaseIterable协议，可以实现遍历枚举值
 */
enum Season: CaseIterable {
    case spring, summer, autumn, winter
}

let seasons = Season.allCases
for season in seasons {
    print(season)
}

// CustomStringConvertible
/*
 遵守CustomStringConvertible协议，可以自定义实例的打印字符串
 */
class Tree: CustomStringConvertible {
    var age: Int = 10
    var description: String {
        "age=\(age)"
    }
}

var tree = Tree()
print("------:", tree)


//协议是描述必须具有的属性和方法的一种方式
protocol Identifiable {
    var id: String { get set }
}

//我们无法创建该协议的实例 - 它是一种描述，而不是一种类型。但是我们可以创建一个符合它的结构
struct User: Identifiable {
    var id: String
}

//最后，我们将编写一个displayID()接受任何Identifiable对象的函数
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

var user = User(id: "007")
displayID(thing: user)

//一个协议可以在称为协议继承的过程中从另一个协议继承。与类不同，您可以在添加自己的自定义项之前同时从多个协议继承。
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(day: Int)
}

//我们现在可以创建一个Employee协议，将它们集中在一个协议中。我们不需要在顶部添加任何内容，因此我们只需编写打开和关闭的大括号：
protocol Employee: Payable, NeedsTraining, HasVacation {}

struct Test: Employee {
    func calculateWages() -> Int {
        print("calculateWages")
        return 1
    }
    
    func study() {
        print("study")
    }
    
    func takeVacation(day: Int) {
        print("takeVacation \(day)")
    }
}

let test = Test()
test.calculateWages()
test.study()
test.takeVacation(day: 8)

//扩展 extension  扩展允许您向现有类型添加方法
extension Int {
    func square() -> Int {
        return self * self
    }
}

let number = 8
print(number.square())

//Swift不允许您在扩展中添加存储的属性，因此您必须使用计算属性。例如，我们可以isEven向整数添加一个新的计算属性，如果它包含偶数，则返回true：
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

print(number.isEven)

//协议扩展  协议允许您描述应该具有哪些方法，但不提供内部代码。扩展允许您在方法中提供代码，但只影响一种数据类型 - 您无法同时将方法添加到许多类型中。协议扩展解决了这两个问题
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

//Swift的数组和集合都符合所谓的协议Collection，所以我们可以编写一个扩展名来添加一个summarize()方法来整齐地打印集合
extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

//面向协议的编程
//协议扩展可以为我们自己的协议方法提供默认实现。这使得类型很容易符合协议，并允许一种称为“面向协议的编程”的技术 - 围绕协议和协议扩展来制作代码。

//首先，这是一个调用的协议Identifiable，它要求任何符合类型的id属性和identify()方法：
protocol Identifier {
    var id: String { get set }
    func identify()
}

//我们可以使每个符合类型的类型编写自己的identify()方法，但协议扩展允许我们提供默认值：
extension Identifier {
    func identify() {
        print("My ID is \(id).")
    }
}

//现在，当我们创建一个符合Identifiable它的类型时，它会identify()自动生成：
struct People: Identifier {
    var id: String
}
let people = People(id: "hehuimin")
people.identify()

//总结
/*
 1.协议描述了符合类型必须具有的方法和属性，但不提供这些方法的实现。
 2.您可以在其他协议之上构建协议，类似于类。
 3.扩展允许您将方法和计算属性添加到特定类型，例如Int。
 4.协议扩展允许您向协议添加方法和计算属性。
 5.面向协议的编程是将应用程序体系结构设计为一系列协议，然后使用协议扩展来提供默认方法实现的实践。
 */

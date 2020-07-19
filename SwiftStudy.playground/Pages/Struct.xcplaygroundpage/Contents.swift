import UIKit

//https://www.hackingwithswift.com/100

//structs, properties, and methods

//1.结构体 -- 值类型
/*
 1.Bool,Int,Double,String,Array,Dictionary等常见类型都是结构体
 2.所有的结构体都有一个编译器自动生成的初始化器(initializer)
 3.结构体中所有的成员叫做存储属性
 
 结构体的初始化器
 1.编译器会根据情况，可能会为结构体生成多个初始化器，宗旨：保证所有的成员都有初始值
 2.一旦在定义结构体时自定义了初始化器，编译器就不会再帮它自动生成其他初始化器
 */
//没有设置默认值时，调用Soprt(name: "")需要带参数
struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)
tennis.name = "Boll"
print(tennis.name)

//设置默认值时，调用Soprt1()结构体可不用设置参数
struct Soprt1 {
    var name: String = "boll"
}
var soprt1 = Soprt1()
print(soprt1.name)

//2.计算属性
struct Sports {
    var name: String
    var isOlympicSport: Bool
    
    var onlympicSport: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

var chessBoxing = Sports(name: "Chessboxing", isOlympicSport: true)
print(chessBoxing.onlympicSport)

//3.属性监听
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 10
//如果想amount每次更改时都打印一条消息，可以使用didSet属性
progress.amount = 20

//还可以使用在属性更改之前执行willSet操作，但很少使用。

//4.方法
//结构中的函数称为方法，但它们仍然使用相同的func关键字。
struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let city = City(population: 200)
print(city.collectTaxes())


// 语法糖

//5.mutating
/*
 结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
 -在func关键字前加mutating可以允许这种修改行为
 */
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

//因为它改变了属性，所以Swift只允许在Person作为变量的实例上调用该方法
var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)

// @discardableResult
// 在func前面加个@discardableResult，可以消除：函数调用后返回值未被使用的警告⚠️
struct Car {
    var count = 0
    
    @discardableResult
    mutating func sum() -> Int {
        self.count = self.count + 1
        return self.count
    }
}
var car = Car()
car.sum()


// 下标 subscript
/*
 使用subscript可以给任意类型（枚举、结构体、类）增加下标功能
 -subscript的语法类似于实例方法、计算属性、本质就是方法（函数）
 
 subscript中定义的返回值类型决定了
 -get方法的返回值类型
 -set方法中newValue的类型
 
 subscript可以接受多个参数并且类型类型任意
 
 下标细节：
 subscript可以没有set方法，但必须有get方法
 subscript如果只有get方法，可以省略get
 可以设置参数标签
 下标可以是类型方法
 */
class Point {
    var x = 0.0, y = 0.0
    subscript(index: Int) -> Double {
        set {
            if index == 0 {
                x = newValue
            } else if index == 1 {
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
}
var p = Point()
p[0] = 11.1
p[1] = 22.2
print(p.x)
print(p.y)
print(p[0])
print(p[1])

// 结构体、类作为下标返回值对比
struct Point2 {
    var x = 10, y = 11
}

struct PointManager {
    var point = Point2()
    subscript(index: Int) -> Point2 {
        set { point = newValue }
        get { point }
    }
}
var pm = PointManager()
/*
 1.如果Point2是struct的话，一定要实现set方法才可以修改point的值
 2.如果Point2是class的话，则set方法不需要实现就可以修改point的值
 */
pm[0].x = 20 // pm[0] = Point2(x: 11, y: pm[0].y)
pm[0].y = 21 // pm[0] = Point2(x: pm[0].x, y: 22)


//6.字符串的属性和方法
let string = "Do or do not, there is no try."
//可以使用其count属性读取字符串中的字符数
print(string.count)
//有一个hasPrefix()方法，如果字符串以特定字母开头，则返回true
print(string.hasPrefix("Do"))
print(string.hasSuffix("abc"))
//可以通过调用其uppercased()方法来大写字符串
print(string.uppercased())
print(string.lowercased())
//甚至可以让Swift将字符串的字母排序成一个数组
print(string.sorted())

//还有更多属性和方法，通过string.调用

//7.数组的属性和方法
var toys = ["Woody"]
//可以使用其count属性读取数组中的项目数
print(toys.count)
//如果要添加新项，请使用如下append()方法
toys.append("hehuimin")
print(toys)
//可以使用其firstIndex()方法在数组中找到任何项目，这将返回1，因为数组从0开始计数。
let index: Int = toys.firstIndex(of: "hehuimin") ?? -1
print(index)
//如果要删除项目，请使用如下remove()方法
toys.remove(at: 1)
print(toys)

//还有更多属性和方法，通过toys.调用

//8.Initializers  初始化器
//您不需要在初始化程序之前编写func，但是您需要确保所有属性在初始化程序结束之前都有值。

/*
 1.类、结构体、枚举都可以定义初始化器
 2.类有2种初始化器：指定初始化器（designated initializer）、便捷初始化器（convenience initializer）
   -指定初始化器
    init(parameters) {
        statements
    }
   -便捷初始化器
    convenience init(parameters) {
        statements
    }
 3.每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
 4.默认初始化器总是类的指定初始化器
 5.类偏向于少量指定初始化器，一个类通常只有一个指定初始化器
 
 初始化器的相互调用规则
 1.指定初始化器必须从它的真系父类调用指定初始化器
 2.便捷初始化器必须从相同的类里调用另一个初始化器
 3.便捷初始化器最终必须调用一个指定初始化器
 

 两段式初始化
 第1阶段：初始化所有的存储属性
 第2阶段：设置新的存储属性值
 
 安全检查
 1.指定初始化器必须保证在调用父类初始化器之前，其所在类定义的所有存储属性都要初始化完成
 2.指定初始化器必须先调用父类初始化器，然后才能为继承的属性设置新值
 3.便捷初始化器必须先调用同类中的其它初始化器，然后再为任意属性设置新值
 4.初始化器在第1阶段初始化完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用self
 5.直到第1阶段结束，实例才算完全合法
 
 
 重写
 1.当重写父类的指定初始化器时，必须加上override（即使子类的实现是便捷初始化器）
 2.如果子类写了一个匹配父类便捷初始化器的初始化器，不用加上override
  -因为父类的便捷初始化器永远不会通过子类直接调用，因此，严格来说，子类无法重写父类的便捷初始化器
 
 自动继承
 1.如果子类没有自定义任何指定初始化器，它会自动继承父类所有的指定初始化器
 2.如果子类提供了父类所有指定初始化器的实现（要么通过方式1继承，要么重写）
  -子类自动继承所有的父类便捷初始化器
 3.就算子类添加了更多的便捷初始化器，这些规则仍然适配
 4.子类以便捷初始化器的形式重写父类的指定初始化器，也可以作为满足规则2的一部分
 
 
 required
 1.用required修饰指定初始化器，表明其所有子类都必须实现该初始化器（通过继承或者重写实现）
 2.如果子类重写了required初始化器，也必须加上required，不用加override
 
 属性观察器
 1.父类的属性在它自己的初始化器中赋值不会触发属性观察器，但在子类的初始化器中赋值会触发属性观察器
 
 */

// override
class Door {
    var age: Int {
        willSet {
            print("willSet", newValue)
        }
        didSet {
            print("didSet", oldValue, age)
        }
    }
    var score: Int
    
    // 指定初始化器
    init(age: Int, score: Int) {
        self.age = age
        self.score = score
    }
    
    // 便捷初始化器
    convenience init(age: Int) {
        self.init(age: age, score: 10)
    }
}

class DoorA: Door {
    override init(age: Int, score: Int) {
        super.init(age: age, score: score)
        // 这里赋值会触发属性观察器
        self.age = 10
    }
}

var doorA = DoorA(age: 20, score: 10)

// 自动继承
class DoorB: Door {
    
}

var doorB = DoorB(age: 10)

// required
class Test {
    required init() {}
    init(age: Int) {}
}

class TestA: Test {
    init(no: Int) {
        super.init(age: 0)
    }
    
    required init() {
        super.init()
    }
}

var testA = TestA()

// 可失败初始化器
/*
 1.类、结构体、枚举都可以使用init？定义可失败初始化器
 2.不允许同时定义参数标签、参数个数、参数类型相同的可失败初始化器和非可失败初始化器
 3.可以用init!定义隐式解包的可失败初始化器
 4.可失败初始化器可以调用非可失败初始化器，非可失败初始化器调用可失败初始化器需要进行解包
 5.如果初始化器调用一个可失败初始化器导致初始化失败，那么整个初始化过程都失败，并且之后的代码都停止执行
 6.可以用一个非可失败初始化器重写一个可失败初始化器，但反过来不行
 */
class User {
    var name: String
//    init!(name: String) {
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    convenience init() {
        //如果上面是init!，这里可以不用!
//        self.init(name: "")
        self.init(name: "")!
    }
}

var user1 = User(name: "")
var user2 = User(name: "Jack")

// 反初始化器 deinit
/*
 1.deinit叫做反初始化器，类似开c++的析构函数、oc中的dealloc方法
  -当类的实例对象被释放内存时，就会调用实例对象的deinit方法
 2.deinit不接受任何参数，不能写小括号，不能自行调用
 3.父类的deinit能被子类继承
 4.子类的deinit实现执行完毕后会调用父类的deinit
 */
class Flow {
    deinit {
        print("Flow对象被销毁了")
    }
}


// 可选链 Optional chaining
/*
 1.如果可选项为nil，调用方法、下标、属性失败，结果为nil
 2.如果可选项不为nil，调用方法、下标、属性成功，结果会被包装成可选项
 3.如果结果本来就是可选项，不会进行再次包装
 4.多个?可以链接在一起
 5.如果链中任何一个节点是nil，那个整个链就会调用失败
 */
class DogA { var price = 0 }
class DogB { var weight = 0 }
class Dog { 
    var dogA: DogA = DogA()
    var dogB: DogB? = DogB()
    func age() -> Int { 20 }
    subscript(index: Int) -> Int { index }
}

var dog: Dog? = Dog()
let i = dog?[0]
if let age = dog?.age() { // ()?
    print("age调用成功", age)
} else {
    print("age调用失败")
}
var dogA = dog?.dogA // DogA?
var weight = dog?.dogB?.weight // DogB?

//9.self
//在内部方法中，您将获得一个名为的特殊常量self，该常量指向当前正在使用的结构的任何实例。self在创建与属性具有相同参数名称的初始值设定项时
//self帮助您区分属性和参数 -  self.name引用属性，而name引用参数。
struct People {
    var name: String
    
    init () {
        self.name = ""
    }
    init(name: String) {
        self.name = name
    }
}

var people = People(name: "hehuimin")
//people.name = "hello"
print(people.name)

//10.懒加载lazy
struct Family {
    var name: String
    //在people前面加lazy，Swift将仅在People首次访问时创建结构
    lazy var people = People()
    
    init(name: String) {
        self.name = name
    }
}

//11.static
struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//因为classSizestruct属于struct本身而不是struct的实例，所以我们需要使用Student.classSize以下内容来读取它
print(Student.classSize)

//12.访问控制 private, public, open, internal, fileprivate
struct Animal {
    //外部不能访问到name属性
    private var name: String
    
    init(name: String) {
        self.name = name
    }
}

let animal = Animal(name: "Tiger")


//总结
/*
 1.您可以使用结构创建自己的类型，结构可以有自己的属性和方法。
 2.您可以使用存储的属性或使用计算属性来动态计算值。
 3.如果要更改方法内的属性，则必须将其标记为mutating。
 4.初始化器是创建结构的特殊方法。默认情况下，您会获得成员初始值设定项，但如果您创建自己的初始值设定项，则必须为所有属性提供值。
 5.使用self常量来引用方法内部结构的当前实例。
 6.该lazy关键字告诉Swift仅在首次使用时才创建属性。
 7.您可以使用static关键字在结构的所有实例之间共享属性和方法。
 8.访问控制允许您限制哪些代码可以使用属性和方法。
 */

//与〜=运算符匹配的模式
struct Regex {
    let pattern: String
    
    static let email = Regex(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    static let phone = Regex(pattern: "([+]?1+[-]?)?+([(]?+([0-9]{3})?+[)]?)?+[-]?+[0-9]{3}+[-]?+[0-9]{4}")
}

extension Regex {
    static func ~=(regex: Regex, text: String) -> Bool {
        return text.range(of: regex.pattern, options: .regularExpression) != nil
    }
}

let email = "cmecid@gmail.com"

switch email {
case Regex.email: print("email")
case Regex.phone: print("phone")
default: print("default")
}

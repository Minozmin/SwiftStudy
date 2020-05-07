import UIKit

//https://www.hackingwithswift.com/100

//structs, properties, and methods

//1.结构体 -- 值类型
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

//5.mutating  只能在func前添加
//如果要更改方法内的属性，则需要使用mutating关键字对其进行标记
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
struct User {
    var name: String
    
    init() {
        name = "default name"
        print("User: \(name)")
    }
}

//现在我们的初始化器不接受任何参数，我们需要像这样创建结构体
var user = User()
user.name = "update name"
print(user.name)

//9.self
//在内部方法中，您将获得一个名为的特殊常量self，该常量指向当前正在使用的结构的任何实例。self在创建与属性具有相同参数名称的初始值设定项时
//self帮助您区分属性和参数 -  self.name引用属性，而name引用参数。
struct People {
    var name: String
    
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
    //在user前面加lazy，Swift将仅在User首次访问时创建结构
    lazy var user = User()
    
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
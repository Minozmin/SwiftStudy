import UIKit

//https://www.hackingwithswift.com/100

//classes and inheritance

//1.类 class -- 引用类型
/*
 1.编译器不会为类自动生成可以传入值的初始化器
 2.如果类的所有成员都在定义的时候指定了初始值，编译器会为类生成无参的初始化器
 3.成员的初始化是在补个初始化器中完成的
 */
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

//类和结构体的第二个区别
//2.继承: 可以基于现有类创建类 - 它继承原始类的所有属性和方法，并且可以在顶部添加自己的类

// 继承(Inheritance)
/*
 1.值类型（枚举、结构体）不支持继承，只有类支持继承
 2.没有父类的类，称为：基类
  -swift并没有像oc、java那样的规定：任何类最终都要继承自某个基类
 3.子类可以重写父类的下标、方法、属性，重写必须加上override关键字
 
 重写类型方法、下标
 -被class修饰的类型方法、下标，允许被子类重写
 -被static修改的类型方法、下标，不允许被子类重写
 
 重写实例属性
 -子类可以将父类的属性（存储、计算）重写为计算属性
 -子类不可以将父类属性重写为存储属性
 -只能重写var属性，不能重写let属性
 -重写时，属性名、类型要一致
 -子类重写后的属性权限 不能小于 父类属性的权限
   -如果父类属性是只读的，那么子类重写后的属性可以是只读的、也可以是可读写的
   -如果父类属性是可读写的，那么子类重写后的属性也必须是可读写的
 
 重写类型属性
 -被class修饰的计算型属性，可以被子类重写
 -被static修饰的类型属性（存储、计算），不可以被子类重写
 
 属性观察器
 -可以在子类中为父类属性（除了只读计算属性、let属性）增加观察器
 */

class Person {
    func speak() {
        print("Person speak")
    }
    
    func eat() {
        print("Person eat")
    }
    
    func sleep() {
        print("Person sleep")
    }
}
// 重写
class Student: Person {
    override func speak() {
        print("Student speak")
    }
    
    override func eat() {
        print("Student eat")
    }
    
    func run() {
        print("Student run")
    }
}

// 多态
var stu: Person
stu = Person()
stu.speak()
stu.eat()
stu.sleep()

stu = Student()
stu.speak()
stu.eat()
stu.sleep()


//4.final 当你将一个类声明为final时，没有其他类可以继承它
/*
 -被final修饰的方法、下标、属性，禁止被重写
 -被final修饰的类，禁止被继承 
 */
final class Fruit {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//不可以继承
//class Apple: Fruit {
//
//}



// Any、AnyObject
/*
 swift提供了2种特殊的类型：Any、AnyObject
 1.Any：可以代表任意类型（枚举、结构体、类、也包括函数类型）
 2.AnyObject：可以代表任意类类型（在协议后面写上：AnyObject代表只能类能遵守这个协议）
 */
protocol Runnable: AnyObject {}
class TestA: Runnable {
    func run() {}
}
// 会报错
//struct TestB: Runnable {}

var eat: Any = 10
eat = "eat"

var data1 = Array<Any>()
var data2 = [Int]()


// is、as?、as!、as
/*
 is用来判断是否为某种类型，as用来做强制类型转换
 */
var sum: Any = 0
print("sum is Int:", sum is Int)
sum = TestA()
(sum as? TestA)?.run()
(sum as! TestA).run()
sum as Any


// X.self、X.type、AnyClass
/*
 X.self是一个元类型（metadata）的指针，metadata存放着哦噶相关信息
 X.self属性X.type类型
 */
TestA.self

var testC: TestA = TestA()
var testCType = type(of: testC)
print("TestA.self == testCType:", TestA.self == testCType)

// 元类型应用
// 为了确保子类有init方法，所以父类必须加required
class Animal {
    required init() {}
}

class Cat: Animal {}
class Pig: Animal {}

func create(_ clses: [Animal.Type]) -> [Animal] {
    var arr = [Animal]()
    for cls in clses {
        arr.append(cls.init())
    }
    return arr
}

print(create([Cat.self, Pig.self]))
print("class_getSuperclass(Cat.self):", class_getSuperclass(Cat.self)!)
// class_getSuperclass(Cat.self):Animal
print("class_getSuperclass(Animal.self):", class_getSuperclass(Animal.self)!)
// class_getSuperclass(Animal.self):_TtCs12_SwiftObject
// swift隐藏的基类：_TtCs12_SwiftObject


// Self
/*
 1.Self一般用作返回值类型，限定返回值跟方法调用者必须是同一类型（也可以作为参数类型）
 2.如果Self用在类中，要求返回时调用的初始化器是required的
 */
protocol Liveable {
    func test() -> Self
}

class Hhm: Runnable {
    required init() {}
    func test() -> Self {
        type(of: self).init()
    }
}


/* 类和结构体的第三个区别是它们的复制方式
 1.复制结构时，原始和副本都是不同的东西，改变一个不会改变另一个。
 2.复制类时，原始类和副本都指向同一个类，因此更改一个类会改变另一个类。
 */
class Singer {
    var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name)
var singerCopy = singer
singerCopy.name = "hehuimin"
print(singer.name, singerCopy.name)

struct Dance {
    var name = "Paul"
}
var dance = Dance()
print(dance.name)
var danceCopy = dance
danceCopy.name = "Apple"
print(dance.name, danceCopy.name)

//类和结构之间的第四个区别是类可以有deinitializers - 在类的实例被销毁时运行的代码。
//deinit {
//    
//}

//类不需要使用mutating带有更改属性的方法的关键字; 这只需要结构。
class Activity {
    var name = "hehuimin"
}
//用常量创建就可以改变他的属性（通过var属性改变，通过let使属性保质不变）
let activity = Activity()
activity.name = "Swift"
print(activity.name)

struct Activity1 {
    var name = "ABC"
    mutating func update(name: String) {
        self.name = name
    }
}
//改变struct属性需要用var创建结构体
var activity1 = Activity1()
activity1.update(name: "def")
print(activity1.name)

/*
 类和结构体的区别：
 1.结构体是值类型（枚举也是值类型），类是引用类型（指针类型）
 2.在swift中，创建类的实例对象，要向堆空间申请内存
 3.值类型赋值给var，let或者给函数传参，是直接将所有内容拷贝一份
  -类似于对文件时进行copy，paster操作，产生了全新的文件副本，属于深拷贝
 */

//总结
/*
 1.类和结构类似，因为它们都可以让您使用属性和方法创建自己的类型。
 2.一个类可以从另一个类继承，它获得父类的所有属性和方法。谈论类层次结构是很常见的 - 一个基于另一个的类，它本身基于另一个。
 3.您可以使用final关键字标记一个类，这会阻止其他类继承它。
 4.方法重写允许子类使用新实现替换其父类中的方法。
 5.当两个变量指向同一个类实例时，它们都指向同一块内存 - 更改一个会改变另一个。
 6.类可以有一个deinitializer，它是在类的一个实例被销毁时运行的代码。
 7.类不像结构那样强制执行常量 - 如果将属性声明为变量，则无论如何创建类实例，都可以更改它。
 */

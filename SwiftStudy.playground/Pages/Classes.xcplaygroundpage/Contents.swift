import UIKit

//https://www.hackingwithswift.com/100

//classes and inheritance

//1.类 class -- 引用类型
//类和结构之间的第一个区别是类永远不会带有成员初始化器。这意味着如果您的班级中有属性，则必须始终创建自己的初始值设定项。
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
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

//3.重写 override: 子类可以用自己的实现替换父方法
class Teddy: Dog {
    override func makeNoise() {
        print("makeNoise override")
    }
}

let teddy = Teddy(name: "Teddy", breed: "AA")
teddy.makeNoise()

//4.final 当你将一个类声明为final时，没有其他类可以继承它
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

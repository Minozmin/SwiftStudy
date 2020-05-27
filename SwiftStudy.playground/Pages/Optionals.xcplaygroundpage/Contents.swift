import UIKit

//https://www.hackingwithswift.com/100

//optionals, unwrapping, and typecasting

// 1.可选值 ？
/*
 1. 允许将值设置为nil
 2. 类型后面加？
 */
// var age: Int != var age: Int = 0
var age: Int? = nil  // = var age: Int?
//age = 27

// 多重可选项
/*
 可以使用lldb指令 frame variable -R 或者 fr -v -R 查看区别，只能在断点情况才能使用
 */
var age1: Int?? = age
var age2: Int?? = nil
age1 == age2 // false，值层级不一样，可通过fr -v -R 查看
age == age2 // false，因为类型不同
(age1 ?? 1) ?? 2 // 2   (age1 ?? 1) 解包成age
(age2 ?? 1) ?? 2 // 1

var num11: Int? = 10
var num12: Int?? = num11
var num13: Int?? = 10
num12 == num13 // true

/*
 fr -v -R num11
 
 // num11 = some {}里面的值才有意义
 (Swift.Optional<Swift.Int>) num11 = some {
   some = {
     _value = 10
   }
 }
 
 // num11 = none，{}里面的值没意义
 (Swift.Optional<Swift.Int>) num11 = none {
   some = {
     _value = 0
   }
 }
 
 */

// 2.if let
/*
 可选项绑定，if let 同时满足多个条件时，之间用逗号(,)分割，满足其中一个或多个时用??
 if let 作用域只限于满足条件的{}中
 
 解包选项的一种常见方法是使用if let语法，它可以解除条件。如果在Optional中有一个值，那么你可以使用它，但如果没有，则条件失败。
 */
var name: String? = nil
if let unwrapped = name {
    // unwrapped作用域只限于些
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

//3.guard
/*
 guard 条件 else {
     // 退出当前作用域
     return
 }
 
 当guard语句条件为false时，就会执行大括号里面的代码
 当guard语法条件为true里，就会跳过guard语句
 guard语句特别适合用来"提前退出"
 
 当使用guard语句进行可选绑定时，绑定的常量、变量也能在外层作用域中作用
 */

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    print("Hello, \(unwrapped)!")
}

//可选项代表可能存在或不存在的数据，但有时您肯定知道值不是零。在这些情况下，Swift允许您强制解包可选：将其从可选类型转换为非可选类型
//4.强制解包 !
if age ?? 0 > 0 {
    print("\(age!)")
}

//与常规选项一样，隐式解包的选项可能包含值，也可能包含值nil。但是，与常规选项不同，您不需要打开它们来使用它们：您可以使用它们，就像它们根本不是可选的一样。
//5.隐式解包的可选项，开发中尽量不使用
/*
 1.在某些情况下，可选项一量被设定值之后，就会一直拥有值
 2.在这种情况下，可以去掉检查，也不必每次访问的时候都进行解包，因为它能确定每次访问的时候都有值
 3.可以在类型后面的加个感叹号！定义一个隐式解包的可选项
 */
let sex: String! = nil
//let sex1: String = sex  会报错

//因为它们的行为就像它们已经被打开一样，所以您不需要if let或guard let使用隐式展开的选项。但是，如果您尝试使用它们并且它们没有价值 - 如果它们是nil- 您的代码崩溃了。
//存在隐式解包的选项，因为有时变量将以nil开始生命，但在您需要使用之前总是会有一个值。因为你知道他们在你需要的时候会有价值，所以不必一直写if let。

//nil coalescing运算符解包一个可选项，如果有值则返回值。如果没有值 - 如果是可选的nil- 则使用默认值。无论哪种方式，结果都不是可选的：它将来自可选内部的值或用作备份的默认值。

//6.??  空合并运算符
/*
 a ?? b
 1. a 是可选项
 2. b 是可选项 或者 不是可选项
 3. b 跟 a 的存储类型必须相同
 4. 如果 a 不为nil， 返回a
 5. 如果 a 为nil，返回b
 6. 如果 b 不是可选项，返回a 时会自动解包
 
 a ?? b ?? 3  从左到右运算，类型由最后一个值确定
 */
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    }else {
        return nil
    }
}

let user = username(for: 15) ?? "heuimin"

//6.optional chaining
//当使用选项时，Swift为我们提供了一个快捷方式：如果你想访问类似的东西a.b.c并且b是可选的，你可以在它后面写一个问号来启用可选的链接：a.b?.c。
//当该代码运行时，Swift将检查是否b有值，如果是nil，则该行的其余部分将被忽略 - Swift将nil立即返回。但如果它有一个值，它将被解包并继续执行。
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()


//7.optional try
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

//do try catch
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

//try?
//将抛出函数更改为返回可选项的函数。如果函数抛出错误，您将nil作为结果发送，否则您将获得包装为可选的返回值。
if let result = try? checkPassword("password") {
    print("Result was \(result)")
}else {
    print("D'oh.")
}

//try!
//当您确定该功能不会失败时，您可以使用它。如果该函数确实抛出错误，您的代码将崩溃。
try! checkPassword("sekrit")
print("OK!")

//8.failable initializers
//这是一个可用的初始化程序：初始化程序可能工作或不工作。您可以使用init?()而不是在您自己的结构和类中编写这些init()，并nil在出现错误时返回。然后返回值将是您的类型的可选项，您可以根据需要进行解包。
struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

//9.typecasting
//这使用一个名为的新关键字as?，它返回一个可选项：nil如果类型转换失败，则为其他类型，否则为转换类型。
class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

//总结
/*
 1.可选项让我们以清晰明确的方式表示缺少价值。
 2.Swift不会让我们使用选项而不用打开它们，无论是使用if let还是使用guard let。
 3.您可以使用感叹号强制解包选项，但如果您尝试强制解包，nil您的代码将崩溃。
 4.隐式解包的期权没有常规期权的安全检查。
 5.您可以使用nil合并来展开可选项，并在内部没有任何内容时提供默认值。
 6.可选链接允许我们编写代码来操作可选项，但如果可选的结果为空，则忽略代码。
 7.您可以使用try?将throw函数转换为可选的返回值，或者try!在抛出错误时崩溃。
 8.如果您需要初始化程序在输入错误时失败，请使用init?()创建可用的初始化程序。
 9.您可以使用类型转换将一种类型的对象转换为另一种类型。
 */

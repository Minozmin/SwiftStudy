import UIKit

//https://www.hackingwithswift.com/100

//optionals, unwrapping, and typecasting

//1.可选值 ？
var age: Int? = nil
age = 27

//解包选项的一种常见方法是使用if let语法，它可以解除条件。如果在Optional中有一个值，那么你可以使用它，但如果没有，则条件失败。
//2.if let
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

//替代if let是guard let，也解开了选项。guard let将为您打开一个可选项，但如果它在nil里面找到它，则希望您退出使用它的函数，循环或条件。
//但是，if let和之间的主要区别在于guard let，您的解包后的选项在guard代码之后仍然可用。
//3.guard
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
//5.隐式解包
let sex: String! = nil

//因为它们的行为就像它们已经被打开一样，所以您不需要if let或guard let使用隐式展开的选项。但是，如果您尝试使用它们并且它们没有价值 - 如果它们是nil- 您的代码崩溃了。
//存在隐式解包的选项，因为有时变量将以nil开始生命，但在您需要使用之前总是会有一个值。因为你知道他们在你需要的时候会有价值，所以不必一直写if let。

//nil coalescing运算符解包一个可选项，如果有值则返回值。如果没有值 - 如果是可选的nil- 则使用默认值。无论哪种方式，结果都不是可选的：它将来自可选内部的值或用作备份的默认值。
//6.??
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

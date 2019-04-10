import UIKit

//https://www.hackingwithswift.com/100

//functions, parameters, and errors

//1.不带参
//Swift函数以func关键字开头，然后是函数名，然后()括号。函数的所有主体 - 在请求函数时应该运行的代码 - 放在大括号内。
func printHelp() {
    let message = """
Welcome to MyApp!
Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    print(message)
}

printHelp()

//2.带参
func square(number: Int) {
    print(number * number)
}

square(number: 20)

//3.返回值
//如果要返回多个内容，请使用元组
func sum(number: Int) -> Int {
    return number + 1
}

let result = sum(number: 3)

//4.参数标签
//Swift允许我们为每个参数提供两个名称：一个在调用函数时在外部使用，另一个在函数内部使用。这就像写两个名称一样简单，用空格分隔。
func square(to number: Int) {
    print(number * number)
}

square(to: 4)

//5.省略参数标签
func square(_ num: Int) {
    print(num * num)
}

square(5)

//6.默认参数
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

//7.变量函数  接受零个或多个特定参数，Swift将输入转换为数组
//通过...在其类型后写入来使任何参数可变参数，只需将它们用逗号分隔即可
func square(numbers: Int...) {
    for num in numbers {
        print("\(num) square is \(num * num)")
    }
}

square(numbers: 1, 2 , 3, 4)

//8.throw函数
//有时函数会因为输入错误或内部出错而失败。Swift允许我们通过将它们标记为throws返回类型之前从函数中抛出错误，然后throw在出现错误时使用关键字。
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

/* 需要使用三个新关键字来调用这些函数:
 do启动可能导致问题的代码段
 try在每个可能引发错误的函数之前使用
 并catch让您正常处理错误
 */
//如果在do块内抛出任何错误，执行会立即跳转到catch块
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

//9.inout
/*
 传递给Swift函数的所有参数都是常量，因此您无法更改它们。
 如果需要，可以传入一个或多个参数inout，这意味着它们可以在函数内部进行更改，并且这些更改会反映在函数外部的原始值中。
 要使用它，首先需要创建一个变量整数 - 不能使用常量整数inout，因为它们可能会被更改。
 您还需要将参数传递给doubleInPlace使用＆符号，&在其名称之前，这是一个明确的识别，您知道它被用作inout。
 */
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)

//总结
/*
 1.函数让我们重用代码而不重复自己。
 2.函数可以接受参数 - 只需告诉Swift每个参数的类型。
 3.函数可以返回值，您只需指定要返回的类型。如果要返回多个内容，请使用元组。
 4.您可以在外部和内部使用不同的参数名称，也可以完全省略外部名称。
 5.参数可以具有默认值，这有助于您在特定值通用时编写更少的代码。
 6.变量函数接受零个或多个特定参数，Swift将输入转换为数组。
 7.函数可能会抛出错误，但您必须使用它们来调用它们try并处理错误catch。
 8.您可以使用inout更改函数内的变量，但通常最好返回一个新值。
 */

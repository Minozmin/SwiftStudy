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

//2.带参 默认是let，也只能是let
func square(number: Int) {
    print(number * number)
}

square(number: 20)

//3.返回值
//如果要返回多个内容，请使用元组

/// 求合
/// - Parameter number: 累加值
/// - Returns: 返回值
func sum(number: Int) -> Int {
    // 隐式返回值：如果只有一句代码可以省略return
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
//c++的默认参数有个限制：必须是从右往左设置。由于swift拥有参数标签，因此并没有此类限制
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

//省略标签时，需要特别注意，避免出错
// middle标签不可以省略
func greet1(_ first: Int = 10, middle: Int, _ last: Int = 10) {}
greet1(middle: 0)

// 可变参数
/*
 1.一个函数最多只能有一个可变参数
 2.紧跟在可变参数后面的参数不能省略参数标签
 */
func sum(_ numbers: Int..., string: String, _ other: String) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
sum(10, 20, string: "可变参数", "可变参数2")
sum(30, 40, 50, 60, string: "可变参数", "可变参数2")

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
 1.可以在函数内部修改外部实参的值
 2.可变参数不能标记为inout
 3.inout不能有默认值
 4.inout本质是地址传递(引用传递）
 5.inout参数只能传入被多次赋值的（比如变量）
 */
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)

// print函数
// separator间隔符，terminator结束符
print(1, 2, 3, separator: ",", terminator: ".")

// 函数重载
/*
 1. 函数名相同
 2. 参数个数不同 || 参数类型不同 || 参数标签不同
 
 注意点：
 1. 返回值类型与函数重载无关
 2. 默认参数值与函数重载一起使用产生二义性时，编译品并不会报错（在c++中会报错）
 3. 可变参数、省略参数标签、函数重载一起使用产生二义性时，编译品有可能会报错
 */

func sumLoad(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func sumLoad(v1: Int, v2: Int, v3: Int) -> Int {
    v1 + v2 + v3
} // 参数个数不同

func sumLoad(v1: Int, v2: Double) -> Double {
    Double(v1) + v2
} // 参数类型不同

func sumLoad(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
} // 参数标签不同

// 肉联函数
/*
 哪些函数不会被肉联？
 1.函数体比较长
 2.包含递归调用
 3.包含动态派发
 */
func test() {
    print("test")
}
test()
// 如果开启肉联函数，直接将print("test")放在test()处调用

// 函数类型
func difference(v1: Int, v2: Int) -> Int {
    v1 - v2
}

func printResult(_ mathFn: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFn(a, b))")
}

printResult(difference, 5, 3)

// typealias 给类型起别名
typealias Byte = Int

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

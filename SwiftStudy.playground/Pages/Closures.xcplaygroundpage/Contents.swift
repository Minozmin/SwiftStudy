import UIKit

//https://www.hackingwithswift.com/100

//Closures

/* 函数和闭包的区别：
 1.运行闭包时不使用参数标签
 */

//1.创建基本闭包
/*
 Swift让我们像其他任何类型一样使用函数，比如字符串和整数。这意味着您可以创建一个函数并将其分配给变量，使用该变量调用该函数，甚至将该函数作为参数传递给其他函数。
 以这种方式使用的函数称为闭包，虽然它们像函数一样工作，但它们的编写方式略有不同。
 */
let driving = {
    print("I'm driving in my car")
}

driving()

//2.授受闭包中的参数  参数 in 实现
let drivingWithParams = { (place: String) in
    print("I'm going to \(place) in my car")
}

drivingWithParams("China")

//3.从闭包返回值
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car."
}
let message = drivingWithReturn("London")
print(message)

//4.闭包作为参数
//() -> Void用来表示“不接受任何参数并且不返回任何内容”
func travel(action: () -> Void) {
    print("I'm getting ready to go")
    action()
    print("I arrived!")
}

travel(action: driving)

//5.尾随闭包语法
//如果函数的最后一个参数是闭包，Swift允许您使用称为尾随闭包语法的特殊语法。而不是将闭包作为参数传递，而是在括号内的函数之后直接传递它。
//因为它的最后一个参数是一个闭包，我们可以travel()使用这样的尾随闭包语法调用
travel() {
    print("abc")
}
//事实上，因为没有任何其他参数，我们可以完全消除括
travel {
    print("edf")
}

//多个参数时，最后一个参数是闭包
func test(data: String, action: () -> Void) {
    action()
    print(data)
}

test(data: "test") {
    print("success")
}

//5.在接受参数时使用闭包作为参数
func travelWithParams(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travelWithParams { (place) in
    print("I'm going to \(place) in my car")
}

//6.在返回值时使用闭包作为参数
//它接受一个参数，它是一个闭包，它本身接受一个参数并返回一个字符串。
func travelWithReturn(action: (String) -> (String)) {
    print("I'm getting ready to go.")
    let msg = action("London")
    print(msg)
    print("I arrived!")
}

//我们可以travel()使用以下内容调用
travelWithReturn { (place: String) -> (String) in
    return "I'm going to \(place) in my car"
}

//但是，Swift 知道该闭包的参数必须是一个字符串，所以我们可以删除它
travelWithReturn { place -> (String) in
    return "I'm going to \(place) in my car"
}

//它也知道闭包必须返回一个字符串，所以我们可以删除它
travelWithReturn { place in
    return "I'm going to \(place) in my car"
}

//因为闭包只有一行代码必须是返回值的代码，所以Swift也允许我们删除return关键字
travelWithReturn { place in
    "I'm going to \(place) in my car"
}

//Swift有一个简短的语法，可以让你更短。place in我们可以让Swift为闭包的参数提供自动名称，而不是写入。它们以美元符号命名，然后从0开始计数。
//$0速记参数名称
travelWithReturn {
    "I'm going to \($0) in my car"
}

//6.具有多个参数的闭包
func travelWithTwoParams(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let msg = action("London", 90)
    print(msg)
    print("I arrived!")
}

travelWithTwoParams {
    "I'm going to \($0) at \($1) miles per hour"
}

//7.从函数返回闭包
//使用->两次：一次指定函数的返回值(Void)，第二次指定闭包的返回值(String)
func eat() -> (String) -> Void {
    return {
        print("eat \($0)")
    }
}

 let result = eat()
result("apple")

//8.闭包捕获值
func eat2() -> (String) -> Void {
    var count = 1
    return {
        print("eat \($0), \(count)")
        count += 1
    }
}

let result1 = eat2()
result1("pear")
result1("banana")
result1("orange")

//总结
/*
 1.您可以为变量分配闭包，然后稍后调用它们。
 2.闭包可以接受参数和返回值，如常规函数。
 3.您可以将闭包作为参数传递给函数，这些闭包可以具有自己的参数和返回值。
 4.如果函数的最后一个参数是闭包，则可以使用尾随闭包语法。
 5.Swift自动提供速记参数的名称，如$0和$1，但不是每个人都使用它。
 6.如果在闭包内使用外部值，它们将被捕获，因此闭包可以在以后引用它们。
 */


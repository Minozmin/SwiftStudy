//: [Previous](@previous)

import UIKit

// Error
/*
 1.Swfit中可以通过Error协议自定义运行时的错误信息
 2.函数内部通过throw抛出自定义Error，可能会抛出Error的函数必须加上throws声明
 3.需要使用try调用可能会抛出Error的函数
 
 do-catch
 1.可以使用do-catch捕捉Error
 2.抛出Error后，try下一句直到作用域结束的代码都将停止运行
 
 处理Error的2种方式
 1.通过do-catch捕捉Error
 2.不捕捉Error，在当前函数增加throws声明，Error将自动抛给上层函数
   -如果顶层函数（main函数）依然没有捕捉Error，那么程序将终止
 */

enum SomeError: Error {
    case illegalArg(String)
    case outOfBounds(Int, Int)
    case outOfMemory
}

func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0不能作为除数")
    }
    return num1 / num2
}

func test() {
    do {
        let result = try divide(10, 3)
        print(result)
    } catch let SomeError.illegalArg(msg) {
        print("参数异常：", msg)
    } catch SomeError.outOfMemory {
        print("内存溢出")
    } catch is SomeError {
        print("is SomeError")
    } catch let error {
        switch error {
        case let SomeError.illegalArg(msg):
            print("参数错误：", msg);
        default:
            print("其它错误1")
        }
    }
    // 以下两种方法也可以，注释是为了消除警告
//    catch let error as SomeError {
//        print("error:", error)
//    } catch {
//        print("其它错误")
//    }
}

test()

func test1() throws {
    try divide(10, 0)
}

try test1()



// try?、try!
/*
 1.可以使用try?、try!调用可能会抛出Error的函数，这样就不用去处理Error
 */

func test2() {
    var _ = try? divide(20, 10) // Optional(2), Int?
    var _ = try? divide(20, 0) // nil
    var _ = try! divide(20, 10) // 2, Int
}

// var _ = try? divide(20, 0) 等价于
var b: Int?
do {
    b = try divide(20, 0)
} catch {
    b = nil
}


// rethrows
/*
 rethrows表明：函数本身不会抛出错误，但调用闭包参数抛出错误，那么它会将错误向上抛
 */
func exec(_ fn: (Int, Int) throws -> Int, _ num1:Int, _ num2: Int) rethrows {
    print(try fn(num1, num2))
}

try exec(divide(_:_:), 20, 0)



// defer
/*
 1.defer语句：用来定义以任何方式（抛错误、return等）离开代码块前必须要执行的代码
 2.defer语句将延迟至当前作用域结束之前执行
 3.defer语句的执行顺序与定义顺序相反
 */

func open(_ filename: String) -> Int {
    print("open")
    return 0
}

func close(_ file: Int) {
    print("close")
}

func processFile(_ filename: String) throws {
    let file = open(filename)
    defer {
        close(file)
    }
    
    try divide(20, 0)
    
    // close将会在这里调用
}

try processFile("test.text")

func fn1() { print("fun1") }
func fn2() { print("fun2") }
func testFn() {
    defer { fn1() }
    defer { fn2() }
}

testFn()
// 打印顺序
// fn2
// fn1

//: [Next](@next)

import UIKit

//https://www.hackingwithswift.com/100

// arrays, dictionaries, sets, and enums
//复杂类型

//1.数组
//它以括号开头和结尾，数组中的每个项用逗号分隔，数组位置从0开始计数
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"
let betales = [john, paul, george, ringo]
betales[2]

//创建数组
var array: [String] = []
var array1 = [String]()
var array2: Array<String>

//可以使用+运算符合并两个数组
var songs = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2

//还可以使用+ =来添加和分配
both += ["Everything has Changed"]

var arrdd = ["abc", "efgh", "ijk"]
let addCount = arrdd.map {
    $0.count
}
print(addCount)

// Array 常见操作
var arr = [1, 2, 3, 4]
// 映射
var arrMap = arr.map { $0 * 2 } // [2, 4, 6, 8]
// 过滤
var arrFilter = arr.filter{ $0 % 2 == 0 } // [2, 4]
// 有关联的操作
// 简写 arr.reduce(0) { $0 + $1 }
// arr.reduce(0, +)
var arrReduce = arr.reduce(0) {
    // result 上一次遍历返回的结果（初始值是0） $0
    // element 每次遍历到的数组元素  $1
    (result, element) -> Int in
    return result + element
} // 10

var arrMap1 = arr.map { Array.init(repeating: $0, count: $0) }
print(arrMap1) // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
var arrFlatMap = arr.flatMap { Array.init(repeating: $0, count: $0) }
print(arrFlatMap) // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

var arr1 = ["123", "test", "jack", "-30"]
var arrMap2 = arr1.map { Int($0) } // [Optional(123), nil, nil, Optional(-30)]
var arrCompactMap = arr1.compactMap { Int($0) } // // [123, -30]

// 使用lazy优化
let resultLazy = arr.lazy.map {
    (i: Int) -> Int in
    print("lazy--")
    return i * 2
}

print("resultLazy", resultLazy[0])
print("resultLazy", resultLazy[1])
/*
 lazy--
 resultLazy 2
 lazy--
 resultLazy 4
 */


// Optional 的 map 和 flatMap
var num1: Int? = 10
print(num1.map({ $0 * 2 }) as Any) // Optional(20)

var num2: Int? = nil
print(num2.map({ $0 * 2 }) as Any) // nil

print(num1.map({ Optional.some($0 * 2) }) as Any) // Optional(Optional(20))
print(num1.flatMap({ Optional.some($0 * 2) }) as Any) // Optional(20)



//2.集
/*
 集合是值的集合，就像数组一样，除了它们有两个不同之处：
 1.物品不以任何顺序存储; 它们存储在有效的随机顺序中。
 2.任何项目都不能在一组中出现两次; 所有项目必须是唯一的。
 */

//它只是无序的 --Swift不保证它的顺序。因为它们是无序的，所以不能像使用数组一样使用数字位置从集合中读取值。
let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue"])



//3.元组
/*
 元组允许您将多个值存储在一个值中。这可能听起来像数组，但元组是不同的：
 1.您无法在元组中添加或删除项目; 它们的大小是固定的。
 2.你不能改变元组中的项目类型; 它们总是与创建它们的类型相同。
 3.您可以使用数字位置或命名来访问元组中的项目，但Swift不会让您读取不存在的数字或名称。
 通过将多个项放入括号来创建元组，如下所示：
 */
let name1 = (404, "Not Found")
name1.0

var name = (first: "Taylor", last: "Swift")
name.0
name.last

//您可以在创建元组后更改元组内的值，但不能更改值的类型
name.first = "hehuimin"
name

// error
//name.last = 12

let (firstName, secondName) = name
firstName
secondName



//4.数组与集合与元组
//数组，集合和元组最初看起来很相似，但它们具有不同的用途。为了帮助您了解使用哪个，这里有一些规则。
//如果您需要特定的，固定的相关值集合，其中每个项目都有精确的位置或名称，您应该使用元组：
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

//如果您需要一组必须唯一的值，或者您需要能够非常快速地检查特定项目是否存在，那么您应该用集合：
let set = Set(["aardvark", "astronaut", "azalea"])

//如果您需要可以包含重复项的值集合，或者项目的顺序很重要，则应使用数组：
let pythons = ["Eric", "Terry", "John", "Terry"]



//5.字典
//就像数组一样，字典以括号开头和结尾，每个项用逗号分隔。但是，我们还使用冒号将要存储的值（value）与要存储它的标识符（key）分开。
//使用类型注释时，字典用括号括起来，标识符和值类型之间带有冒号。例如，[String: Double]和[String: String]。
let height = ["tyalor": 1.78, "swift": 1.80]
height["swift"]

// 字典默认值
height["tyalor"]
//print 1.78
height["Paul"]
//print nil
height["Paul", default: 0]
//print 0



//6.创建空集合
//如果要创建一个空集合，只需写入其类型，然后打开和关闭括号。例如，我们可以创建一个空字典，其中包含键和值的字符串，如下所示：
var teams = [String: String]()
teams["taylor"] = "swift"

//空数组
var results = [Int]()

//空集合
var words = Set<String>()

//这是因为Swift只对字典和数组有特殊的语法; 其他类型必须使用像括号一样的尖括号语法。
//如果需要，可以使用类似语法创建数组和字典：
var scores = Dictionary<String, Int>()
var results1 = Array<Int>()



//7.枚举 -- 值类型
//是一种以易于使用的方式定义相关值组的方法
enum Result {
    case success
    case failure
}
let result = Result.success

//关联值
// 有时将枚举的成员值跟其它类型的值关联存储在一起，会非常有用
enum Activity {
    case bored
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "abcd")

//原始值(rawValue) ：枚举成员可以使用相同类型的默认值预先关联，这个默认值叫做原始值，不会占用枚举变量的内存
//Swift将自动为每个从0开始的数字分配，如果需要，可以为一个或多个案例分配特定值
/*
 1.如果枚举的原始值类型是Int、String，swift会自动分配原始值
 2.Int自动从0开始
 3.String的默认值为case值一致
 */

/*
 rawValue 原理：
 -枚举原始值rawValue的本质是：只读计算属性
 */
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
let earth = Planet.earth.rawValue

// 枚举递归：枚举类型的成员里面用到了枚举类型
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case difference(ArithExpr, ArithExpr)
}

let five = ArithExpr.number(5)
let four = ArithExpr.number(4)
let two = ArithExpr.number(2)
let sum = ArithExpr.sum(five, four)
let difference = ArithExpr.difference(sum, two)

// memorylayout
// 可以使用memorylayout获取数据类型占用的内存大小
/*
 1. 1个字节存储成员值，多个case时；如果只有一个case的时候这个1个字节来存储成员值
 2. N个字节存储关联值（N取占用内存最大的关联值）,任何一个case的关联值都共用这N个字节
 */
var age = 10
enum Password {
    case number(Int, Int, Int, Int) // 32
    case other // 1
}
var pwd = Password.number(5, 2, 6, 4)

// 小端模式：高高低低
// 内存分配空间
// 05 00 00 00 00 00 00 00
// 02 00 00 00 00 00 00 00
// 06 00 00 00 00 00 00 00
// 04 00 00 00 00 00 00 00
// 01
// 00 00 00 00 00 00 00
pwd = Password.other
// 01 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 02
// 00 00 00 00 00 00 00

MemoryLayout<Password>.stride // 40, 分配占用的空间大小，实际上占用了33，然后要以8的倍数对齐，所以是40
MemoryLayout<Password>.size // 33, 实际用到的空间大小
MemoryLayout<Password>.alignment // 8, 对齐参数（单位字节）

//总结
/*
 1.数组，集合，元组和字典允许您将一组项目存储在单个值下。它们各自以不同的方式执行此操作，因此您使用它取决于您想要的行为。
 2.数组按您添加的顺序存储项目，并使用数字位置访问它们。
 3.设置没有任何订单的商店商品，因此您无法使用数字位置访问它们。
 4.元组的大小是固定的，您可以为每个项添加名称。您可以使用数字位置或使用您的名字来阅读项目。
 5.字典根据键存储项目，您可以使用这些键读取项目。
 6.枚举是一种对相关值进行分组的方法，因此您可以使用它们而不会出现拼写错误。
 7.您可以将原始值附加到枚举，以便可以从整数或字符串创建它们，也可以添加关联值以存储有关每个案例的其他信息。
 */

//https://www.jianshu.com/p/e8b1336d9d5d
//写时复制copy-on-write
//在 Swift 标准库中，像是 Array，Dictionary 和 Set 这样的集合类型是通过一种叫做写时复制 (copy-on-write) 的技术实现的。

//打印地址
func print(address o: UnsafeRawPointer ) {
    print(String(format: "%p", Int(bitPattern: o)))
}



//错误处理方式
//第一种
//enum ShareError: Error {
//    case exceedingLimit
//}
//
//extension ShareError: LocalizedError {
//    public var errorDescription: String? {
//        switch self {
//        case .exceedingLimit:
//            return "Text exceeding limit"
//        }
//    }
//}

//第二种
//enum ShareError: Error, CustomDebugStringConvertible {
//    case exceedingLimit
//    var debugDescription: String {
//        switch self {
//        case .exceedingLimit:
//            return "文本超过限制"
//        }
//    }
//}

enum ShareError: Error {
    public enum ExceedingLimit: Error {
        case text
        case content
        case url
    }
    
    case exceedingFail(reason: ExceedingLimit)
}

extension ShareError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .exceedingFail(let reason):
            return reason.localizedDescription
        }
    }
}

extension ShareError.ExceedingLimit {
    var localizedDescription: String {
        switch self {
        case .text:
            return "text is nil"
        default:
            return ""
        }
    }
}

extension String {
    
    //检测文本大小
    func checkSize(to byte: Int) throws -> Bool {
        let data = self.data(using: String.Encoding.utf8) ?? Data()
        if data.count > byte {
            throw ShareError.exceedingFail(reason: ShareError.ExceedingLimit.text)
        }
        return true
    }
}

let fixStr = "swift字符串截取"
do {
    let isMatch = try fixStr.checkSize(to: 4)
    print(fixStr, fixStr.count, isMatch )
}catch let error {
    //第一种打印错误方式
//    print(error.localizedDescription)
    //第二种打印错误方式
    print(error.localizedDescription)
}


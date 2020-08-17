import UIKit

//https://www.hackingwithswift.com/100

//variables, simple data types, and string interpolation
//简单类型

// 常量 let
/*
 1.只能赋值1次
 2.它的值不要求在编译时期确定，但使用之前必须赋值1次
 3.常量、变量在初始化之前，都不能使用的
 */
let taylor = "swift"
let number: Int
number = 10


// 变量
var str = "Hello, playground"
str = "hehuimin"
type(of: str)


// 整数
var age = 27

// 千位分隔符_
var population = 8_000_000

// Double多精度
var pi: Double = 3.14

// Bool值，它们只包含true或false
var awesome: Bool = true


// 字符串 区分大小写
let album: String = "hehuimin"

// 类型转换
let aa = album + String(age)

// 拼接
var string1: String = "1"
string1.append("_2")

// 重载运算符
string1 = string1 + "_3"

// 字符串插值 \()
string1 = "\(string1)_4"

// 长度count
print(string1.count)

// 标识符
/*
 1.标识符（比如常量名，变量名，函数名）几乎可以使用任何字符
 2.标识符不能以数字开头，不能包含空白字符、制表符、箭头等特殊字符
 */
let 🙃 = "happy"

// 插入和删除
var string2 = "1_2"
// startIndex的位置是1的位置
// endIndex的位置是在2后面
// 插入字符
string2.insert("_", at: string2.endIndex);
print(string2) // 1_2_
// 插入字符串
string2.insert(contentsOf: "3_4", at: string2.endIndex)
print(string2) // 1_2_3_4
string2.insert(contentsOf: "aaa", at: string2.index(after: string2.startIndex))
print(string2) // 1aaa_2_3_4
string2.insert(contentsOf: "bbb", at: string2.index(before: string2.endIndex))
print(string2) // 1aaa_2_3_bbb4
string2.insert(contentsOf: "ccc", at: string2.index(string2.startIndex, offsetBy: 4))
print(string2) // 1aaaccc_2_3_bbb4

// 删除
string2.remove(at: string2.startIndex)
print(string2) // aaaccc_2_3_bbb4
string2.remove(at: string2.firstIndex(of: "a")!)
print(string2) // aaccc_2_3_bbb4
// 遍历字符串所有的字符中包含c的全部删除
string2.removeAll { $0 == "c" }
print(string2) // aa_2_3_bbb4
string2.removeSubrange(string2.index(string2.endIndex, offsetBy: -4)..<string2.index(before: string2.endIndex))
print(string2) // aa_2_3_4

// Substring 子串
/*
 1.String可以通过下标、prefix、suffix等截取子串，子串类型不是String，而是Substring
 2.Substring和它的base，共享字符串数据
 3.Substring转为String时，会重新分配新的内存存储字符串数据
 */
var string3 = "1_2_3_4_5"
var subStr1 = string3.prefix(3)
print(subStr1) // 1_2
var subStr2 = string3.suffix(3)
print(subStr2) // 4_5
var range = string3.startIndex..<string3.index(string3.startIndex, offsetBy: 3)
// 范围 返回值是Substring类型
var subStr3 = string3[range]
print(subStr3) // 1_2
// 最初的String
print(subStr3.base) // 1_2_3_4_5
// Substring -> String
var newSubStr3 = String(subStr3)
print(newSubStr3) // 1_2

// String 与 Character
// 字符类型，需指定类型，不指定类型默认是字符串类型
let character: Character = "d"
// 索引 返回值是Character类型
var c = string3[string3.startIndex]

// 多行字符串
/* 保留格式：多行展示
 1.缩进以结尾的3引号为对齐线
 2.如果要显示3引号，至少要转义一个引号
 */
var str1 = """
This goes ""\"
over multiple
lines
"""
print(str1)

// 加\不保留格式：一行展示
var str2 = """
This goes \
over multiple \
lines
"""
print(str2)


// String 相关的协议
/*
 BidirectionalCollection 协议包含的部分内容
 startIndex、endIndex 属性、index方法
 String、Array 都遵守了这个协议
 
 RangeReplaceableCollection 协议包含的部分内容
 append、insert、remove方法
 String、Array 都遵守了这个协议
 
 Dictionary、Set 也有实现上述协议中声明的一些方法，只是并没有遵守上述协议
 */


// String 与 NSString
/*
 1.String 与 NSString 之间可以互相桥接转换
  -如果你觉得String的API过于复杂难用，可以考虑将String 转为 NSString
 2.String 不能桥接转换成 NSMutableString
 3.可以直接用as 转换类型表示可以桥接
 
 比较字符串内容是否等价
 1.String使用 == 运算符
 2.NSString使用isEqual方法，也可以使用 == 运算符（本质还是调用了isEqual方法）
 
 Swfit、OC桥接转换表（直接通过as转换）:
 String <=> NSString
 String <-  NSMutableString
 String <=> NSArray
 String <-  NSMutableString
 String <=> NSDictionary
 String <-  NSMutableDictionary
 String <=> NSSet
 String <-  NSMutableSet
 */
var str5 = "Jack"
var str6 = "Rose"
// 中间需要调函数转换，会消耗部分性能，可忽略不计
var str7 = str5 as NSString
var str8 = str6 as String
var str9 = str7.substring(with: NSRange(location: 0, length: 2))
print(str9) // Ja


str5.append("_1")
print(str5, str7) // Jack_1 Jack


// 字面量（Literal）
/*
 常见字面量的默认类型
 public typealias IntegerLiteralType = Int
 public typealias FloatLiteralType = Double
 public typealias BooleanLiteralType = Bool
 public typealias StringLiteralType = String
 
 swift自带的绝大部分类型，都支持直接通过字面量进行初始化
 Bool, Int, Float, Double, String, Array, Dictionary, Set, Optional等
 
 swif自带类型之所以能够通过字面量初始化，是因为他们遵守了对应的协议
 Bool: ExpressibleByBooleanLiteral
 Int: ExpressibleByIntegerLiteral
 ...
 */
extension Int: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = value ? 1 : 0
    }
}

var num: Int = true
print(num)


// 通配符模式(Wildcard Pattern)
/*
 _ 匹配任何值
 -? 匹配非nil值
 */

// 枚举模式
/*
 if case语句等价于只有1个case的switch语句
 */
func test () {
    let age2 = 2
    // 原来的写法
    if age2 >= 0 && age2 <= 9 {
        print("[0, 9]")
    }

    // 可以用if case 匹配
    if case 0...9 = age2 {
        print("[0, 9]")
    }
    
    guard case 0...9 = age2 else {
        return
    }

    print("[0, 9]")
    
    // 等价于以上2个方法
    switch age2 {
    case 0...9:
        print("[0, 9]")
    default:
        break
    }
    
    let ages: [Int?] = [2, 3, nil, 5]
    for case nil in ages {
        print("有nil值")
        break
    }
    
    let points = [(1, 0), (2, 1), (3, 0)]
    for case let (x, 0) in points {
        print(x) // 1 3
    }
}

// 可选模式
let nums: [Int?] = [nil, 2, 3, nil, 5]
for case let num? in nums {
    print(num) // 2 3 5
}

for num in nums {
    if let item = num {
        print(item)
    }
} // 2 3 5 等价于上面的for


// 表达式模式
/*
 可以通过重载运算符，自定义表达式模式的匹配规则
 */
struct Student {
    var score = 0, name = ""
    
    /// pattern:  case后面的内容
    /// value:  switch后面的内容
    /// 返回值Bool 是固定的
    static func ~= (pattern: Int, value: Student) -> Bool {
        value.score >= pattern
    }
    
    static func ~= (pattern: Range<Int>, value: Student) -> Bool {
        pattern.contains(value.score)
    }
    
    static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool {
        pattern.contains(value.score)
    }
}
var stu = Student(score: 20, name: "Jakc")
switch stu {
case 100: print(">= 100")
case 90: print(">= 90")
case 80..<90: print("(80, 90)")
case 60...79: print("(60, 79)")
case 0: print(">= 0")
default: break
}


func hasPrefix(_ prefix: String) -> ((String) -> Bool) {
//    return {
//        (str: String -> Bool) in
//        str.  hasPrefix(prefix)
//    }
    // 简写
    { $0.hasPrefix(prefix) }
}

func hasSuffix(_ suffix: String) -> ((String) -> Bool) {
    { $0.hasSuffix(suffix) }
}

extension String {
    static func ~= (pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}

var testStr = "123456"
switch testStr {
case hasPrefix("12"):
    print("以12开头")
case hasSuffix("56"):
    print("以56结尾")
default:
    break
}


// 可以使用where为模式增加匹配条件
// 可以在case, for, 关联类型, 泛型, 协议扩展等后面使用
let ages = [10, 20, 43, 23]
for age in ages where  age > 20 {
    print(age)
}


//总结
/*
 1.使用var和常量使用变量let。最好尽可能经常使用常量。
 2.字符串以双引号开头和结尾，但如果您希望它们跨多行运行，则应使用三组双引号。
 3.整数保持整数，双数保持小数，而布尔值保持真或假。
 4.字符串插值允许您从其他变量和常量创建字符串，将它们的值放在字符串中。
 5.Swift使用类型推断来分配每个变量或常量类型，但是如果需要，可以提供显式类型。
 */

extension Dictionary where Key == String, Value == Any {
    mutating func setupShareParams(title: String, content: String, thumbImage: String, url: String
        ) {
        updateValue(title, forKey: "title")
        updateValue(content, forKey: "content")
        updateValue(thumbImage, forKey: "thumbImage")
        updateValue(url, forKey: "url")
    }
}

var dict = [String: Any]()
dict.setupShareParams(title: "title", content: "content", thumbImage: "thumbImage", url: "url")
print(dict)

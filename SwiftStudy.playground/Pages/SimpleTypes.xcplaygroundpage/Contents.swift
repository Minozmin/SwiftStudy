import UIKit

//https://www.hackingwithswift.com/100

//variables, simple data types, and string interpolation
//简单类型

//1.变量
//创建变量时分配值
var str = "Hello, playground"
str = "hehuimin"
type(of: str)

//使用类型注释
//Swift字符串区分大小写
var name: String
name = "hehuimin"

//2.字符串和整数
//这包含一个整数，因此Swift指定类型Int- “整数”的缩写。
var age = 27
// 如果您有大数字，Swift允许您使用下划线作为千位分隔符 - 它们不会更改数字，但它们确实使它更容易阅读。例如：
var population = 8_000_000

//字符串和整数是不同的类型，它们不能混合。所以，虽然str改为“再见” 是安全的，但我不能把它变成38，因为那Int不是一个String。
//str = 89

//3.多行字符串
//标准Swift字符串使用双引号，但您不能在其中包含换行符。
//如果你想要多行字符串，你需要稍微不同的语法：开头和结尾有三个双引号，如下所示
var str1 = """
This goes
over multiple
lines
"""
print(str1)

//Swift特别关注你如何编写引号：开始和结束三元组必须在它们自己的行上，但是开始和结束换行符不会包含在你的最终字符串中。
//如果你只想要多行字符串来整齐地格式化代码，并且你不希望这些换行符实际存在于你的字符串中，那么用a结束每一行\，如下所示：
var str2 = """
This goes \
over multiple \
lines
"""
print(str2)

//4.Doubles and booleans 多精度和布尔
//“Double”是“双精度浮点数”的缩写，它是一种奇特的方式，它表示它包含小数值
var pi = 3.14
//Bool值，它们只包含true或false
var awesome = true

//5.字符串插值
//您可以在字符串中放置任何类型的变量 - 您只需要写一个反斜杠\，然后在括号中输入变量名。例如：
var score = 85
var str3 = "Your score was \(score)"
var result = "The test results are here: \(str3)"

//6.常量
//该let关键字创建常数，这是可以设置一次，永远不会再值。例如：
let taylor = "swift"

//7.Type annotations
//指定数据类型  请注意，布尔值具有短类型名称Bool，与整数具有短类型名称的方式相同Int。
let album: String = "hehuimin"
let year: Int = 2019
let height: Double = 3.14
let taylorRocks: Bool = true

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

import UIKit

//https://www.hackingwithswift.com/100

//operators and confitions

//1.算术运算符 + - * / %
let firstScore = 12
let secondScore = 4
let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = firstScore % secondScore

//当谈到字符串时，+会将它们连接在一起
let name1 = "Tim McGraw"
let name2 = "Romeo"
let both = name1 + " and " + name2

//2.运行符重载
let meaningOfLine = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna"
let action = fakers + "fake"

let firstHalf = ["Join", "Paul"]
let seconHalf = ["George", "Ringo"]
let beatles = firstHalf + seconHalf

//注意：Swift是一种类型安全的语言，这意味着它不会让你混合类型。例如，您不能向字符串添加整数，因为它没有任何意义。

//3.复合赋值运算符 -= +=
var score = 95
score -= 5

//添加然后分配给
//获取当前值quote，为其添加"world"，然后将结果放回去quote
var quote = "hello "
quote += "world"

//4.比较运算符  == != > >= < <=
firstScore == secondScore
firstScore != secondScore
firstScore > secondScore
firstScore <= secondScore

//5.条件
if firstScore + secondScore == 16 {
    print("true")
}else {
    print("false")
}

if firstScore - secondScore == 1 {
    print("a")
}else if firstScore - secondScore == 9 {
    print("b")
}else {
    print("c")
}

//6.组合条件 && ||
if firstScore > 5 && secondScore > 5 {
    print("Both are over 5")
}

if firstScore > 5 || secondScore > 5 {
    print("One of them is over 5")
}

//7.三元运算符 ?:
firstScore > secondScore ? true : false

//8.切换语句 switch
//default 是必需的，因为Swift确保您涵盖所有可能的情况，以免错过任何可能性
//swift只会在每个case中运行代码。如果您希望执行继续下一个案例，请使用如下fallthrough关键字
let weather = "sunny"
switch weather {
case "rain":
    print("rain")
case "snow":
    print("snow")
case "sunny":
    print("sunny")
    fallthrough
default:
    print("Enjoy your day")
}

//9.范围 range operators
//..< 半开放范围运算符，不包括最终值
//... 闭合范围运算符，包括最终值
let range = 5
switch range {
case 0..<5:
    print("0..<5")
case 0...5:
    print("0...5")
default:
    print("default")
}

//总结
/*
 1.Swift有算术和比较的操作员; 他们大多像你已经知道的那样工作。
 2.算术运算符的复合变体可以修改它们的变量：+=，-=等等。
 3.您可以根据条件的结果使用if，else和else if运行代码。
 4.Swift有一个三元运算符，它将检查与真假代码块结合在一起。虽然您可能会在其他代码中看到它，但我不建议您自己使用它。
 5.如果您使用相同的值有多个条件，则使用它通常更清晰switch。
 6.您可以使用..<和...取决于是否应排除或包括最后一个数字。
 */

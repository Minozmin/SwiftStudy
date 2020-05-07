import UIKit

//https://www.hackingwithswift.com/100

//loops, loops, and more loops

//元组不能循环

//1.for 循环
/*
 闭区间运算符：a...b a <= 取值 <= b
 开区间运算符：a..<b a <= 取值 < 3
 */
let count = 1...10
// number默认是let，如果要改变值需要加 var
// where 符合条件执行循环，不符合则不执行；不是中断循环的条件
for number in count where number > 4 {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

for value in albums[0...2] {
    print(value)
}

// 单侧区间：让区间朝一个方向尽可能的远
for _ in albums[2...] {
    // 取值2-3
}

for _ in albums[...2] {
    // 取值0-2
}

for _ in albums[..<2] {
    // 取值0-1
}

let _ = ...5 //无穷小-5

// 字符、字符串也能用区间运算符，但是不能用在for-in中
let stringRange = "cc"..."ff"
stringRange.contains("dd")
stringRange.contains("zz")

// 带间隔区间值
// trckMark的取值：从4开始，不超过11，累加2，
for trckMark in stride(from: 4, to: 11, by: 2) {
    print(trckMark)
}// 4 6 8 10

//如果你不使用for循环给你的常量，你应该使用下划线，以便Swift不会创建不必要的值：
for _ in 1..<5 {
    print("play")
}

//2.while 循环
var number = 1
while number <= 20 {
    print(number)
    number += 1
}

//3.repeat 循环
repeat {
    print(number)
    number += 1
} while number <= 20
//因为条件在循环结束时出现，repeat循环内的代码将始终至少执行一次，而while循环在第一次运行之前检查它们的条件。

//4.退出循环
//使用break关键字退出循环
var countDown = 10
while countDown >= 0 {
    print(countDown)
    if countDown == 4 {
        break
    }
    countDown -= 1
}

//5.退出多层循环
//嵌套循环
for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) = \(product)")
    }
}

//结束内部循环
for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("two: \(i) * \(j) = \(product)")
        
        if j == 3 {
            break
        }
    }
}

//结束外部循环，需要给外部循环一个标签
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("three: \(i) * \(j) = \(product)")
        
        if j == 5 {
            break outerLoop
        }
    }
}

//5.跳过项目
//break关键字退出循环。但是，如果您只想跳过当前项目并继续下一个项目，则应该使用continue。
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

//6.无限循环
//使用while循环来创建无限循环，要进行无限循环，只需使用true您的条件。true永远是真的，所以循环将永远重复。警告：请确保您有一个退出循环的支票，否则它将永远不会结束。
while true {
    number += 1
    
    print(number)
    
    if number == 300 {
        break
    }
}

//总结
/*
 1.循环让我们重复代码，直到条件为假。
 2.最常见的循环是for，将循环内的每个项目分配给临时常量。
 3.如果你不需要for循环给你的临时常量，请使用下划线，以便Swift可以跳过这项工作。
 4.有一些while循环，您提供了一个明确的条件来检查。
 5.虽然它们与while循环相似，但repeat循环始终至少运行一次循环体。
 6.您可以使用退出单个循环break，但是如果您有嵌套循环，则需要使用break后跟您在外循环之前放置的任何标签。
 7.您可以使用循环跳过项目continue。
 8.无限循环在你要求它们使用之前不会结束while true。确保你有条件在某个地方结束你的无限循环！
 */

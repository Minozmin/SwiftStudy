//: [Previous](@previous)

import Foundation

// MARK、TODO、FIXME
/*
 // MARK: 类似于OC中的 #pragma mark
 // MARK: - 类似于OC中的 #pragma mark -
 // TODO: 用于标记未完成的任务
 // FIXME: 用于标记待修复的问题
 #warning("undo")
 */

// 方法还未实现，但是不想方法报错，可以用fatalError占位，加#warning提示
func test() -> Int {
    #warning("undo")
    fatalError()
}

// 条件编译
/*
 // 操作系统：macOS\iOS\tvOS\watchOS\Linux\Android\Windows\FreeBSD
 #if os(macOS) || os(iOS)
 // CPU架构：i386\x86_64\arm\arm64
 #elseif arch(x86_64) || arch(arm64)
 // swift版本
 #elseif swift(<5) && swift(>=3)
 // 模拟器
 #elseif targetEnvironment(simulator)
 // 可以导入某模块
 #elseif canImport(Foundation)
 #else
 #endif
 
 Build Settings ->搜索 swift compiler - custom
 
 自定义模式的两种方法：
 1.Active Compilation Conditions -> Debug 加上 DEBUG TEST
 2.Other Swift Flags -> Debug 加上 -D OTHER
 
 // debug模式
 #if DEBUG
 // release模式
 #else
 #endif
 */

// 打印
func log<T>(_ msg: T,
            file: NSString = #file,
            line: Int = #line,
            fn: String = #function) {
    // playground 中宏定义不生效
    #if DEBUG
    print("\(file.lastPathComponent)_\(line)_\(fn):", msg)
    #endif
}
log("fdfd")

// 系统版本检测
if #available(iOS 10, macOS 10.12, *) {
    // 对于iOS平台，只有在iOS 10及以上版本执行
    // 对于macOS平台，只在macOS 10.12及以上版本执行
    // 后面的*表示在其它所有平台都执行
}

// API可用性说明
/*
 @available(iOS 10, macOS 10.12, *)
 @available(iOS, deprecated: 11)
 @available(*, unavailable, renamed: "study")
 
 参考文档：https://docs.swift.org/swift-book/ReferenceManual/Attributes.html
 */

@available(iOS 10, macOS 10.12, *)
class Person {}

struct Student {
    @available(*, unavailable, renamed: "study")
    func study_() {}
    func study() {}
    
    @available(iOS, deprecated: 11)
    func run() {}
}

var stu = Student()

// iOS程序的入口
/*
 1.在AppDelegate上面默认有个@UIApplicationMain标记，这表示
  -编译器自动生成入口代码（main函数代码），自动设置AppDelegate为App的代理
 2.也可以删掉@UIApplicationMain，自定义入口代码：新建一个main.swift文件
 
 import UIKit

 class HMApplication: UIApplication {
     
 }

 UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, NSStringFromClass(HMApplication.self), NSStringFromClass(AppDelegate.self))
 */


// swift调用oc
/*
 1.新建1个桥接头文件，文件名格式默认为：{targetName}-Bridging-Header.h
  Build Settings -> 搜索 bridging -> Objective-C Bridging Header -> 设置桥接文件的路径
 2.创建一个OC文件，会自动帮你生成桥接文件
 
 在{targetName}-Bridging-Header.h 文件中 #import OC需要暴露给Swift的内容
 
 在swfit中调用oc中的-方法，用实例调用
 在swfit中调用oc中的+方法，用类调用
 在swfit中调用oc中的c语言方法，直接调用
 */


// swift调用oc - @_silgen_name
/*
 1.如果C语言暴露给swift的函数名跟swift中的其它函数名冲突了
  -可以在swift中使用 @_silgen_name 修改C函数名
 
 // C语言
 int sum(int a, int b) { return a + b; }

 // swift
 @_silgen_name("sum") // sum是存在的
 func swift_sum(_ v1: Int32, _ v2: Int32) -> Int32
 print(swift_sum(10, 20)) // 30
 print(sum(10, 20)) // 30
 
 */

 
// oc调用swift
/*
 oc导入头文件：
 1.xcode已经默认生成一个用于oc调用swift的头文件，文件格式是：{targetName}-Swift.h
 #import "{targetName}-Swift.h"
 
 2.文件配置路径：
 Build Settings -> Swift Compiler - General -> Objective-C Generated Interface Header name
 
 3.xcode会根据swift代码生对应的oc声明，写入{targetName}-Swift.h 文件
 
 oc中调用swfit：
 1.swfit暴露给oc的类最终继承自NSObject
 2.使用@objc修饰需要暴露给oc的成员
 3.使用@objcMembers修饰类
  -代表默认所有成员都会暴露给oc（包括扩展中定义的成员）
  -最终是否成功暴露，还需要考虑成员自身的访问级别
 
 重命名：
 可以通过@obj 重命名swift暴露给oc的符号名（类名、属性名、函数名等）
 @objc(HMStudent)
 @objc(exec:v2:)  // oc代码：[stu exec:10 v2: 20]
 */


// 选择器 selector
/*
 1.swift中依然可以使用选择器，使用#selector(name)定义一个选择器
  -必须是被@objcMembers或@objc修饰的方法才可以定义选择器
 #selector(test)
 #selector(test1(v1:))
 #selector(test2(v1:v2:))
 #selector(test2 as (Double, Double) -> Void)
 
 
 swift：方法调用通过虚表(汇编调用：call 0x1009)
 oc：方法调用通过runtime机制(汇编调用：objc_msgSend)
 纯swift类，在swift内调用的方法是通过swift的虚表
 纯oc类，暴露给swift调用还是通过oc的runtime机制
 swift通过继承NSObject暴露给oc调用，在oc中调用是通过oc的runtime机制
 swift通过继承NSObject暴露给oc调用，在swift中调用是通过swift的虚表
 
 在方法前面加dynamic关键字，该方法调用使用runtime机制
 */

//: [Next](@next)

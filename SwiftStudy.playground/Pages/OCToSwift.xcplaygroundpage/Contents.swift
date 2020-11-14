//: [Previous](@previous)

import Foundation
import UIKit

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


// 只能被class继承的协议
/*
 :AnyObject
 :class
 @objc
 
 被@objc修饰的协议，还可以暴露给oc去遵守实现
 */


// 可选协议
/*
 可以通过@objc定义可选协议，这种协议只能被class遵守
 */
@objc protocol Runnable {
    @objc optional func run1()
    
}

extension Runnable {
    func run2() {}
}

class Dog: Runnable {}

// dynamic
/*
 被@objc dynamic 修饰的内容会具有动态性，比如调用方法会走runtime那一套流程
 */
class Animal: NSObject {
    @objc dynamic func test1() {} // objc_msgsend
    func test2() {} // call xxx
}

// KVC\KVO
/*
 Swift 支持KVC\KVO的条件：
 1.属性所在的类、监听器最终继承自NSObject
 2.用@objc dynamic 修饰对应的属性
 
 block方式
 第一个参数需要在类名前面加\
 */
class Test: NSObject {
    func run() {
        addObserver(self, forKeyPath: "age", options: [.new, .old], context: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "age")
    }
}

// 关联对象
/*
 1.在Swift中，class依然可以使用关联对象
 2.默认情况下，extension不可以增加存储属性
  -借助关联属性，可以实现类似extension为class增加存储属性的效果
 */

extension Animal {
    private static var AGE_KEY: Void? // 占用1个字节（节省内存）
    var age: Int {
        get {
            objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int ?? 0
        }
        set {
            // 第一个参数是对象Animal，第二个参数是age的唯一的地址值
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}


// 资源名管理
let img = UIImage(named: "logo")

let btn = UIButton(type: .custom)
btn.setTitle("添加", for: .normal)

// 参考了Android的资源名管理方式
enum R {
    enum string: String {
        case add = "添加2"
    }
    
    enum image: String {
        case logo
    }
}

let img2 = UIImage(named: R.image.logo.rawValue)
btn.setTitle(R.string.add.rawValue, for: .normal)

// 其它思路 用enum、struct都可以
/*
 https://github.com/mac-cain13/R.swift
 https://github.com/SwiftGen/SwiftGen
 */
enum R2 {
    enum image {
        static var logo = UIImage(named: "logo")
    }
}
enum RImage {
    static var logo = UIImage(named: "logo")
}

let img3 = RImage.logo
let img4 = R2.image.logo


// 多线程 gcd

// 子线程
DispatchQueue.global().async {
    print(Thread.current)
    
    // 回到主线程
    DispatchQueue.main.async {
    }
}

let item = DispatchWorkItem {
    print("1", Thread.current)
}

DispatchQueue.global().async(execute: item)
item.notify(queue: DispatchQueue.main) {
    // 主线程里面的任务
}

public typealias Task = () -> Void

struct Asyncs {
    // 异步任务
    private static func _async(_ task: @escaping Task, _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    
    public static func async(_ task: @escaping Task, _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    
    // once
    /*
     1.可以用类型属性或者全局变量、常量
     2.默认自带 lazy + dispatch_once 效果
     */
    
    // 延迟
    @discardableResult
    public static func display(_ seconds: Double, _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        return item
    }
}

Asyncs.async {
    // 子线程
}

Asyncs.async({
    // 子线程
}) {
    // 主线程
}

let item2:DispatchWorkItem? = Asyncs.display(3) {
    // 延迟3秒在主线程执行
}
// 可以手动取消
item2?.cancel()

// 加锁
// 同时有一条线程
private var lock = DispatchSemaphore(value: 1)
lock.wait()
defer {
    lock.signal()
}

private var lock2 = NSRecursiveLock() // NSLock
lock2.lock()
defer {
    lock2.unlock()
}

//: [Next](@next)

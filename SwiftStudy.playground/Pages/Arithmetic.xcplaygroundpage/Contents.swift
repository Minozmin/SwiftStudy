//: [Previous](@previous)

import Foundation

// 求两数之和
// 方法一：遍历
func sum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0 ..< nums.count {
        for j in i + 1 ..< nums.count {
            if nums[j] == target - nums[i] {
                return [i, j]
            }
        }
    }
    return [0]
}

print(sum([2, 5, 9, 7, 11, 15], 20))

// 方法二：哈希表
func sum2(_ nums: [Int], _ target: Int) -> [Int] {
    var targetDict:[Int: Int] = [:]
    for i in 0 ..< nums.count {
        if let value = targetDict[target - nums[i]] {
            return [value, i]
        }
        targetDict[nums[i]] = i
    }
    return [0]
}

print(sum([2, 5, 9, 7, 11, 15], 20))

//: [Next](@next)

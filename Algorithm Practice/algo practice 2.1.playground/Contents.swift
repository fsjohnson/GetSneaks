//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/* question: 
 
 Given two binary strings, return their sum (also a binary string).
 
 For example,
 a = "11"
 b = "1"
 Return "100".
 
 */

//class Solution {
//    func addBinary(_ a: String, _ b: String) -> String {
//        var aArrayValue = Int()
//        var bArrayValue = Int()
//        
//        let aArray = convertStringToArray(string: a)
//        let bArray = convertStringToArray(string: b)
//        
//        if aArray.count == 1 {
//            aArrayValue = 1
//        } else if aArray.count == 1 && aArray[0] == "0" {
//            aArrayValue = 0
//        } else {
//            let doubleCount = Double(aArray.count)
//            aArrayValue = Int(pow(2, doubleCount) - 1.0)
//        }
//        
//        if bArray.count == 1 {
//            bArrayValue = 1
//        } else if bArray.count == 1 && bArray[0] == "0" {
//            bArrayValue = 0
//        } else {
//            let doubleCount = Double(bArray.count)
//            bArrayValue = Int(pow(2, doubleCount) - 1.0)
//        }
//        
//        let sum = aArrayValue + bArrayValue
//        return convertSumToBinaryString(sum: sum)
//    }
//    
//    func convertStringToArray(string: String) -> [String] {
//        var stringArray = [String]()
//        for letter in string.characters {
//            let stringLetter = String(letter)
//            stringArray.append(stringLetter)
//        }
//        return stringArray
//    }
//    
//    func convertSumToBinaryString(sum: Int) -> String {
//        var finalToReturn = String()
//        let binaryDict = [
//            0: "0",
//            1: "1",
//            2: "10",
//            3: "11",
//            4: "100",
//            5: "101",
//            6: "110",
//            7: "111",
//            8: "1000",
//            9: "1001",
//            10: "1010"
//        ]
//        
//        for num in 0..<binaryDict.count {
//            if num == sum {
//                finalToReturn = binaryDict[num]!
//            }
//        }
//        return finalToReturn
//    }
//}
//
//var solution = Solution()
//solution.addBinary("11", "1")
//solution.addBinary("1", "1")



class SecondSolution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var originalArray = nums
        var indecesToReturn = [Int]()

        for i in 0..<originalArray.count {
            guard let firstNum = originalArray.first else { return [0] }
            if firstNum + originalArray[i+1] == target {
                let secondIndex = i + 1
                indecesToReturn = [0,secondIndex]
            } else {
                originalArray.remove(at: 0)
            }
        }
        
        return indecesToReturn
    }
}

var second = SecondSolution()
second.twoSum([1,3,4], 4)





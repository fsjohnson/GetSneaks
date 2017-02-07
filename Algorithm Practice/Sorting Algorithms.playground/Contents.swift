//: Playground - noun: a place where people can play

import UIKit

// Quicksort

var list = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]

func quicksort<T: Comparable> (a:[T]) -> [T] {
    if a.count < 1 {
        return a
    } else {
        let cutInHalf = a[a.count/2]
        let less = a.filter({ (firstNum) -> Bool in
            firstNum < cutInHalf
        })
        let greater = a.filter({ (firstNum) -> Bool in
            firstNum > cutInHalf
        })
        let equal = a.filter({ (firstNum) -> Bool in
            firstNum == cutInHalf
        })
        
        return quicksort(a: less) + equal + quicksort(a: greater)
    }
}

//print(quicksort(a: list))

/////////////////////////////////////////////////////////////////////////

// Insertion Sort 
func insertionSort(nums: inout [Int]) {
    
    for num in 1..<nums.count {
        var y = num
        while y > 0 && nums[y] < nums[y-1] {
            var temp = nums[y]
            while y > 0 && temp < nums[y-1] {
                nums[y] = nums[y-1]
                y -= 1
            }
            nums[y] = temp
            
            print(nums)
        }
    }
}

/////////////////////////////////////////////////////////////////////////


/* QUESTION:

Given an unsorted array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

Example:
(1) Given nums = [1, 5, 1, 1, 6, 4], one possible answer is [1, 4, 1, 5, 1, 6].
(2) Given nums = [1, 3, 2, 2, 3, 1], one possible answer is [2, 3, 1, 3, 1, 2].
*/



let test = "HELlo to tS**he worl23d ++ %@"

let stuff = test.unicodeScalars.split { letter in
    
    print(letter)
    
    return !CharacterSet.alphanumerics.contains(letter)
    
}.map(String.init)

print(stuff)



func wiggleSort(nums: [Int]) -> [Int] {
    
    let sortedNumbers = nums.sorted(by: <)
    
    print(nums)
    
    var result: [Int] = []
    
    var firstHalf = sortedNumbers[0..<(sortedNumbers.count / 2)]
    var secondHalf = sortedNumbers[(sortedNumbers.count / 2)..<sortedNumbers.count]
    
    print(firstHalf)
    print(secondHalf)
    
    while !firstHalf.isEmpty && !secondHalf.isEmpty {
        
        print("in while loop.")
        
        let first: Int? = firstHalf.isEmpty ? nil : firstHalf.removeFirst()
        print(first)
        let otherFirst: Int? = secondHalf.isEmpty ? nil : secondHalf.removeFirst()
        print(otherFirst)
        
        if first != nil { result.append(first!) }
        if otherFirst != nil { result.append(otherFirst!) }
        
        
        
    }
    
return result
    
    
    
//    
//    let halfOfNums = nums[nums.count/2]
//    var lowerBound = Set<Int>()
//    var upperBound = Set<Int>()
//    
//    
//    
//    
//    
//    
//    for num in nums {
//        if num < halfOfNums {
//            lowerBound.insert(num)
//
//        } else {
//            upperBound.insert(num)
//        }
//    }
//    
//    lowerBound.map { (firstNum) -> Int in
//        
//    }
}




print(wiggleSort(nums: list))

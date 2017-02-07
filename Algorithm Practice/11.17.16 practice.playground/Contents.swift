//: Playground - noun: a place where people can play

import UIKit

/*
Reverse digits of an integer given as an array of ints.
Example1: x = [1,2,3], return [3,2,1]
Example2: x = [-1,2,3], return [-3,2,1]
*/


let numArray = [-1,-2,3,4,5]

// MY EFFORT:

func reverseArray(numArray: [Int]) -> [Int] {
    var finalArray = [Int]()
    
    var reversedArray = Array(numArray.reversed())
    print(reversedArray)
    for (index,value) in numArray.enumerated() {
        
        if value < 0 {
            var valueToAdd = reversedArray[index]
            valueToAdd *= -1
            finalArray.append(valueToAdd)
        } else {
            finalArray.append(value)
        }

    }
    return finalArray
}

print(reverseArray(numArray: numArray))

// SOLUTION:

func reverse(array: [Int]) -> [Int] {
    
    var result = array.reversed().map { number in
        
        return number < 0 ? number * -1 : number
        
    }
    
    for (index, number) in array.enumerated() {
        
        if number < 0 {
            
            var newNumber = result[index]
            
            newNumber *= -1
            
            result[index] = newNumber
            
        }
        
    }
    
    return result
}


//: Playground - noun: a place where people can play

import UIKit

// QUESTION:

/*
Given an array of non-empty strings, write a method that creates a dictionary where for each string in the array, there is a key for the first letter associated with a value for the last letter.
Sample input: ["rich", "mahogany", "many", "leather", "bound"]
Sample output: {"r" : "h", "m" : "y", "l" : "r", "b" : "d"}
*/

let providedArray =  ["rich", "mahogany", "many", "leather", "bound"]

////////// CORRECT SOLUTION:


func createDictionary(stringArray: [String]) -> [String:String]{
    var dict = [String:String]()
    for str in stringArray {
        let arrayChar = str.characters
        if let firstChar = arrayChar.first, let lastChar = arrayChar.last {
            dict["\(firstChar)"] = "\(lastChar)"
        }
    }
    return dict
}

print(createDictionary(stringArray: providedArray))


///////////////// MY SOLUTION:
var finalDictionary = [String: String]()
var finalArray = [[String:String]]()


func createDictionary(with providedArray: [String]) -> [String: String] {
    for word in providedArray {
        
        let wordString = word.characters
        
        
        let firstLetter = String(wordString.first!)
        let lastLetter = String(wordString.last!)

        finalDictionary[firstLetter] = lastLetter
    }
    
    
    return finalDictionary
}

print(createDictionary(with: providedArray))





//////// Write a method that returns an array containing every prime number up to 1000.


let numToDivide = [2,3,4,5,6,7,8,9,10]
var primeArray = [Int]()


func generatePrimeArray(num: Int) -> [Int] {
    for i in 2...100 {
        if i <= 3 {
            primeArray.append(i)
        } else {
            var isPrime = true
            for num in primeArray {
                if i % num == 0 {
                    isPrime = false
                    break
                }
            }
            if isPrime {
                primeArray.append(i)
            }
            
            
        }
    }
    
    return primeArray
    
}




print(generatePrimeArray(num: 10))



/////////////////////////////////////////////

/*
 Reverse digits of an integer given as an array of ints.
 Example1: x = [1,2,3], return [3,2,1]
 Example2: x = [-1,2,3], return [-3,2,1]
 */



let numArrayTest = [-1,-2,3,4,5,6]

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
    print(finalArray)
    return finalArray
}

print("NUMARRAY: \(reverseArray(numArray: numArrayTest))")



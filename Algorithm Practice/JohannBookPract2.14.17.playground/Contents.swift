//: Playground - noun: a place where people can play

import UIKit

// Sort an array of numbers:
var nums = [13,7,32,1,24,5,6]

func sortNums(array: inout [Int]) {
    for i in 0..<array.count {
        for j in i..<array.count {
            if array[i] > array[j] {
                let temp = array[i]
                array[i] = array[j]
                array[j] = temp
            }
        }
    }
}
sortNums(array: &nums)

// Are the letters unique: 
var letters = "hello"

func checkIfUnique(letters: String) -> Bool {
    var arrayToFill = [Character]()
    
    for letter in letters.characters {
        if arrayToFill.contains(letter) {
            return false
        }
        arrayToFill.append(letter)
    }
    
    return true
}

checkIfUnique(letters: letters)

func secondCheck(letters: String) -> Bool {
    return Set(letters.characters).count == letters.characters.count
}

secondCheck(letters: letters)

// Is a string a palindrome:
var rotator = "rotator"
var neverOdd = "Never odd or even"
var helloWorld = "Hello, world"

func isPalindrome(word: String) -> Bool {
    var wordChar = word.characters
    var array = [Character]()
    var finalWord = String()
    
    for c in wordChar {
        array.append(c)
    }
    
    for i in 0...array.count-1 {
        let last = array[array.count - i - 1]
        finalWord.append(last)
    }
    
    if finalWord == word {
        return true
    }
    return false
}

isPalindrome(word: helloWorld)
isPalindrome(word: rotator)

// Do two strings contain the same characters?
func containSameCharacters(stringOne: String, stringTwo: String) -> Bool {
    for c in stringOne.characters {
        if stringTwo.characters.contains(c) {
            return true
        }
    }
    return false
}

containSameCharacters(stringOne: "a1 b2", stringTwo: "b 1 a 2")
containSameCharacters(stringOne: "abc", stringTwo: "abca")

func containSameCharVTwo(stringOne: String, stringTwo: String) -> Bool {
    let array1 = Array(stringOne.characters)
    let array2 = Array(stringTwo.characters)
    return array1.sorted() == array2.sorted()
}

containSameCharVTwo(stringOne: "abc", stringTwo: "abca")
containSameCharVTwo(stringOne: "a 1 b 2", stringTwo: "b 1 a 2")

// Does one string contain another?
extension String {
    func doesContain(_ string: String) -> Bool {
        return self.uppercased().range(of: string.uppercased()) != nil
    }
}

// Generate random number in a range
func randomNumInRange(min: Int, max: Int) -> Int {
    let array = Array(min...max)
    var numToReturn = Int()
    
    return array[Int(arc4random_uniform(UInt32(array.count)))]
}

randomNumInRange(min: 6, max: 9)

// Recreate the pow() func:
func recreatePow(num: Int, power: Int) -> Int {
    var returnValue = num
    
    if num < 0 {
        num * -1
    }

    for _ in 1..<power {
        returnValue *= num
    }
    return returnValue
}

recreatePow(num: 4, power: 3)
recreatePow(num: 2, power: 8)

// Swap two numbers: 
func swapNums(numOne: Int, numTwo: Int) -> (Int,Int) {
    var a = numOne
    var b = numTwo
    let temp = a
    a = b
    b = temp
    return (a, b)
}

swapNums(numOne: 1, numTwo: 2)

// Number is prime: 
func isPrime(num: Int) -> Bool {

    if num == 0 || num == 1 {
        return true
    } else if num % 2 == 0 {
        return false
    }
    return true
}

isPrime(num: 1)
isPrime(num: 4)
isPrime(num: 9)
isPrime(num: 16777259)
isPrime(num: 13)

// Sum the elements of an array of number 2 by 2. ie. input = [1,2,6,3,4,5] output = [3,9,9]

func sumNums(givenArray: [Int]) -> [Int] {
    var newArray = givenArray
    var arrayIntReturn = [Int]()
    let amountToSubtract = newArray.count / 2
    
    for num in 0..<newArray.count - amountToSubtract {
        let newNum = newArray[num] + newArray[num + 1]
        arrayIntReturn.append(newNum)
        newArray.remove(at: num)
    }
    return arrayIntReturn
}

sumNums(givenArray: [1,3,4,6,3,5])
sumNums(givenArray: [1,3,4,6])
sumNums(givenArray: [1,3,4,6,7,12])

// Count the characters: 
func countCharacters(letter: Character, word: String) -> Int {
    var letterCount = 0
    
    for l in word.characters {
        if letter == l {
            letterCount += 1
        }
    }
    
    return letterCount
}

countCharacters(letter: "a", word: "The rain in spain")
countCharacters(letter: "i", word: "Mississippi")
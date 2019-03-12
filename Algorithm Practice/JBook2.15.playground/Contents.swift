//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Remove duplicates from string
func removeDupes(word: String) -> String {
    var char = [Character]()
    var finalWord = String()
    
    for l in word.characters {
        if !char.contains(l) {
            finalWord.append(l)
            char.append(l)
        }
    }
    return finalWord
}

removeDupes(word: "hello")
removeDupes(word: "wombat")
removeDupes(word: "Mississippi")

// Condense white space:
func condenseSpace(sent: String) -> String{
    var finalSent = [String]()
    var components = sent.components(separatedBy: .whitespacesAndNewlines)
    for item in 0...components.count - 1 {
        if components[item] != "" {
            finalSent.append(components[item])
        }
    }
    
    return finalSent.joined(separator: " ")
}

condenseSpace(sent: " Hey    are you    ok")
condenseSpace(sent: "a        bc      d")
condenseSpace(sent: "a        b c      d")
condenseSpace(sent: "abcd")

// String is rotated: 
func rotateString(word: String, rotatedBy: Int) -> String {
    var wordArray = Array(word.characters)
    var finalWord = String()
    var leftWord = String()
    
    for i in 0..<wordArray.count {
        if i <= rotatedBy {
            finalWord.append(wordArray[i])
            print(finalWord)
        } else {
            leftWord.append(wordArray[i])
        }
    }
    return leftWord + finalWord
}

rotateString(word: "Swift", rotatedBy: 2)

// Find pangrams: 
func findPangrams(sent: String) -> Bool {
    let components = sent.replacingOccurrences(of: " ", with: "").lowercased()
    var charSet = Set<Character>()
    
    for c in components.characters {
        charSet.insert(c)
    }
    
    if charSet.count == 26 {
        return true
    }
    return false
}

findPangrams(sent: "The quick brown fox jumped over the lazy dog")
findPangrams(sent: "The quick brown fox jumps over the lazy dog")

// Given a string, return a tuple containing the num of vowels & consonants 
func returnVowelAndConsonantCount(word: String) -> (Int, Int) {
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    let consonantSet = CharacterSet(charactersIn: "bcdfghjklmnpqrstvwxyz")

    var vowelCount = 0
    var consonantCount = 0
    
    for c in word.lowercased().characters {
        let cString = String(c)
        if (cString.rangeOfCharacter(from: vowelSet) != nil) {
            vowelCount += 1
        } else if (cString.rangeOfCharacter(from: consonantSet) != nil) {
            consonantCount += 1
        }
    }
    return (vowelCount, consonantCount)
}

returnVowelAndConsonantCount(word: "Swift Coding Challenges")
returnVowelAndConsonantCount(word: "Mississippi")

// Counting binary ones: 
func countBinary(num: Int) -> Int {
    var valueToReturn = 0
    
    let dict = [
        0: 0,
        1: 1,
        2: 10,
        3: 11,
        4: 100,
        5: 101,
        6: 110,
        7: 111,
        8: 1000,
        9: 1001,
        10: 1010
    ]
    
    for item in dict.keys {
        if item == num {
            guard let value = dict[item] else { return 0 }
            valueToReturn += value
        }
    }
    return valueToReturn
}

countBinary(num: 3)


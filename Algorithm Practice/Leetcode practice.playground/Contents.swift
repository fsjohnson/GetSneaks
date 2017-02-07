//: Playground - noun: a place where people can play

import UIKit


// Given a string, find the length of the longest substring without repeating characters.
// https://leetcode.com/articles/longest-substring-without-repeating-characters/

class Solution {
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var newArray: [String] = []
        var longest = 0
            for c in s.characters {
                if !newArray.contains(String(c)) {
                    newArray.append(String(c))
                    print(newArray)
                } else {
                    longest = max(longest, newArray.count)
                    print("longest inside func \(longest)")
                    newArray = [String(c)]
                    
                }
            
            longest = max(longest, newArray.count)
            
        }
        return longest
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

// SET, FILTER, REDUCE PRACTICE

let firstString = "abbhd"
let secondString = "andbh"
var newSecondArray: [Character] = []

var stringSet = Set<Character>()
var secondStringSet = Set<Character>()


for c in firstString.characters {
    if !stringSet.contains(c) {
        stringSet.insert(c)
    } else {
        
    }
    
}

for c in secondString.characters {
    secondStringSet.insert(c)
}

//let result = stringSet.intersection(secondStringSet)
//print(result)

let result = stringSet.symmetricDifference(secondStringSet)
print(result)


print(stringSet.sorted())
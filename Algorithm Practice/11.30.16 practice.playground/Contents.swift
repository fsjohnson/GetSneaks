//: Playground - noun: a place where people can play

import UIKit


/*
Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).


For example, this binary tree `[1,2,2,3,4,4,3]` is symmetric:
```    1
/ \
2   2
/ \ / \
3  4 4  3
```


But the following `[1,2,2,nil,3,nil,3]` is not:
```    1
/ \
2   2
\   \
3    3
```

*/

// SOLUTION: 

func isSymmetrical(nodes: [Int?]) -> Bool {
    
    guard nodes.count % 2 != 0 else {return false}
    
    var theNodes = nodes
    
    theNodes.removeFirst()
    
    var slice = 2
    
    while !theNodes.isEmpty {
        
        if slice > theNodes.count { return false }
        
        var arraySlice = theNodes[0..<slice]
        
        theNodes.removeSubrange(0..<slice)
        
        while !arraySlice.isEmpty {
            let first = arraySlice.removeFirst()
            let last = arraySlice.removeLast()
            if first != last { return false }
        }
        
        slice *= 2
    }
    
    return true
    
}
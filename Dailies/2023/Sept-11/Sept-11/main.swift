//
//  main.swift
//  Sept-11
//
//  Created by Christopher Sorenson on 9/11/23.
//

import Foundation


class Solution {
    
    
    func groupThePeople(_ groupSizes: [Int]) -> [[Int]] {
    
        let indexedGroups = groupSizes.enumerated()
        var groupDict = Dictionary<Int,[Int]>()
        
        for (index,groupSize) in indexedGroups {
            if groupDict.contains(where: {$0.key == groupSize}) {
                groupDict[groupSize]!.append(index)
            }
            else {
                groupDict.updateValue([index], forKey: groupSize)
            }
        }
        
        var toReturn = Array<Array<Int>>()
        for (groupSize, groupIndexes) in groupDict {
            var mutGroupIndexes = groupIndexes
            while !mutGroupIndexes.isEmpty {
                let nextSubGroup = Array(mutGroupIndexes.prefix(groupSize))
                mutGroupIndexes = Array(mutGroupIndexes.dropFirst(groupSize))
                toReturn.append(nextSubGroup)
            }
        }
        
        return toReturn
    }
}

print("Hello, World!")


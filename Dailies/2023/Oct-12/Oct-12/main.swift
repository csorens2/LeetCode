//
//  main.swift
//  Oct-12
//
//  Created by Christopher Sorenson on 10/12/23.
//

import Foundation

protocol MountainArray {
    func get (_ index: Int) -> Int
    func length() -> Int
}

class MountainArrayImpl : MountainArray {
    
    let mountainArray: Array<Int>

    var usageCount: Int
    
    init(initialArray array: Array<Int>) {
        mountainArray = array
        usageCount = 0
    }
    
    func get (_ index: Int) -> Int {
        if usageCount >= 100 {
            print("Usage reached")
        }
        else {
            usageCount = usageCount + 1
        }
        
        return mountainArray[index]
    }
    
    func length() -> Int {
        return mountainArray.count
    }
}

class CachedMountainArray {
    var indexDict: Dictionary<Int, Int>
    let mountainArray: MountainArray
    
    init(_ mArray: MountainArray) {
        mountainArray = mArray
        indexDict = [:]
    }
    
    func get(_ index: Int) -> Int {
        indexDict[index] = indexDict[index] == nil ? mountainArray.get(index) : indexDict[index]
        return indexDict[index]!
    }
    
    func length() -> Int {
        return mountainArray.length()
    }
}

enum MountainSide {
    case Left
    case Right
}

class Solution {
    
    func rec_findPeakIndex(
        _ cachedMountainArray: CachedMountainArray,
        _ leftBoundIndex: Int,
        _ rightBoundIndex: Int) -> Int
    {
        if leftBoundIndex == rightBoundIndex {
            return leftBoundIndex
        }
        else {
            let midIndex = leftBoundIndex + ((rightBoundIndex - leftBoundIndex) / 2)
            if cachedMountainArray.get(midIndex) < cachedMountainArray.get(midIndex + 1) {
                return rec_findPeakIndex(cachedMountainArray, midIndex + 1, rightBoundIndex)
            }
            else {
                return rec_findPeakIndex(cachedMountainArray, leftBoundIndex, midIndex)
            }
        }
    }
    
    func rec_findNumIndex(
        _ cachedMountainArray: CachedMountainArray,
        _ targetNum: Int,
        _ leftBoundIndex: Int,
        _ rightBoundIndex: Int,
        _ mountainSide: MountainSide) -> Int {
            
        if leftBoundIndex == rightBoundIndex {
            return
                cachedMountainArray.get(leftBoundIndex) == targetNum ?
                    leftBoundIndex :
                    -1
        }
        else {
            let midIndex = (leftBoundIndex + rightBoundIndex) / 2
            let midVal = cachedMountainArray.get(midIndex)
            
            switch mountainSide {
            case .Left:
                if targetNum <= midVal {
                    return rec_findNumIndex(cachedMountainArray, targetNum, leftBoundIndex, midIndex, mountainSide)
                }
                else {
                    return rec_findNumIndex(cachedMountainArray, targetNum, midIndex + 1, rightBoundIndex, mountainSide)
                }
            case .Right:
                if midVal > targetNum {
                    return rec_findNumIndex(cachedMountainArray, targetNum, midIndex + 1, rightBoundIndex, mountainSide)
                }
                else {
                    return rec_findNumIndex(cachedMountainArray, targetNum, leftBoundIndex, midIndex, mountainSide)
                }
            }
        }
    }
    
    func findInMountainArray(_ target: Int, _ mountainArr: MountainArray) -> Int {
        let cachedArray = CachedMountainArray(mountainArr)
        let maxIndex = rec_findPeakIndex(cachedArray, 0, mountainArr.length() - 1)
        var numIndex = rec_findNumIndex(cachedArray, target, 0, maxIndex, MountainSide.Left)
        if numIndex == -1 {
            numIndex = rec_findNumIndex(cachedArray, target, maxIndex , mountainArr.length() - 1, MountainSide.Right)
        }
        
        return numIndex
    }
}

print("Hello, World!")

let solution = Solution()
let mountainArray1 = MountainArrayImpl(initialArray: [1,2,3,4,5,3,1])
let mountainArray2 = MountainArrayImpl(initialArray: [0,1,2,4,2,1])
let mountainArray3 = MountainArrayImpl(initialArray: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,100,99,98,97,96,95,94,93,92,91,90,89,88,87,86,85,84,83,82])
let mountainArray4 = MountainArrayImpl(initialArray: [1,5,2])
let mountainArray5 = MountainArrayImpl(initialArray: [0,5,3,1])

typealias TestCase = (target: Int, mountainArray: MountainArray, expectedResult: Int)
let testCases: [TestCase] = [
    (3, mountainArray1, 2),
    (3, mountainArray2, -1),
    (101, mountainArray3, 100),
    (0, mountainArray4, -1),
    (3, mountainArray5, 2)
]

for testCase in testCases {
    let result = solution.findInMountainArray(testCase.target, testCase.mountainArray)
    print("Expected: '\(testCase.expectedResult)' actual '\(result)'")
}

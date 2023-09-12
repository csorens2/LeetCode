//
//  main.swift
//  Sept-8-2023
//
//  Created by Christopher Sorenson on 9/8/23.
//

import Foundation

class Solution {
    func generate(_ numRows: Int) -> [[Int]] {
        let baseRows = [[1],[1,1]]
        if numRows == 1 {
            return baseRows.dropLast(1)
        }
        if numRows == 2 {
            return baseRows;
        }
        
        return generateRec(rows: baseRows, remainingRows: numRows - 2)
    }
    
    func generateRec(rows: [[Int]], remainingRows: Int) -> [[Int]] {
        if remainingRows == 0 {
            return rows;
        }
        
        let lastRow = rows.last!
        let zeroedLastRow = [0] + lastRow + [0]
        let nextRow = generateRow(remainingRow: zeroedLastRow)
        
        return generateRec(rows: rows + [nextRow], remainingRows: remainingRows - 1)
    }
    
    
    func generateRow(remainingRow: [Int]) -> [Int] {
        let nextVal = remainingRow[0] + remainingRow[1];
        let nextRemaining = Array(remainingRow.dropFirst(1))
        if nextRemaining.count == 1 {
            return [nextVal];
        }
        else {
            return [nextVal] + generateRow(remainingRow: nextRemaining)
        }
    }
    
}

let testSolution = Solution()
let testArray = testSolution.generate(numRows: 5)

print("Hello, World!")

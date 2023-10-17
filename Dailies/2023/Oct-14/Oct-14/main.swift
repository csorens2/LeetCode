//
//  main.swift
//  Oct-14
//
//  Created by Christopher Sorenson on 10/16/23.
//

import Foundation

typealias JobDetails = (Time: Int, Cost: Int, CostPerHour: Double, SavingsWhenDoneFree: Double)
class Solution {
        
    func rec_completeJobs(_ remainingJobs: [JobDetails]) -> Int {
        if remainingJobs.isEmpty {
            return 0
        }
        else {
            var currRemainingJobs = remainingJobs
            
            
            
            /* Draft 1
            currRemainingJobs.sort { (jobDetail1, jobDetail2) -> Bool in
                if jobDetail1.SavingsWhenDoneFree != jobDetail2.SavingsWhenDoneFree {
                    return jobDetail1.SavingsWhenDoneFree > jobDetail2.SavingsWhenDoneFree
                }
                else if jobDetail1.Time != jobDetail2.Time {
                    return jobDetail1.Time < jobDetail2.Time
                }
                else {
                    return jobDetail1.Cost > jobDetail2.Cost
                }
            }

            let paidPainterJob = currRemainingJobs.popLast()!
            let nextRemainingJobs = Array(currRemainingJobs.dropFirst(paidPainterJob.Time))
            
            return paidPainterJob.Cost + rec_completeJobs(nextRemainingJobs)
            */
            
            
            /* Draft 0
            currRemainingJobs.sort { (jobDetail1, jobDetail2) -> Bool in
                return jobDetail1.CostPerHour > jobDetail2.CostPerHour
            }
            let paidPainterJob = currRemainingJobs.popLast()!
            
            currRemainingJobs.sort { (jobDetail1, jobDetail2) -> Bool in
                return jobDetail1.Cost < jobDetail2.Cost
            }
            let nextRemainingJobs = currRemainingJobs.dropLast(paidPainterJob.Time)
            
            return paidPainterJob.Cost + rec_completeJobs(Array(nextRemainingJobs))
            */
        }
    }
    
    func paintWalls(_ cost: [Int], _ time: [Int]) -> Int {
        let jobDetailArray: [JobDetails] =
            Array(zip(cost, time)).map { (jobCost, jobTime) in
                let costPerHour = Double(jobCost) / Double(jobTime)
                let jobDetail: JobDetails = (jobTime, jobCost, costPerHour, Double(jobCost) - costPerHour)
                return jobDetail
            }
        
        return rec_completeJobs(jobDetailArray)
    }
}

print("Hello, World!")

typealias TestCase = (costArray: [Int], timeArray: [Int], expected: Int)
let testCases: [TestCase] = [
    //([1,2,3,2], [1,2,3,2], 3),
    //([2,3,4,2], [1,1,1,1], 4),
    ([49,35,32,20,30,12,42], [1,1,2,2,1,1,2], 62),
]

let solution = Solution()
for testCase in testCases {
    let result = solution.paintWalls(testCase.costArray, testCase.timeArray)
    print("Expected: '\(testCase.expected)' actual '\(result)'")
}

let rec getNumBits remainingNum = 
    if remainingNum = 0 then
        0
    elif remainingNum % 2 = 1 then
        1 + (getNumBits (remainingNum - 1))
    else
        getNumBits (remainingNum / 2)


let solution intArray = 
    intArray
    |> List.map (fun num -> (num, getNumBits num))
    |> List.sortBy(fun (num, bitCount) -> bitCount, num)
    |> List.map (fun (num, _) -> num)

type TestCase = {
    TestData: int list
    ExpectedOutput: int list
}

let testCase1 = 
    {
        TestCase.TestData = [0;1;2;3;4;5;6;7;8]
        ExpectedOutput = [0;1;2;4;8;3;5;6;7]
    }

let testCase2 = 
    {
        TestCase.TestData = [1024;512;256;128;64;32;16;8;4;2;1]
        ExpectedOutput = [1;2;4;8;16;32;64;128;256;512;1024]
    }

let result1 = solution testCase1.TestData
let result2 = solution testCase2.TestData

List.iter (fun n -> printf "%d, " n) result1
printfn ""
List.iter (fun n -> printf "%d, " n) testCase1.ExpectedOutput
printfn ""
List.iter (fun n -> printf "%d, " n) result2
printfn ""
List.iter (fun n -> printf "%d, " n) testCase2.ExpectedOutput
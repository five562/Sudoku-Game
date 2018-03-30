//
//  Converter.swift
//  Sudoku
//
//  Created by Liyi Wu on 3/24/18.
//  Copyright © 2018 Liyi Wu. All rights reserved.
//

import Foundation

class Converter{

    func convertArrayToString(arr:[Int]) -> String{
        var str = ""
        for i in arr {
            str += String(i)
        }
        return str
    }
    
    func convertStringToArray(str:String) -> [Int]{
        var arr = [Int]()
        for i in str {
            arr.append(Int(String(i))!)
        }
        return [0]
    }
    
    func converSudokuArrayToSudokuGameDisplayedData(num:Int) -> (){
        var arrayIndex = Set<Int>()
        
        repeat {
            let random = Int(arc4random())
            let remainder = random % 81
            var randomIndex = Set<Int>()
            randomIndex.insert(remainder)
            let intersection = randomIndex.intersection(arrayIndex)
            if (intersection.count == 0){
                arrayIndex.insert(remainder)
            }
        }while (arrayIndex.count < num)
        
        for i in arrayIndex {
            sudokuGameDisplayedData[i] = 0
        }
        
    }
    
}

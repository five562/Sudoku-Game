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
}

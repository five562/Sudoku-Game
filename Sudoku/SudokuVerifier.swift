//
//  SudokuVerifier.swift
//  Sudoku
//
//  Created by Liyi Wu on 3/19/18.
//  Copyright © 2018 Liyi Wu. All rights reserved.
//

import Foundation

class SudokuVerifier {
    
    func verifyRowAndColumn(array:[Int]) -> Bool {
        var verifier = 0
        for i in 0...8{
            var rowSum = 0
            var columnSum = 0
            for j in 0...8{
                rowSum += array[i * 9 + j]
                columnSum += array[j * 9 + i]
            }
            if rowSum == 45 && columnSum == 45{
                verifier += 1
            }else{
                verifier += 0
            }
        }
        if verifier == 9{
            return true
        }else{
            return false
        }
        
    }
    
    
    func verifyBlock(array:[Int]) -> Bool {
        var verifier = 0
        for l in 0...2 {
            for k in 0...2 {
                var blockSum = 0
                for j in 0...2 {
                    for i in 0...2 {
                        blockSum += array[l * 27 + j * 9 + k * 3 + i]
                    }
                }
                if blockSum == 45 {
                    verifier += 1
                }else{
                    verifier += 0
                }
            }
        }
        if verifier == 9{
            return true
        }else{
            return false
        }
    }
    
    
}

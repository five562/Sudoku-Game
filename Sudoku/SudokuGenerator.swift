//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Liyi Wu on 3/19/18.
//  Copyright © 2018 Liyi Wu. All rights reserved.
//

import Foundation

let numberArray = [1,2,3,4,5,6,7,8,9]
var generatedSudoku = [[[[Int]]]]()
var sudokuArray = [Int]()
var sudokuGameDisplayedData = [Int]()

class SudokuGenerator {
    
    //Randomize the order of the elements of a given array
    func reorderNumberArray(array: [Int]) -> [Int]{
        var oldNumberArray = array
        var newNumberArray = [Int]()
        for i in 0...array.count-1{
            let n = Int(arc4random())
            let arrayIndex = n%(array.count-i)
            newNumberArray.append(oldNumberArray[arrayIndex])
            oldNumberArray.remove(at: arrayIndex)
        }
        return newNumberArray
    }
    
    //Generate the first 3x3 block in a sudoku
    func firstBlock(array:[Int]) -> [[Int]]{
        var numberArray = array
        var rownumber = [Int]()
        var block = [[Int]]()
        for i in 0...2{
            for j in 0...2{
                rownumber.append(numberArray[3*i+j])
            }
            block.append(rownumber)
            rownumber = []
        }
        return block
    }
    
    //Generate the entire sudoku
    func generateSudoku(firstBlock:[[Int]]) -> [[[[Int]]]]{
        var sudoku = [[[[Int]]]]()
        var sudokuRow = [[[Int]]]()
        var rblock = firstBlock
        //Generate first 3 rows
        var controlTerm = rblock[0][0]
        sudokuRow.append(rblock)
        for _ in 0...1{
            if controlTerm%2 == 0 {
                rblock[0] = reorderNumberArray(array: firstBlock[1])
                rblock[1] = reorderNumberArray(array: firstBlock[2])
                rblock[2] = reorderNumberArray(array: firstBlock[0])
            }else{
                rblock[0] = reorderNumberArray(array: firstBlock[2])
                rblock[1] = reorderNumberArray(array: firstBlock[0])
                rblock[2] = reorderNumberArray(array: firstBlock[1])
            }
            controlTerm += 1
            sudokuRow.append(rblock)
        }
        
        func generateColumnBlocks(rowBlock:[[Int]]) -> [[[Int]]]{
            //Generate first 3 columns
            var sudokuColumn = [[[Int]]]()
            var getColumn0 = [Int]()
            var getColumn1 = [Int]()
            var getColumn2 = [Int]()
            for i in 0...2{
                getColumn0.append(rowBlock[i][0])
                getColumn1.append(rowBlock[i][1])
                getColumn2.append(rowBlock[i][2])
            }
            var cblock = rowBlock
            controlTerm = cblock[2][2]
            for _ in 0...1{
                if controlTerm%2 == 0 {
                    for i in 0...2{
                        cblock[i][0] = getColumn1[i]
                        cblock[i][1] = getColumn2[i]
                        cblock[i][2] = getColumn0[i]
                    }
                }else{
                    for i in 0...2{
                        cblock[i][0] = getColumn2[i]
                        cblock[i][1] = getColumn0[i]
                        cblock[i][2] = getColumn1[i]
                    }
                }
                controlTerm += 1
                sudokuColumn.append(cblock)
            }
            return sudokuColumn
        }
        
        let sudokuColumn0 = generateColumnBlocks(rowBlock: sudokuRow[0])
        let sudokuColumn1 = generateColumnBlocks(rowBlock: sudokuRow[1])
        let sudokuColumn2 = generateColumnBlocks(rowBlock: sudokuRow[2])
        let sudokuRow1 = [sudokuColumn0[0],sudokuColumn1[0],sudokuColumn2[0]]
        let sudokuRow2 = [sudokuColumn0[1],sudokuColumn1[1],sudokuColumn2[1]]
        sudoku = [sudokuRow,sudokuRow1,sudokuRow2]
        return sudoku
    }
    
    //Print sudoku in 9x9 format
    func printSudoku(sudoku:[[[[Int]]]]){
        for l in 0...2{
            for k in 0...2{
                for j in 0...2{
                    for i in 0...2{
                        sudokuArray.append(sudoku[l][j][k][i])
                        sudokuGameDisplayedData.append(sudoku[l][j][k][i])
                        print(sudoku[l][j][k][i],terminator:" ")}
                }
                print(" ")
            }
        }
    }
    
    //Allow to swap the columns in sudoku with random order
    func swapColumns(sudoku:[[[[Int]]]])-> [[[[Int]]]]{
        let columnSwapOrder0 = reorderNumberArray(array: [0,1,2])
        var transSudoku = sudoku
        for l in 0...2{
            for k in 0...2{
                for i in columnSwapOrder0{
                    for j in 0...2{
                        transSudoku[k][l][j][i] = sudoku[k][l][j][columnSwapOrder0[i]]
                    }
                }
            }
        }
        return transSudoku
    }
    
    //Allow to swap the rows in sudoku with random order
    func swapRows(sudoku:[[[[Int]]]])->[[[[Int]]]]{
        let rowSwapOrder0 = reorderNumberArray(array: [0,1,2])
        var transSudoku = sudoku
        for l in 0...2 {
            for j in rowSwapOrder0{
                for i in 0...2{
                    transSudoku[l][i][j] = sudoku[l][i][rowSwapOrder0[j]]
                }
            }
        }
        return transSudoku
    }
    
    
}

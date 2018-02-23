//
//  ViewController.swift
//  Sudoku
//
//  Created by Liyi Wu on 2/17/18.
//  Copyright © 2018 Liyi Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let numberArray = [1,2,3,4,5,6,7,8,9]
    
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
    
    func printSudoku(sudoku:[[[[Int]]]]){
        for l in 0...2{
            for k in 0...2{
                for j in 0...2{
                    for i in 0...2{
                        print(sudoku[l][j][k][i],terminator:" ")}
                }
                print(" ")
            }
        }
    }
    
    func swapColumns(sudoku:[[[[Int]]]])-> [[[[Int]]]]{
        let columnSwapOrder0 = reorderNumberArray(array: [0,1,2])
        let columnSwapOrder1 = reorderNumberArray(array: [0,1,2])
        let columnSwapOrder2 = reorderNumberArray(array: [0,1,2])
        var transSudoku = sudoku
        for k in 0...2{
            for i in columnSwapOrder0{
                for j in 0...2{
                    transSudoku[k][0][j][i] = sudoku[k][0][j][columnSwapOrder0[i]]
                }
            }
        }
        for k in 0...2{
            for i in columnSwapOrder1{
                for j in 0...2{
                    transSudoku[k][1][j][i] = sudoku[k][1][j][columnSwapOrder1[i]]
                }
            }
        }
        for k in 0...2{
            for i in columnSwapOrder2{
                for j in 0...2{
                    transSudoku[k][2][j][i] = sudoku[k][2][j][columnSwapOrder2[i]]
                }
            }
        }
        return transSudoku
    }
    
    func swapRows(sudoku:[[[[Int]]]])->[[[[Int]]]]{
        let rowSwapOrder0 = reorderNumberArray(array: [0,1,2])
        let rowSwapOrder1 = reorderNumberArray(array: [0,1,2])
        let rowSwapOrder2 = reorderNumberArray(array: [0,1,2])
        var transSudoku = sudoku
        for j in rowSwapOrder0{
            for i in 0...2{
                transSudoku[0][i][j] = sudoku[0][i][rowSwapOrder0[j]]
            }
        }
        for j in rowSwapOrder1{
            for i in 0...2{
                transSudoku[1][i][j] = sudoku[1][i][rowSwapOrder0[j]]
            }
        }
        for j in rowSwapOrder2{
            for i in 0...2{
                transSudoku[2][i][j] = sudoku[2][i][rowSwapOrder0[j]]
            }
        }
        return transSudoku
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sudoku = generateSudoku(firstBlock: firstBlock(array: reorderNumberArray(array: numberArray)))
        printSudoku(sudoku: sudoku)
        print("")
        let swapSudoku = swapRows(sudoku: sudoku)
        printSudoku(sudoku: swapSudoku)
        print("")
        printSudoku(sudoku: swapColumns(sudoku: swapSudoku))
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


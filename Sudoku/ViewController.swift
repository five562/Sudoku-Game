//
//  ViewController.swift
//  Sudoku
//
//  Created by Liyi Wu on 2/17/18.
//  Copyright © 2018 Liyi Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let sudokuGenerator = SudokuGenerator()
    let sudokuVerifier = SudokuVerifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generatedSudoku = sudokuGenerator.generateSudoku(firstBlock: sudokuGenerator.firstBlock(array: sudokuGenerator.reorderNumberArray(array: numberArray)))
        let swapSudoku = sudokuGenerator.swapRows(sudoku: generatedSudoku)
        sudokuGenerator.printSudoku(sudoku: sudokuGenerator.swapColumns(sudoku: swapSudoku))
        
        while sudokuVerifier.verifyRowAndColumn(array: sudokuArray) == true {
            print("Good")
            break
        }
        
        while sudokuVerifier.verifyBlock(array: sudokuArray) == true {
            print("Good")
            break
        }
        
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


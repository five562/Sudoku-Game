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
    let converter = Converter()
    
    var sudokuTable:[SudokuTable]? = nil
    
    //Generate 81 labels
    func generateLabels(){
        for i in 0...80 {
            let labelText = String(sudokuArray[i])
            let label = UILabel()
            label.frame = CGRect(x:35 + i%9 * 35,y:80 + i/9 * 35,width:35,height:35)
            label.font = UIFont(name:"Avenir Next",size:25)
            label.text = labelText
            self.view.addSubview(label)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create labels
        //let label = UILabel(frame: CGRect(x:200,y:200,width:200,height:21))
        
        //label.text = "sudoku"
        //self.view.addSubview(label)
        
        
        
        generatedSudoku = sudokuGenerator.generateSudoku(firstBlock: sudokuGenerator.firstBlock(array: sudokuGenerator.reorderNumberArray(array: numberArray)))
        let swapSudoku = sudokuGenerator.swapRows(sudoku: generatedSudoku)
        sudokuGenerator.printSudoku(sudoku: sudokuGenerator.swapColumns(sudoku: swapSudoku))
        
        while sudokuVerifier.verify(array: sudokuArray) == true {
            print("Good")
            break
        }
        
        while sudokuVerifier.verify(array: sudokuArray) == false {
            print("Bad")
            break
        }
         
         generateLabels()
        
        
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


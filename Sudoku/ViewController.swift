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
    
    //var sudokuTable:[SudokuTable]? = nil
    
    //Generate 81 labels
    func generateLSudokuInterface(){
        
        converter.converSudokuArrayToSudokuGameDisplayedData(num: 55)
        
        for i in 0...80 {
            let labelText = String(sudokuGameDisplayedData[i])
            if labelText != "0" {
                let label = UILabel()
                label.frame = CGRect(x:10 + i%9 * 40,y:80 + i/9 * 40,width:38,height:38)
                label.font = UIFont(name:"Avenir Next",size:25)
                label.textAlignment = .center
                label.backgroundColor = UIColor.gray
                label.text = labelText
                self.view.addSubview(label)
            }else{
                let textField = UITextField()
                textField.frame = CGRect(x:10 + i%9 * 40,y:80 + i/9 * 40,width:38,height:38)
                textField.backgroundColor = UIColor.blue
                textField.textAlignment = .center
                self.view.addSubview(textField)
            }
            
        }
    }
    
    //Add 9 buttons from 1...9
    func generateButtons() {
        for i in 0...8 {
            let numButton = UIButton()
            numButton.frame = CGRect(x:10 + i * 40, y:550, width:38, height:38)
            numButton.backgroundColor = UIColor.brown
            numButton.setTitle(String(i), for: .normal)
            self.view.addSubview(numButton)
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
        
        generateLSudokuInterface()
        generateButtons()
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//
//  CoreDataHandler.swift
//  Sudoku
//
//  Created by Liyi Wu on 3/24/18.
//  Copyright © 2018 Liyi Wu. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    //Save object data to database
    class func saveObject(sudokuKey:String, sudokuGameData:String, sudokuUserEnter:String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "SudokuTable", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(sudokuKey, forKey: "sudokuKey")
        manageObject.setValue(sudokuGameData, forKey: "sudokuGameData")
        manageObject.setValue(sudokuUserEnter, forKey: "sudokuUserEntry")
        
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    
    //Fetch object data from database
    class func fetchObject() -> [SudokuTable]? {
        let context = getContext()
        var sudokuTable:[SudokuTable]? = nil
        do {
            sudokuTable = try context.fetch(SudokuTable.fetchRequest())
            return sudokuTable
        }catch {
            return sudokuTable
        }
    }
    
    //Delete sigle object
    class func deleteObject(sudokuTable: SudokuTable) -> Bool {
        let context = getContext()
        context.delete(sudokuTable)
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    //Delete whole data
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: SudokuTable.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }

}









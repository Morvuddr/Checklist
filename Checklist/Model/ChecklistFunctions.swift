//
//  ChecklistFunctions.swift
//  Checklist
//
//  Created by Игорь Бопп on 26/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ChecklistFunctions {
    
    
    static func createChecklistItem(_ checklistItem: ChecklistItem){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Checklist",
                                       in: managedContext)!
        
        let checklist = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
        
        checklist.setValue(checklistItem.title, forKeyPath: "title")
        checklist.setValue(checklistItem.date, forKeyPath: "date")
        checklist.setValue(checklistItem.additionalInfo, forKeyPath: "additionalInfo")
        checklist.setValue(checklistItem.checked, forKeyPath: "checked")
        
        do {
            try managedContext.save()
            Data.checklistItems.append(checklistItem)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func readChecklist(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Checklist")
        
        do {
            Data.checklistItemsCoreData = try managedContext.fetch(fetchRequest)
            for checklistItemCore in Data.checklistItemsCoreData {
                let title = checklistItemCore.value(forKeyPath: "title") as? String
                let date = checklistItemCore.value(forKeyPath: "date") as? String
                let additionalInfo = checklistItemCore.value(forKeyPath: "additionalInfo") as? String
                let checked = checklistItemCore.value(forKeyPath: "checked") as? Bool
                let checklistItem = ChecklistItem(title ?? "Ошибка",date ?? "Ошибка",additionalInfo ?? "Ошибка",checked ?? true)
                Data.checklistItems.append(checklistItem)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    static func updateChecklistItem(at index: Int, title: String, additionalInfo: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Checklist")
        
        do {
            
            Data.checklistItemsCoreData = try managedContext.fetch(fetchRequest)
            let checklistItemUpdate = Data.checklistItemsCoreData[index]
            checklistItemUpdate.setValue(title, forKeyPath: "title")
            checklistItemUpdate.setValue(additionalInfo, forKeyPath: "additionalInfo")
            
            do{
                
                try managedContext.save()
                Data.checklistItems[index].title = title
                Data.checklistItems[index].additionalInfo = additionalInfo
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    static func deleteChecklistItem(at index: Int){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Checklist")
        
        do {
            
            Data.checklistItemsCoreData = try managedContext.fetch(fetchRequest)
            let checklistItemDelete = Data.checklistItemsCoreData[index]
            managedContext.delete(checklistItemDelete)
            
            do{
                
                try managedContext.save()
                Data.checklistItems.remove(at: index)
                
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    static func toggleChecked(at index: Int){
        Data.checklistItems[index].checked = !Data.checklistItems[index].checked
    }
    
}

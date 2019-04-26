//
//  ChecklistFunctions.swift
//  Checklist
//
//  Created by Игорь Бопп on 26/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import Foundation

class ChecklistFunctions {
    
    static func createChecklistItem(_ checklistItem: ChecklistItem){
        Data.checklistItems.append(checklistItem)
    }
    
    static func readChecklist(){
        
    }
    
    static func updateChecklistItem(at index: Int, title: String){
        Data.checklistItems[index].title = title
    }
    
    static func deleteChecklistItem(at index: Int){
        Data.checklistItems.remove(at: index)
    }
    
    static func toggleChecked(at index: Int){
        Data.checklistItems[index].checked = !Data.checklistItems[index].checked
    }
    
}

//
//  TaskItem.swift
//  Checklist
//
//  Created by Игорь Бопп on 25/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    var title: String
    var checked: Bool
    
    init(_ title: String) {
        self.title = title
        self.checked = false
    }
    
}

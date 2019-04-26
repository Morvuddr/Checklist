//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Игорь Бопп on 25/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemTableViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemTableViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
    func addItemTableViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem)
}


class AddItemTableViewController: UITableViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var doneBarItem: UIBarButtonItem!
    
    var itemToEdit: ChecklistItem?
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let item = itemToEdit {
            title = "Edit Item"
            titleTextField.text = item.title
            doneBarItem.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addItemTableViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            let index = Data.checklistItems.firstIndex(of: itemToEdit)!
            ChecklistFunctions.updateChecklistItem(at: index, title: titleTextField.text!)
            delegate?.addItemTableViewController(self, didFinishEditing: itemToEdit)
            
        } else {
            let item = ChecklistItem(titleTextField.text!)
            delegate?.addItemTableViewController(self, didFinishAdding: item)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AddItemTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneBarItem.isEnabled = false
        } else {
            doneBarItem.isEnabled = true
        }
        return true
    }
    
}

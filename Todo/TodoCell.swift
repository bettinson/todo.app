//
//  TodoCell.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

protocol TodoCellDelegate: class {
    func didFinishEditing(sender: TodoCellDelegate, cell: TodoCell)
}

class TodoCell: UITableViewCell, UITextFieldDelegate {
    
    var currentTodo : Todo!
    weak var todoDelegate:TodoCellDelegate?
    weak var delegate:UITextFieldDelegate?
    
    
//    @IBAction func tappedNameField(sender: AnyObject) {
//        print("Tapped text field")
//        
//        nameField.userInteractionEnabled = true
//        nameField.becomeFirstResponder()
//    }
    
    @IBOutlet weak var nameField: UITextField!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameField.font = bodyFont
    }
    
    override func becomeFirstResponder() -> Bool {
        nameField.userInteractionEnabled = true
        nameField.delegate = self
        nameField.becomeFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print (currentTodo.name)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        todoDelegate?.didFinishEditing(self.todoDelegate!,cell: self)
//        currentTodo = nil
    }
    
}

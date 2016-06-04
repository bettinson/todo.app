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
        print("Cell became first responder")
        nameField.userInteractionEnabled = true
        nameField.delegate = self
        nameField.becomeFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("Text field should return")
        print (currentTodo.name)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print ("OH SHIT did end")
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print ("Oh shit did begin editing")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print ("ok")
        textField.resignFirstResponder()
        print ("Did end Editing")
        todoDelegate?.didFinishEditing(self.todoDelegate!,cell: self)
//        currentTodo = nil
    }
    
}

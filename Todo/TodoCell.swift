//
//  TodoCell.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell, UITextFieldDelegate {
    var currentTodo : Todo!
    
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
        print ("ok")
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
        textField.resignFirstResponder()
        print ("Did end Editing")
//        currentTodo = nil
    }
    
}

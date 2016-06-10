//
//  AddTodoViewController.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    var todoStore : TodoStore!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func done(sender: AnyObject) {
        finishAdding()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.barTintColor = Colours.greenColourHighlight
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        nameTextField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
   
    func finishAdding() {
        if (nameTextField.text) == "" {
            let title = "You can't have a blank todo"
            let message = "Please add some text."
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
            ac.addAction(okayAction)
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let todo = Todo(name: nameTextField.text!)
            todoStore.addTodo(todo)
            nameTextField.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: {})
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        finishAdding()
        return true
    }
}

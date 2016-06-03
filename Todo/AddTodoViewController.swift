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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        nameTextField.isFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        nameTextField.isFirstResponder()
    }
   
    func finishAdding() {
        let todo = Todo(name: nameTextField.text!)
        todoStore.addTodo(todo)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        finishAdding()
        return true
    }
}

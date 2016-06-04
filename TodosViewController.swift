//
//  TodosViewController.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class TodosViewController : UITableViewController, UITextFieldDelegate {
    var todoStore = TodoStore()
    private var currentTodo : Todo? = nil {
        didSet { print("Oh shit, we changed the todo") }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoStore.allTodos.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddTodo" {
            let nav = segue.destinationViewController as! UINavigationController
            let addTodoViewController = nav.topViewController as! AddTodoViewController
//            self.showViewController(addTodoViewController, sender: self)
            addTodoViewController.todoStore = todoStore
        }
    }
   
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! TodoCell
        cell.updateLabels()
        
        let todo = todoStore.allTodos[indexPath.row]
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TodosViewController.tappedTextField(_:)))
        
//        cell.addGestureRecognizer(tapRecognizer)
        cell.userInteractionEnabled = true
        cell.nameField.text = todo.name
        cell.nameField.delegate = self
        cell.nameField.userInteractionEnabled = false
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! TodoCell
        let todo = todoStore.allTodos[indexPath.row]
        
        cell.nameField.text = todo.name
        cell.nameField.userInteractionEnabled = true
        cell.currentTodo = todo
        cell.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("Text field should return")
        print ("\(currentTodo!.name) but in the view!")
        textField.resignFirstResponder()
        return true
    }
}
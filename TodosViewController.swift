//
//  TodosViewController.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit



class TodosViewController : UITableViewController, UITextFieldDelegate, TodoCellDelegate {
    
    var todoStore = TodoStore()
    
    private var currentTodo : Todo?
    private var currentIndex : Int?
    
    
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
   
    func didFinishEditing(sender: TodoCellDelegate, cell: TodoCell) {
        let newTodo = Todo(name: cell.nameField.text!)
        todoStore.changeTodo(newTodo, index: currentIndex!)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! TodoCell
        cell.updateLabels()
        
        let todo = todoStore.allTodos[indexPath.row]
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TodosViewController.tappedTextField(_:)))
        
//        cell.addGestureRecognizer(tapRecognizer)
        cell.userInteractionEnabled = true
        cell.nameField.text = todo.name
        cell.todoDelegate = self
        cell.nameField.userInteractionEnabled = false
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TodoCell
        let todo = todoStore.allTodos[indexPath.row]
        currentTodo = todo
        cell.nameField.text = todo.name
        cell.nameField.userInteractionEnabled = true
        cell.currentTodo = todo
        currentIndex = indexPath.row
        cell.becomeFirstResponder()
    }
}
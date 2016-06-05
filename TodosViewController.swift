//
//  TodosViewController.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit




class TodosViewController : UITableViewController, UITextFieldDelegate, TodoCellDelegate {
    @IBOutlet weak var clearTodosButton: UIBarButtonItem!

    var todoStore = TodoStore()
    
    private var currentTodo : Todo?
    private var currentIndex : Int?
    
    @IBAction func clearTodos(sender: AnyObject) {
//        tableView.beginUpdates()
        print(todoStore.allTodos.count)
        let count = todoStore.allTodos.count-1
       
        var indexPaths : [NSIndexPath]
        indexPaths = []
        
        for i in 0...todoStore.allTodos.count-1 {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            indexPaths.append(indexPath)
        }
        
        todoStore.allTodos = []
        
        self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Left)
        tableView.reloadData()
        
    }
    private var isEditing = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoStore.allTodos.count == 0 {
            clearTodosButton.enabled = false
        } else {
            clearTodosButton.enabled = true
        }
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
        isEditing = false
        clearTodosButton.enabled = true
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let todo = todoStore.allTodos[indexPath.row]
        
        let done = UITableViewRowAction(style: .Destructive, title: "Done",  handler: { (action, indexPath) in
            self.tableView.beginUpdates()
            self.todoStore.removeTodo(todo)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates()
            //Delete item
        })
        
        
        done.backgroundColor = UIColor(colorLiteralRed: 23.0/255, green: 190.0/255, blue: 52.0/255, alpha: 1)
        return [done]
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
        if isEditing == false {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! TodoCell
            let todo = todoStore.allTodos[indexPath.row]
            currentTodo = todo
            cell.nameField.text = todo.name
            cell.nameField.userInteractionEnabled = true
            cell.currentTodo = todo
            currentIndex = indexPath.row
            isEditing = true
            clearTodosButton.enabled = false
            cell.becomeFirstResponder()
        }
    }
}
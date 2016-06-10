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
    

    private var isEditing = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.barTintColor = Colours.greenColourHighlight
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        navigationController?.view.backgroundColor = UIColor.clearColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoStore.allTodos.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddTodo" {
            let nav = segue.destinationViewController as! UINavigationController
            let addTodoViewController = nav.topViewController as! AddTodoViewController
            addTodoViewController.todoStore = todoStore
        }
    }
   
    func didFinishEditing(sender: TodoCellDelegate, cell: TodoCell) {
        let newTodo = Todo(name: cell.nameField.text!)
        todoStore.changeTodo(newTodo, index: currentIndex!)
        isEditing = false
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
        
        
        done.backgroundColor = Colours.greenColour
        return [done]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! TodoCell
        cell.updateLabels()
        
        let todo = todoStore.allTodos[indexPath.row]

        cell.userInteractionEnabled = true
        cell.nameField.text = todo.name
        cell.todoDelegate = self
        cell.nameField.userInteractionEnabled = false
        return cell
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        todoStore.moveTodoAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
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
            cell.becomeFirstResponder()
        }
    }
}
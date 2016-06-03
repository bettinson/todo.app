//
//  TodosViewController.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class TodosViewController : UITableViewController {
    var todoStore = TodoStore()

    @IBAction func addTodo(sender: AnyObject) {
        let newTodo = todoStore.createTodo()
        if let index = todoStore.allTodos.indexOf(newTodo) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
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
        cell.nameLabel.text = todo.name
        
        return cell
    }
}
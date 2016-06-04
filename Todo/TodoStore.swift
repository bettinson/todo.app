//
//  TodoStore.swift
//  Todo
//
//  Created by Matt Bettinson on 2016-06-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import Foundation

class TodoStore {
    var allTodos: [Todo] = []

    let todoArchiveURL: NSURL = {
        let documentDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("todos.archive")
    }()
    
    init () {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(todoArchiveURL.path!) as? [Todo] {
            allTodos += archivedItems
        }
    }
    
    func moveTodoAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedTodo = allTodos[fromIndex]
        
        allTodos.removeAtIndex(fromIndex)
        allTodos.insert(movedTodo, atIndex: toIndex)
    }
    
    func changeTodo (todo: Todo, index: Int) {
        allTodos[index] = todo
    }
    
    func addTodo (todo: Todo) {
        allTodos.append(todo)
    }
    
    func removeTodo(todo: Todo) {
        print ("removing item")
        if let index = allTodos.indexOf(todo) {
            allTodos.removeAtIndex(index)
        }
    }
    
    func saveChanges() -> Bool {
        print("Saving items to \(todoArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allTodos, toFile: todoArchiveURL.path!)
    }
}
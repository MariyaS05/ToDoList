//
//  Storage.swift
//  ToDoList
//
//  Created by Мария  on 12.08.23.
//


import CoreData
import UIKit

class Storage {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllTasks() -> [ToDoListItem]{
        let fetchRequest = ToDoListItem.fetchRequest()
        do{
            return try  context.fetch(fetchRequest)
        }catch {
            return []
        }
    }
    func createTask(name: String,date: String,content: String,isCompleted : NSNumber){
        let newTask = ToDoListItem(context: context)
        newTask.name =  name
        newTask.date = date
        newTask.content =  content
        newTask.isCompleted = isCompleted
        do {
            try context.save()
        }catch{
        }
    }
    func deleteTask(task:ToDoListItem){
        context.delete(task)
        do {
            try context.save()
        }catch{
        }
    }
    func update(task: ToDoListItem,isCompleted: NSNumber){
        task.isCompleted  = isCompleted
        do {
            try context.save()
        }catch{
        }
        
    }
}

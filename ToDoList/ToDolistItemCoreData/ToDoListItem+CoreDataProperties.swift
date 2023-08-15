//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Мария  on 12.08.23.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var content: String?
    @NSManaged public var isCompleted:NSNumber?
  
}

extension ToDoListItem : Identifiable {

}


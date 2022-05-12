//
//  TodoListitem+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Gajender Jangir on 19/04/22.
//
//

import Foundation
import CoreData


extension TodoListitem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListitem> {
        return NSFetchRequest<TodoListitem>(entityName: "TodoListitem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?

}

extension TodoListitem : Identifiable {

}

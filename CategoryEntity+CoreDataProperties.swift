//
//  CategoryEntity+CoreDataProperties.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 17/01/2023.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?

}

extension CategoryEntity : Identifiable {

}

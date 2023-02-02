//
//  CategoryModel.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 17/01/2023.
//

import Foundation
import SwiftUI

class CategoryModel: BaseModel {
    
    static let shared = CategoryModel()
    
    
    
    func addCategory(name: String, type: RecordType){
        let typeString = type.rawValue
        let colorString = randomColor()
        let entity = CategoryEntity(context: context)
        entity.name = name
        entity.color = colorString
        entity.type = typeString
        do {
            try context.save()
        }catch{
            print("Fail to save category \(error.localizedDescription)")
        }
    }
    
    func removeCategory(category: CategoryEntity){
        context.delete(category)
        do{
            try context.save()
        }catch{
            print("Fail to remove category")
        }
    }
    
    func removeAllCategories(categories: FetchedResults<CategoryEntity>) {
        categories.forEach { entity in
            context.delete(entity)
            do{
                try context.save()
            } catch {
                print("Fail to remove all category")
            }
        }
    }

    func randomColor()->String{
        let red = Double(.random(in: 0.1...1.0))
        let green = Double(.random(in: 0.1...1.0))
        let blue = Double(.random(in: 0.1...1.0))
        return "\(red)-\(green)-\(blue)"
    }
    
    
    
}

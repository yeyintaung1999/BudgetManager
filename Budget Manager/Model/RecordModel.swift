//
//  RecordModel.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 18/01/2023.
//

import Foundation
import SwiftUI

class RecordModel: BaseModel {
    
    static let shared = RecordModel()
    
    let monthmodel = MonthlyModel.shared
    
    @FetchRequest(entity: MonthEntity.entity(), sortDescriptors: []) var months: FetchedResults<MonthEntity>
    
    func saveRecord(amount: Double, note: String, date: Date, category: CategoryEntity){
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM-yyyy"
//        let monthName = formatter.string(from: date)

//        var i = 0
//
//        months.forEach { month in
//            if month.name == monthName {
//                i+=1
//                let entity = RecordEntity(context: context)
//                entity.amount = amount
//                entity.date = date
//                entity.note = note
//                category.addToRecords(entity)
//
//                do{
//                    try context.save()
//                }catch{
//                    print("Fail to save record")
//                }
//            }
//        }
        

            
            monthmodel.saveMonth(date: date)
            
            let entity = RecordEntity(context: context)
            entity.amount = amount
            entity.date = date
            entity.note = note
            category.addToRecords(entity)

            do{
                try context.save()
            }catch{
                print("Fail to save record")
            }

        
    }
    
    func removeRecord(record: RecordEntity){
        context.delete(record)
        do{
            try context.save()
        } catch {
            print("Fail to Delete Record")
        }
    }
    
    func removeAllRecords(records: FetchedResults<RecordEntity>){
        records.forEach { entity in
            context.delete(entity)
            do{
                try context.save()
            } catch {
                print("Fail to delete all records")
            }
        }
    }
}

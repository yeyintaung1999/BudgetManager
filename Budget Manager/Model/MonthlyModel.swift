
import Foundation
import SwiftUI

class MonthlyModel: BaseModel {
    
    static let shared = MonthlyModel()
    
    func saveMonth(date: Date){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM-yyyy"
        let monthname = dateformatter.string(from: date)
        
        let entity = MonthEntity(context: context)
        entity.name = monthname
        entity.date = date
        
        do{
            try context.save()
        } catch {
            print("Fail to Save Month")
        }
        
    }
    
    func removeAllMonths(months: FetchedResults<MonthEntity>) {
        months.forEach { entity in
            context.delete(entity)
            do{
                try context.save()
            } catch {
                print("Fail to Delete all months")
            }
        }
    }
    
}

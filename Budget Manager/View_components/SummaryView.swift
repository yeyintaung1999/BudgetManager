

import SwiftUI

struct SummaryView: View {
    
    @FetchRequest(entity: RecordEntity.entity(), sortDescriptors: []) var records: FetchedResults<RecordEntity>
    
    var body: some View {
        VStack{
            Text("\(getTotal(income: getTotalIncome(records: records), expense: getTotalExpense(records: records))) \(signdefault.string(forKey: "sign") ?? "")")     //BALANCE
                .lineLimit(1)
                .font(.system(size: 28, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
            
                .padding(30)
            HStack(alignment: .bottom){
                Text("Income : ")
                    .font(.system(size: 14, weight: .light, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
                Text("+\(String(format: "%.2f", getTotalIncome(records: records)))  \(signdefault.string(forKey: "sign") ?? "")")     //INCOME
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(red: 0.6, green: 1.0, blue: 0.6))
            }
            .padding([.leading, .trailing], 20)
            .padding([.bottom],10)
            HStack(alignment: .bottom){
                Text("Expense : ")
                    .font(.system(size: 14, weight: .light, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
                Text("-\(String(format: "%.2f", getTotalExpense(records: records)))  \(signdefault.string(forKey: "sign") ?? "")")      //EXPENSE
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(.red)
            }
            .padding([.leading, .trailing], 20)
        }.padding([.bottom], 40)
    }
}

private func getTotal(income: Double, expense: Double)->String{
    let total = income - expense
    
    return String(format: "%.2f", total)
}

private func getTotalIncome(records: FetchedResults<RecordEntity>)->Double{
    var total = 0.00
    
    records.forEach { record in
        if record.category?.type == "income"{
            total = total+record.amount
        }
    }
    
    return total
}

private func getTotalExpense(records: FetchedResults<RecordEntity>)->Double{
    var total = 0.00
    
    records.forEach { record in
        if record.category?.type == "expense"{
            total = total+record.amount
        }
    }
    
    return total
}





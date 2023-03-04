import SwiftUI

struct StatsView: View {
    
    @State var incomeColor = UIColor(named: "ThemeColor")!
    @State var expenseColor = UIColor.systemGray
    @State var type: RecordType = .income
    
    var monthName: String = ""
    
    var selectedCategories: [CategoryEntity] = []
    
    @FetchRequest(entity: CategoryEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "%K=%@", "type", "expense"), animation: nil) var expensecategories: FetchedResults<CategoryEntity>
    
    @FetchRequest(entity: CategoryEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "%K=%@", "type", "income"), animation: nil) var incomecategories: FetchedResults<CategoryEntity>
    
    @FetchRequest(entity: CategoryEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var categories: FetchedResults<CategoryEntity>
    
    var body: some View {
        
        ScrollView{
            VStack{
                HStack(alignment: .center){
                    Text("Income")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 40)
                        .background(RoundedCorners(color: Color(uiColor: incomeColor), tl: 5, tr: 5, bl: 5, br: 5))
                        .onTapGesture {
                            incomeColor = UIColor(named: "ThemeColor")!
                            expenseColor = UIColor.lightGray
                            type = .income
                        }
                    Text("Expense")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 40)
                        .background(RoundedCorners(color: Color(uiColor: expenseColor), tl: 5, tr: 5, bl: 5, br: 5))
                        .onTapGesture {
                            incomeColor = UIColor.lightGray
                            expenseColor = UIColor(named: "ThemeColor")!
                            type = .expense
                        }
                }
                if type == .income {
                    PieChartView(
                        values: values(),
                        names: incomecategories.map({ $0.name ?? "" }),
                        formatter: { value in String(format: "%.2f", value) },
                        widthFraction: 0.80,
                        innerRadiusFraction: 0.6,
                        categories: incomecategories.map({
                            $0
                        })
                    )
                } else {
                    PieChartView(
                        values: values(),
                        names: expensecategories.map({ $0.name ?? "" }),
                        formatter: { value in String(format: "%.2f", value) },
                        widthFraction: 0.80,
                        innerRadiusFraction: 0.6,
                        categories: expensecategories.map({
                            $0
                        })
                    )
                }
            }.background(Color(uiColor: UIColor(named: "whiteDL")!))
                .padding([.top, .bottom], 20)
                .navigationTitle(monthName)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func getCategories()->[CategoryEntity]{
        var result: [CategoryEntity] = []
        
        categories.forEach { entity in
            if entity.type == type.rawValue {
                result.append(entity)
            }
        }
        
        return result
        
    }
    
    func values()->[Double]{
        var doubles: [Double] = []
        if type == .income {
            incomecategories.forEach { category in
                let records = category.records as? Set<RecordEntity>
                var total : Double = 0.0
                records?.forEach({ record in
                    if getMonthName(date: record.date!) == monthName {
                        total = total + record.amount
                    }

                })
                doubles.append(total)
            }
            return doubles
        } else {
            expensecategories.forEach { category in
                let records = category.records as? Set<RecordEntity>
                var total : Double = 0.0
                records?.forEach({ record in
                    if getMonthName(date: record.date!) == monthName {
                        total = total + record.amount
                    }
                })
                doubles.append(total)
            }
            return doubles
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}


func getMonthName(date: Date)->String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "MMM-yyyy"
    let monthname = dateformatter.string(from: date)
    return monthname
}



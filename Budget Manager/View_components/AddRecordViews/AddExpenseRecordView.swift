import SwiftUI

struct AddExpenseRecordView: View {
    
    let model = RecordModel.shared
    
    @FetchRequest(entity: CategoryEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "%K=%@", "type", "expense"), animation: nil) var categories: FetchedResults<CategoryEntity>
    
    @FetchRequest(entity: RecordEntity.entity(), sortDescriptors: []) var records: FetchedResults<RecordEntity>
    
    @Binding var isPresented: Bool
    
    @State var amount: String = ""
    @State var date: Date = Date()
    @State var category: String = "-"
    @State var note: String = ""
    
    @State var isPresentAddCategory: Bool = false
    @State var isPresentRemoveCategory: Bool = false
    @State var isErrorAlert: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                HStack{
                    Text("Total :")
                        .font(.system(size: 14, weight: .medium, design: .serif))
                        .foregroundColor(.secondary)
                    Text(getTotal())
                        .font(.system(size: 24, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                }
                VStack(alignment: .leading){
                    Text("Amount")
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                    TextField("Enter Amount", text: $amount).keyboardType(.numberPad)
                    Rectangle().border(.black, width: 1).frame(maxWidth: .infinity, maxHeight: 1)
                }
                
                    HStack(alignment: .center){
                        Text("Date -")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                            .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                    }
                    HStack(alignment: .center){
                        Text("Category -")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                            .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                        Spacer()
                        Picker("Choose", selection: $category, content: {
                            if choseCategories(categories: categories).count < 1 {
                                Text("-")
                            } else {
                                ForEach(choseCategories(categories: categories), id: \.self) { ele in
                                    Text(ele)
                                }
                            }

                        })
                        
                        .padding([.leading, .trailing], 10)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(.secondary))
                        Button {
                            isPresentAddCategory = true
                        } label: {
                            Image(systemName: "plus.circle").foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                        }
                        Button {
                            isPresentRemoveCategory = true
                        } label: {
                            Image(systemName: "minus.circle").foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                        }

                    }
                HStack(alignment: .top){
                    Text("Note -")
                    TextField("", text: $note)
                        .frame( height: 50)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(.secondary))
                }
                Spacer()
                Button {
                    if category == "-" || Double(amount) ?? 0 == 0.0 {
                        isErrorAlert = true
                    } else {
                        model.saveRecord(amount: Double(amount) ?? 0, note: note, date: date, category: getCategory(categories: categories, name: category))
                        isPresented = false
                    }
                    
                } label: {
                    Text("Done")
                }

            }
            .padding(20)
                .navigationBarItems(leading: Button(action: {
                    isPresented = false
                }, label: {
                    Text("Cancel")
                }))
                .navigationTitle("Add Expense")
                .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isPresentAddCategory) {
            AddCategoryView(type: .expense, isPresented: $isPresentAddCategory)
        }
        .sheet(isPresented: $isPresentRemoveCategory) {
            RemoveCategoryView(categoryList: categories, isPresenting: $isPresentRemoveCategory)
        }
        .alert("Required Amount & Category", isPresented: $isErrorAlert) {
            Button("OK") {
                isErrorAlert = false
            }
        }
    }
    
    func getTotal()->String {
        var total: Double = 0.00
        
        records.forEach { entity in
            if entity.category?.type == "expense" {
                total += entity.amount
            }
        }
        
        return "-\(total)"
    }
}

struct AddExpenseRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseRecordView(isPresented: .constant(true))
    }
}

private func choseCategories(categories: FetchedResults<CategoryEntity>)->[String]{
    var result: [String] = []
    result.append("-")
    categories.forEach { entity in
        result.append(entity.name ?? "")
    }
    return result
}




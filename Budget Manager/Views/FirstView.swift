

import SwiftUI

struct FirstView: View {
    @State var isPresentingAddIncomeRecordView: Bool = false
    @State var isPresentingAddExpenseRecordView: Bool = false
    
    @State var isAlertAddRecord: Bool = false
    var body: some View {
        ZStack{
            HomeListView()
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isAlertAddRecord = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                        .frame(width: 60, height: 60)
                        .background(Color(UIColor(named: "SecondaryColor")!))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(color: Color(UIColor(named: "SecondaryColor")!), radius: 5, x: 0, y: 0)
                        
                }
            }.padding(20)
        }

        .sheet(isPresented: $isPresentingAddIncomeRecordView){
            AddIncomeRecordView(isPresented: $isPresentingAddIncomeRecordView)
        }
        .sheet(isPresented: $isPresentingAddExpenseRecordView, content: {
            AddExpenseRecordView(isPresented: $isPresentingAddExpenseRecordView)
        })
        .alert("Income or Expense", isPresented: $isAlertAddRecord, actions: {
            Button {
                isPresentingAddIncomeRecordView = true
            } label: {
                Text("Add Income")
            }
            Button {
                isPresentingAddExpenseRecordView = true
            } label: {
                Text("Add Expense")
            }


        })
        

    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}

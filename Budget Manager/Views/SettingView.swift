

import SwiftUI

struct SettingView: View {
    
    let monthlyModel: MonthlyModel = MonthlyModel.shared
    let categoryModel: CategoryModel = CategoryModel.shared
    let recordModel: RecordModel = RecordModel.shared
    
    @FetchRequest(entity: MonthEntity.entity(), sortDescriptors: []) var months: FetchedResults<MonthEntity>
    
    @FetchRequest(entity: CategoryEntity.entity(), sortDescriptors: []) var categories: FetchedResults<CategoryEntity>
    
    @FetchRequest(entity: RecordEntity.entity(), sortDescriptors: []) var records: FetchedResults<RecordEntity>
    
    @Binding var isPresenting: Bool
    @State var isShowingAlert: Bool = false
    @State var gotoWelcomeView: Bool = false
    var body: some View {
        NavigationView{
            List{
                Button {
                gotoWelcomeView = true
                } label: {
                    Text("Change Currency")
                }
                Button {
                    isShowingAlert = true
                } label: {
                    Text("Reset")
                }.foregroundColor(.red)

            }
            .padding([.top, .bottom], 20)
                
                .toolbar {
                    Button {
                        isPresenting = false
                    } label: {
                        Text("Cancel")
                    }
                }
                .navigationTitle("Setting")
                .navigationBarTitleDisplayMode(.large)
            
                .alert("Confirm to Reset Data", isPresented: $isShowingAlert) {
                    Button {
                        isShowingAlert = false
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                        removeDefault()
                        gotoWelcomeView = true
                        monthlyModel.removeAllMonths(months: months)
                        categoryModel.removeAllCategories(categories: categories)
                        recordModel.removeAllRecords(records: records)
                    } label: {
                        Text("Reset")
                    }

                }
                .fullScreenCover(isPresented: $gotoWelcomeView) {
                    WelcomeView()
                }
        }
        .accentColor(Color(uiColor: UIColor(named: "ThemeColor")!))
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isPresenting: .constant(true))
    }
}

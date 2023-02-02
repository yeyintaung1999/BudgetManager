import SwiftUI

struct HomeListView: View {
    @FetchRequest(entity: RecordEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)]) var records: FetchedResults<RecordEntity>
    
    @State var isPresentingSetting: Bool = false

    var body: some View {
        NavigationView{
            VStack{
                //MARK: SUMMARY View
                SummaryView().background(RoundedCorners(color: Color(uiColor: UIColor(named: "ThemeColor")!), tl: 20, tr: 20, bl: 20, br: 20))
                
                Rectangle().frame(height: 1).border(.gray, width: 1) // Seperator
                
                //MARK: TODAY HISTORY Section
                Text("Today History").font(.system(size: 14, weight: .medium, design: .monospaced))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                    .padding([.top], 20)
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        VStack{
                            ForEach(todayRecords(), id: \.self) { item in
                                RecordItemView(recordItem: item)
                            }
                        }
                        .padding([.top], 20)
                        .background(RoundedCorners(color: .white, tl: 20, tr: 20, bl: 0, br: 0))
                    }
                    .background(Color.init(uiColor: .white))
                }
                .background(.white)
                .navigationTitle("Balance")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        isPresentingSetting = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .foregroundColor(.black)

                }
            }
            .padding([.leading, .trailing], 5)
        }
        .fullScreenCover(isPresented: $isPresentingSetting) {
            SettingView(isPresenting: $isPresentingSetting)
        }
    }
    
    func todayRecords()->[RecordEntity]{
        var result : [RecordEntity] = []
        records.forEach { entity in
            if isTodayRecord(date: entity.date ?? Date()){
                result.append(entity)
            }
        }
        return result
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}

func isTodayRecord(date: Date)->Bool {
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en")
    
    let todayDate = Date.now
    let currentDate = "\(Calendar.current.component(.year, from: todayDate))\(Calendar.current.component(.month, from: todayDate))\(Calendar.current.component(.day, from: todayDate))"
    
    let recordDate = "\(Calendar.current.component(.year, from: date))\(Calendar.current.component(.month, from: date))\(Calendar.current.component(.day, from: date))"
    
    
    return currentDate == recordDate
}



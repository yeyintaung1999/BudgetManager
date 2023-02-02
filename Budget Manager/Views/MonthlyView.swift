//
//  MonthlyView.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 27/01/2023.
//

import SwiftUI

struct MonthlyView: View {
    
    @FetchRequest(entity: MonthEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var months : FetchedResults<MonthEntity>
    

    
    var body: some View {
       
        if months.count == 0 {
            Text("No Data").foregroundColor(.gray)
        } else {
            ScrollView{
                VStack{
                    ForEach(months, id: \.date) { month in
                        NavigationLink {
                            StatsView(monthName: month.name ?? "default")
                        } label: {
                            
                            Text(month.name ?? "default")
                                .padding([.leading, .trailing], 100)
                                .padding([.top, .bottom], 5)
                                .background(RoundedRectangle(cornerRadius: 5).fill(Color(uiColor: UIColor(named: "ThemeColor")!)))
                        }

                    }
                }
                .padding([.top, .bottom], 20)
            }
        }
        
        
    }
}

struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView()
    }
}

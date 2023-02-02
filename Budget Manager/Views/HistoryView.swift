

import SwiftUI

struct HistoryView: View {
    @FetchRequest(entity: RecordEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var records : FetchedResults<RecordEntity>
    var body: some View {
       
        if records.count == 0 {
            Text("No History").foregroundColor(.gray)
        } else {
            List(){
                ForEach(records, id: \.self) { item in
                    NavigationLink {
                        RecordDetailView(record: item)
                    } label: {
                        HistoryItemView(record: item)
                        .listStyle(.plain)
                    }

                        
                }
            }
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

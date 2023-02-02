

import SwiftUI

struct HistoryItemView: View {
    
    var record: RecordEntity = RecordEntity()
    
    var body: some View {
        HStack{
            VStack{
                Text("\(formattedDate(date: record.date ?? Date()))")
                    .font(.system(size: 12, weight: .medium, design: .serif))
                    .foregroundColor(Color(uiColor: UIColor.lightGray))
                Text(record.category?.name ?? "")
                    .font(.system(size: 14, weight: .light, design: .serif))
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(sign())\(String(format: "%.2f", record.amount))  \(signdefault.string(forKey: "sign") ?? "")")
                .font(.system(size: 14, weight: .light, design: .monospaced))
                .foregroundColor(.gray)
        }
    }
    
    func sign()->String{
        
        if record.category?.type == "income"{
            return "+"
        } else {
            return "-"
        }
        
    }
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView()
    }
}



func formattedDate(date: Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter.string(from: date)
}

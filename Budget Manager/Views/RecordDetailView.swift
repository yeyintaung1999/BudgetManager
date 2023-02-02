

import SwiftUI

struct RecordDetailView: View {
    
    init(record: RecordEntity) {
        //UINavigationBar.appearance().isHidden = true
        self.record = record
    }
    
    var record : RecordEntity?
    
    var body: some View {
       
            VStack(alignment: .center){
                Text(gettype())
                    .font(.system(size: 14, weight: .ultraLight, design: .monospaced))
                    .foregroundColor(.gray)
                HStack(alignment:.center){
                    Text(getAmount()).font(.system(size: 30, weight: .light, design: .monospaced))
                        .foregroundColor(.black)
                    Text( "(\(signdefault.string(forKey: "sign")!))")
                        .font(.system(size: 14, weight: .ultraLight, design: .monospaced))
                        .foregroundColor(.gray)
                }
                Rectangle()
                    .strokeBorder(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .padding(5)
                
                HStack{
                    Image(systemName: "calendar").foregroundColor(.gray)
                    Text("Date").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.gray)
                    Spacer()
                    Text(getDate()).font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.black)
                }.padding([.top], 20)
                
                HStack{
                    Image(systemName: "square.grid.2x2").foregroundColor(.gray)
                    Text("Type").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.gray)
                    Spacer()
                    Text(record?.category?.name ?? "").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.black)
                }.padding([.top], 20)
                
                HStack{
                    Image(systemName: "dollarsign.circle").foregroundColor(.gray)
                    Text("Amount").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.gray)
                    Spacer()
                    Text("\(getAmount()) \(signdefault.string(forKey: "sign")!)").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.black)
                }.padding([.top], 20)
                
                HStack{
                    Image(systemName: "note.text").foregroundColor(.gray)
                    Text("Note").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.gray)
                    Spacer()
                    Text(record?.note ?? "-").font(.system(size: 12, weight: .ultraLight, design: .monospaced)).foregroundColor(.black)
                }.padding([.top], 20)
                Spacer()
            }
            .padding([.top, .leading, .trailing], 20)
            
        
       
    }
    
    func gettype()->String{
        let type = record?.category?.type ?? "income"
        if type == "income" {
            return "Income"
        } else {
            return "Expense"
        }
    }
    
    func getAmount()->String {
        if gettype() == "Income" {
            return "+\(record?.amount ?? 0)"
        } else {
            return "-\(record?.amount ?? 0)"
        }
    }
    
    func getDate()->String {
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        return formatter.string(from: record?.date ?? Date())
    }
}

struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView(record: RecordEntity())
    }
}

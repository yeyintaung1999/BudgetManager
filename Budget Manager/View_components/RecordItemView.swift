

import SwiftUI

struct RecordItemView: View {
    
    var recordItem: RecordEntity
    
    var body: some View {
        HStack{
            Image(systemName: getImage()).foregroundColor(.gray)
            Text("\(recordItem.category?.name ?? "default")")
                .font(.system(size: 12, weight: .light, design: .monospaced))
                .foregroundColor(Color(uiColor: UIColor(named: "SecondaryColor")!))
            Spacer()
            Text("\(getSign())\(String(format: "%.2f", recordItem.amount))  \(signdefault.string(forKey: "sign") ?? "")")
                .font(.system(size: 14, weight: .regular, design: .serif))
                .foregroundColor(Color(uiColor: getColor()))
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color(uiColor: UIColor(named: "LightColor")!)))
    }
    
    func getColor()->UIColor {
        if recordItem.category?.type == "income" {
            return UIColor.secondaryLabel
        }else {
            return UIColor.red
        }
    }
    
    func getSign()->String {
        if recordItem.category?.type == "income" {
            return "+"
        }else{
            return "-"
        }
    }
    
    func getImage()->String{
        if recordItem.category?.type == "income" {
            return "plus.circle"
        } else {
            return "minus.circle"
        }
    }
    
}


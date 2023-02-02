

import SwiftUI

struct WelcomeView: View {
    @State var isPresented: Bool = false
    @State var value: String = ""
    @State var textFieldColor: Color = .gray
    var body: some View {
        VStack{
            Spacer(minLength: 50)
            Text("Welcome").font(.system(size: 42, weight: .heavy, design: .monospaced)).foregroundColor(.gray)
            Text("Manage").font(.system(size: 60, weight: .heavy, design: .serif))
                .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
            Text("Your").font(.system(size: 60, weight: .heavy, design: .serif))
                .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
            Text("Budget!").font(.system(size: 60, weight: .heavy, design: .serif))
                .foregroundColor(Color(uiColor: UIColor(named: "LightColor")!))
            Spacer(minLength: 50)
            Text("Enter Currency Sign")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .foregroundColor(.white)
            TextField("eg. $, €, ¥", text: $value)
                .tint(.white)
                .padding(10)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(textFieldColor))
                .padding(20)
                
            Spacer()
            Button {
                if value == "" {
                    textFieldColor = .red
                }else {
                 
                    setSignDefault(sign: value)
                    
                    isPresented = true
                }
            } label: {
                HStack{
                    Text("Get Start")
                    Image(systemName: "chevron.forward")
                }
            }.padding([.bottom], 50)
            
            
        }
        .fullScreenCover(isPresented: $isPresented) {
            ContentView()
        }
        .background(Color(uiColor: UIColor(named: "SecondaryColor")!))
    }
    

    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

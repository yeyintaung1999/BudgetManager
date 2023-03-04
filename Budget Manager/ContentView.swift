

import SwiftUI


struct ContentView: View {
    
    

    init(){
        
        UITabBar.appearance().backgroundColor = UIColor(named: "ThemeColor")!
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselectColor")!
        
    }
    
    var body: some View {
        TabView{
            FirstView()
                .tabItem {
                Image(uiImage: UIImage(systemName: "dollarsign.circle")!)
            }
            NavigationView{
                MonthlyView()
                    .navigationTitle("Stats")
            }
            .tabItem {
                Image(uiImage: UIImage(systemName: "chart.pie")!)
            }
            NavigationView{
                HistoryView()
                    .navigationTitle("History")
                    .navigationBarTitleDisplayMode(.inline)
            }.background(.white)
            .tabItem {
                Image(uiImage: UIImage(systemName: "list.number")!)
            }
        }
        .accentColor(Color(uiColor: UIColor(named: "LightColor")!))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getDate()->String{
    let date = Date.now
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    let result = formatter.string(from: date)
    return result
}



import SwiftUI

@main
struct Budget_ManagerApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            
            if unsetSign(){
                WelcomeView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
            
            
        }
    }
}


func unsetSign()->Bool{
    return signdefault.string(forKey: "sign") == nil
}


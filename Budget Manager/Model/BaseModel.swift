import Foundation

class BaseModel{
    let context = PersistenceController.shared.container.viewContext
}

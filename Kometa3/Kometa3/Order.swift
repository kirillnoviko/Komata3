import RealmSwift
import Foundation

class Order: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var serviceName: String = ""
    @objc dynamic var customerName: String = ""
    @objc dynamic var carBrand: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var dateTime: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

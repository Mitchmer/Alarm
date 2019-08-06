import Foundation

class Alarm {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        get {
            let fireDateFormatter = DateFormatter()
            fireDateFormatter.dateStyle = .short
            fireDateFormatter.timeStyle = .short
            let fireDateString = fireDateFormatter.string(from: fireDate)
            return fireDateString
        }
    }
    
    init(fireDate: Date, name: String, enabled: Bool = true) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = UUID().uuidString
    }
    
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.fireDate == rhs.fireDate &&
            lhs.name == rhs.name &&
            lhs.enabled == rhs.enabled &&
            lhs.uuid == rhs.uuid &&
            lhs.fireTimeAsString == rhs.fireTimeAsString
    }
}

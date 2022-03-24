
import Foundation

struct TrackerTask: Identifiable {

    let id = UUID()
    var subject: String
    var description: String
    var dueDate: Date
    //var priority: Priority
    var isCompleted: Bool

    /*
    enum Priority: String {
        case undefined = ""
        case low = "!"
        case medium = "!!"
        case high = "!!!"
    }

     */

    mutating func toggleIsCompleted() {
        if (isCompleted) {
            isCompleted = false
        } else {
            isCompleted = true
        }
    }

    func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter.string(from: dueDate)
    }
    
    enum ConfigKeys: String, CodingKey {
        case subject
        case description
        case dueDate
        case isCompleted
    }
    
    /*

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ConfigKeys.self)
        self.subject = try values.decode(String.self, forKey: .subject)
        self.description = try values.decode(String.self, forKey: .description)
        self.dueDate = try values.decode(Date.self, forKey: .dueDate)
        self.isCompleted = try values.decode(Bool.self, forKey: .isCompleted)
    }

    func encode(to encoder: Encoder) throws {
        
    }
     
     */
}




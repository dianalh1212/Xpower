import Foundation

struct Favorite : Codable {
   
    let count : Int 
    let taskList : [Task]
    let username : String
    
    enum CodingKeys : String, CodingKey {
        case count = "Count"
        case taskList = "TasksList"
        case username = "Username"
    }
    struct Task : Codable {
        let task : String
        enum CodingKeys: String, CodingKey {
            case task = "Task"
        }
    }
}



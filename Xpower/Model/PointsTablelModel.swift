import Foundation

struct PointModel: Codable {
    
    var description : String
    var point : Int
    var isFavorite : Bool?
    enum CodingKeys : String, CodingKey {
        case description = "Description"
        case point = "Point"
    }
    init(descriptin : String, point : Int, isFavorite : Bool) {
        self.isFavorite =  false
        self.description = ""
        self.point = 0
    }
}

//
//  CurrentUserModel.swift
//  Xpower
//
//  Created by hui liu on 6/4/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import Foundation

struct CurrentUser : Codable {
    var username : String
    var email : String
    var schoolName : String
    var avatarImageUrl : String
    var touchIdOn : Bool
    let updatedAt : String
    
    enum CodingKeys : String, CodingKey {
        case username = "Username"
        case email = "Email"
        case schoolName = "SchoolName"
        case avatarImageUrl = "Avatarimageurl"
        case touchIdOn = "TouchIdOn"
        case updatedAt = "UpdatedAt"
    }
    init () {
        self.avatarImageUrl = ""
        self.email = ""
        self.updatedAt = ""
        self.schoolName = ""
        self.touchIdOn = false
        self.username = ""
    }
}

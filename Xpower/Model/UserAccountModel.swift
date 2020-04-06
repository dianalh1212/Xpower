//
//  UserAccountModel.swift
//  Xpower
//
//  Created by hui liu on 5/21/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import Foundation

class UserAccountModel {
    var users : [User] = []
}

struct User : Codable {
    var username : String
    var password : String
    var email : String
    var schoolName : String
    var avatar : Bool
    var avatarImageUrl : String
    var touchIdOn : Bool
    
    enum CodingKeys : String, CodingKey {
        case username = "Username"
        case password = "Password"
        case email = "Email"
        case schoolName = "SchoolName"
        case avatar = "Avatar"
        case avatarImageUrl = "Avatarimageurl"
        case touchIdOn = "TouchIdOn"
    }
    init () {
        self.avatar = false
        self.avatarImageUrl = ""
        self.email = ""
        self.password = ""
        self.schoolName = ""
        self.touchIdOn = false
        self.username = ""
    }
}


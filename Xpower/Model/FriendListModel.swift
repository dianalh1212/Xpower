//
//  FriendListModel.swift
//  Xpower
//
//  Created by hui liu on 5/30/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import Foundation

struct FriendLists : Codable {
    let count : Int?
    let friends : [Friend]
    enum CodingKeys : String, CodingKey {
        case count = "Count"
        case friends = "Friends"
    }
}

struct Friend : Codable {
    let username : String?
    enum CodingKeys : String, CodingKey {
        case username = "Username"
    }
}

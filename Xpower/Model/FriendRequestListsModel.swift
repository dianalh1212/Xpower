//
//  FriendListsModel.swift
//  Xpower
//
//  Created by hui liu on 5/30/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import Foundation

struct FriendRequestLists : Codable {
    let count : Int?
    let requests : [Request]
    enum CodingKeys : String, CodingKey {
        case count = "Count"
        case requests = "Requests"
    }
}

struct Request : Codable {
    let username : String?
    enum CodingKeys : String, CodingKey {
        case username = "Username"
    }
}

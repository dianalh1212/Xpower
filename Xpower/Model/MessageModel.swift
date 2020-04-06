//
//  MessageModel.swift
//  Xpower
//
//  Created by hui liu on 6/3/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import Foundation

struct Messages : Codable {
    let count : Int
    let messages : [Message]
    
    enum CodingKeys : String, CodingKey {
        case count = "Count"
        case messages = "Messages"
    }
    struct Message : Codable {
        let dateAndTime : String
        let message: String
        let receiver: String
        let sender: String
        enum CodingKeys: String, CodingKey {
            case dateAndTime = "DateAndTime"
            case message = "Message"
            case receiver = "Reciever"
            case sender = "Sender"
        }
    }
}

//
//  DeedModel.swift
//  Xpower
//
//  Created by hui liu on 5/26/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import Foundation
struct DeedModel : Codable {
    let date = getDate()
    let deed : String
}


func getDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = formatter.string(from: Date())
    return date
}

//
//  Checkin.swift
//  MockApi
//
//  Created by Edwy Lugo on 04/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

struct Checkin: Codable {
    let eventId: String
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case eventId = "eventId"
        case name = "name"
        case email = "email"
       }

       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
            eventId = try container.decode(String.self, forKey: .eventId)
            name = try container.decode(String.self, forKey: .name)
            email = try container.decode(String.self, forKey: .email)            
       }
}

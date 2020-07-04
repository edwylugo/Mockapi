//
//  Checkin.swift
//  MockApi
//
//  Created by Edwy Lugo on 04/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

struct Checkin: Codable {
    let id: String
    let eventId: String
    let name: String
    let picture: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case eventId = "eventId"
        case name = "name"
        case picture = "picture"
       }

       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            eventId = try container.decode(String.self, forKey: .eventId)
            name = try container.decode(String.self, forKey: .name)
            picture = try container.decode(String.self, forKey: .picture)
       }
}

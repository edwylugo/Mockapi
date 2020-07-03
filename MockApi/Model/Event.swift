//
//  Event.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation
import UIKit


struct Event: Codable {
    let people: [People]
    var date: Int?
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
    let cupons: [Cupons]
    
    var data: String? {
        var result: String = ""

        if let dateNew = date {
            let convertData = Date(timeIntervalSince1970: TimeInterval(dateNew) / 1000)
            let formatterNow = DateFormatter()
            formatterNow.dateFormat = "dd/MM/yyyy"
            let resultNow = formatterNow.string(from: convertData)
            result = "\(resultNow)"
        }
        return result
    }

    enum CodingKeys: String, CodingKey {
        case people = "people"
        case date = "date"
        case description = "description"
        case image = "image"
        case longitude = "longitude"
        case latitude = "latitude"
        case price = "price"
        case title = "title"
        case id = "id"
        case cupons = "cupons"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        people = try container.decode([People].self, forKey: .people)
        date = try container.decode(Int.self, forKey: .date)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decode(String.self, forKey: .image)
        longitude = try container.decode(Double.self, forKey: .longitude)
        latitude = try container.decode(Double.self, forKey: .latitude)
        price = try container.decode(Double.self, forKey: .price)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(String.self, forKey: .id)
        cupons = try container.decode([Cupons].self, forKey: .cupons)
    }
}


struct People: Codable {
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

struct Cupons: Codable {
    let id: String
    let eventId: String
    let discount: Int
    
    enum CodingKeys: String, CodingKey {
           case id = "id"
           case eventId = "eventId"
           case discount = "discount"
    }

  init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
       id = try container.decode(String.self, forKey: .id)
       eventId = try container.decode(String.self, forKey: .eventId)
       discount = try container.decode(Int.self, forKey: .discount)
  }
}


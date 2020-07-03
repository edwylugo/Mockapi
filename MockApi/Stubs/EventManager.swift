//
//  EventManager.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

class EventManager {
    let events: [Event]
    
    init() {
        let fileURL = Bundle.main.url(forResource: "event-response", withExtension: "json")!
        do {
            let decoder = JSONDecoder()
            let eventsData = try Data(contentsOf: fileURL)
            events = [try decoder.decode(Event.self, from: eventsData)]
            print("Lista: \(events.count)")
        } catch let parsingError {
            print("Error", parsingError)
            events = []
            return
        }
    }
}

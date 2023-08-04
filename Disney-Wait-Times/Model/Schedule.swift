//
//  SpecialEvents.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

struct Schedule: Codable {
    
        
    let date:String
    let type:String
    let closingTime:String
    let openingTime:String
    let description:String?
    
    
    
    enum CodingKeys: String, CodingKey {
        case date
        case type
        case closingTime
        case openingTime
        case description
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(String.self, forKey: .date)
        type = try values.decode(String.self, forKey: .type)
        closingTime = try values.decode(String.self, forKey: .closingTime)
        openingTime = try values.decode(String.self, forKey: .openingTime)
        description = try? values.decode(String.self, forKey: .description)
       
        
        
       
        
     }
    
    init(date:String,type:String,closingTime:String,openingTime:String,description:String) {
     
        self.date = date
        self.type = type
        self.closingTime = closingTime
        self.openingTime = openingTime
        self.description = description
         
      }
    
    static func error() -> Schedule {
        return Schedule(date: "BAD", type: "BAD", closingTime: "BAD", openingTime: "BAD", description: "BAD")
        
    }
    
    var displayOpen: String {
        return ISO8601DateFormatter().date(from: openingTime)?.formatted(date: .omitted, time: .shortened) ?? "--:--"
       
    }
    
    var displayClose: String {
        return ISO8601DateFormatter().date(from: closingTime)?.formatted(date: .omitted, time: .shortened) ?? "--:--"
       
    }
}


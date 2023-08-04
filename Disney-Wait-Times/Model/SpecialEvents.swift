//
//  SpecialEvents.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

struct SpecialEvents: Codable {
    
    let date:String
    let type:String
    let closingTime:String
    let openingTime:String
    
    
    
    enum CodingKeys: String, CodingKey {
        case date
        case type
        case closingTime
        case openingTime
    }
    
    init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(String.self, forKey: .date)
        type = try values.decode(String.self, forKey: .type)
        closingTime = try values.decode(String.self, forKey: .closingTime)
        openingTime = try values.decode(String.self, forKey: .openingTime)
     
        
     }
    
    init(date:String,type:String,closingTime:String,openingTime:String) {
     
        self.date = date
        self.type = type
        self.closingTime = closingTime
        self.openingTime = openingTime
         
      }
    
    static func error() -> SpecialEvents {
        return SpecialEvents(date: "BAD", type: "BAD", closingTime: "BAD", openingTime: "BAD")
        
        
    }
}


//
//  authToken.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

struct ParkHours: Codable {
    
     
    let id:String
    let schedule:[Schedule]
    var name: String
    let entityType: String
    let timezone:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case entityType
        case name
        case timezone
        case schedule
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        entityType = try values.decode(String.self, forKey: .entityType)
        name = try values.decode(String.self, forKey: .name)
        timezone = try values.decode(String.self, forKey: .timezone)
        schedule = try values.decode([Schedule].self, forKey: .schedule)
        
        if (id == "1c84a229-8862-4648-9c71-378ddd2c7693") {
            name = "Disney's Animal Kingdom"
        }
        
     }
    
    
    init() {
        self.id = "-1"
        self.name = "Park"
        self.entityType = "theme"
        self.timezone = "EST"
        self.schedule = [Schedule(date: "BAD", type: "BAD", closingTime: "BAD", openingTime: "BAD",description: "BAD")]
        
        
         
      }
    
    static func error() -> ParkHours {
        return ParkHours()
        
        
    }
    
  

}


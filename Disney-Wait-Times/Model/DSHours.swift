//
//  DSHours.swift
//  WDW Wait Times
//
//  Created by Zach Howes on 8/6/23.
//

import Foundation

struct DSHours: Codable {
  
    
     
    let id:Int
    let timePeriods:[TimePeriod]
    var name: String
    let contentType: String
   
    
    enum CodingKeys: String, CodingKey {
        case id
        case contentType
        case name
        case timePeriods
        
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        contentType = try values.decode(String.self, forKey: .contentType)
        name = try values.decode(String.self, forKey: .name)
        timePeriods = try values.decode([TimePeriod].self, forKey: .timePeriods)
                
     }
    
    
    init() {
        self.id = -1
        self.name = "----"
        self.contentType = "theme"
        self.timePeriods = [TimePeriod.error()]
        
      }
    
    static func error() -> ParkHours {
        return ParkHours()
        
        
    }
    
  

}

//
//  authToken.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

struct ParkHour: Codable {
    let date:String
    let special:[SpecialEvents]
    let openingTime: String
    let closingTime: String
    let type:String
   
    
  
    
    
    init() {
        self.date = "BAD"
        self.openingTime = "BAD"
        self.closingTime = "BAD"
        self.type = "BAD"
        self.special = [SpecialEvents(date: "BAD", type: "BAD", closingTime: "BAD", openingTime: "BAD")]
        
        
         
      }
    
    static func error() -> ParkHour {
        return ParkHour()
        
        
    }
    
    var displayOpen: String {
        return ISO8601DateFormatter().date(from: openingTime)?.formatted(date: .omitted, time: .shortened) ?? "Something Went Wrong"
       
    }
    
    var displayClose: String {
        return ISO8601DateFormatter().date(from: closingTime)?.formatted(date: .omitted, time: .shortened) ?? "Something Went Wrong"
       
    }

}


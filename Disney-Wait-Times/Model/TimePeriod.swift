//
//  timePeriod.swift
//  WDW Wait Times
//
//  Created by Zach Howes on 8/6/23.
//

import Foundation

struct TimePeriod: Codable {
    
        
//
//    "timePeriods": [{
//        "scheduleDate": 20230809,
//        "startTime": "10:00 AM",
//        "endTime": "11:00 PM",
//        "subScheduleTypeName": "Operating",
//        "timeZone": "EDT"
//    }]
    let scheduleDate:Int
    let endTime:String
    let startTime:String
    let subScheduleTypeName:String
    let timeZone:String
    
    
    
    enum CodingKeys: String, CodingKey {
        case scheduleDate
        case timeZone
        case endTime
        case startTime
        case subScheduleTypeName
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        scheduleDate = try values.decode(Int.self, forKey: .scheduleDate)
        subScheduleTypeName = try values.decode(String.self, forKey: .subScheduleTypeName)
        endTime = try values.decode(String.self, forKey: .endTime)
        startTime = try values.decode(String.self, forKey: .startTime)
        timeZone = try values.decode(String.self, forKey: .timeZone)
       
        
        
       
        
     }
    
    init(scheduleDate:Int,timeZone:String,startTime:String,endTime:String,subScheduleTypeName:String) {
     
        self.scheduleDate = scheduleDate
        self.timeZone = timeZone
        self.endTime = endTime
        self.startTime = startTime
        self.subScheduleTypeName = subScheduleTypeName
         
      }
    
    static func error() -> TimePeriod {
        return TimePeriod(scheduleDate: -1, timeZone: "", startTime: "", endTime: "", subScheduleTypeName: "")
        
    }
    
    var displayOpen: String {
        return startTime
       
    }
    
    var displayClose: String {
        return endTime
       
    }
}


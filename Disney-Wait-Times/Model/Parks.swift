//
//  Auth.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

class Parks: ObservableObject{
    @Published var parkData: [String:ParkHours] = [:]
    @Published var dsData:DSHours = DSHours()
    
    @Published var loadingError = false
    @Published var isLoading = true
    
    var parkIDs = ["mk","epcot","hs","dak","ds"]
    var idIndex = 0
    
    init() {
        Task {
            await getParkHours()
        }
    }
    
  

    
    @MainActor func getParkHours() async {
        loadingError = false
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        
        do {
            var newPark = try await Networker.getDataForPark(parkID: "75ea578a-adc8-4116-a54d-dccb60765ef9")
            parkData["mk"] = newPark
            
            newPark = try await Networker.getDataForPark(parkID: "47f90d2c-e191-4239-a466-5892ef59a88b")
            parkData["epcot"] = newPark
           
            newPark = try await Networker.getDataForPark(parkID: "288747d1-8b4f-4a64-867e-ea7c9b27bad8")
            parkData["hs"] = newPark
            
            newPark = try await Networker.getDataForPark(parkID: "1c84a229-8862-4648-9c71-378ddd2c7693")
            parkData["dak"] = newPark
            
            let date = Date()
            let dateFormatter = DateFormatter()
             
            dateFormatter.dateFormat = "yyyyMMdd"
             
            let d = dateFormatter.string(from: date)
            
            dsData = try await Networker.getDataForDS(date: d)
            
       
        } catch {
            loadingError = true
            print("There was a loading error")
            print(error)
        }
    }
    
    
    
    
    func getOperatingHoursOpen(parkArg:String) -> String {
        //use is loading to stop extra reloads
        let hoursError = "--:--"
        if (!isLoading) {
            if parkArg == "ds" {
                return dsData.timePeriods[0].displayOpen
               
            }
            
            
            let date = Date()
            let dateFormatter = DateFormatter()
             
            dateFormatter.dateFormat = "yyyy-MM-dd"
             
            let d = dateFormatter.string(from: date)
            
            let data = parkData[parkArg]
          
            let hours =  data?.schedule.filter{ ($0.date.contains(d)) }
           
            let operatingHours = hours?.filter{($0).type.contains("OPERATING")}
            
            return operatingHours?[0].displayOpen ?? Schedule.error().displayOpen
        }
        
        return hoursError
        
    }
    
    func getOperatingHoursClose(parkArg:String) -> String {
        //use is loading to stop extra reloads
        let hoursError = "--:--"
        if (!isLoading) {
            if parkArg == "ds" {
                return dsData.timePeriods[0].displayClose
               
            }
            
            
            let date = Date()
            let dateFormatter = DateFormatter()
             
            dateFormatter.dateFormat = "yyyy-MM-dd"
             
            let d = dateFormatter.string(from: date)
            
            let data = parkData[parkArg]
          
            let hours =  data?.schedule.filter{ ($0.date.contains(d)) }
           
            let operatingHours = hours?.filter{($0).type.contains("OPERATING")}
            
            return operatingHours?[0].displayClose ?? Schedule.error().displayClose
        }
        
        return hoursError
        
    }
    
    
    func getParkName (parkArg:String) -> String {
        if parkArg == "ds" {
            return dsData.name
        }
        return parkData[parkArg]?.name ?? "----"
    }
    
    func getNextID() -> String {
        idIndex += 1
        
        return parkIDs[idIndex % parkIDs.count]
    }
    
}

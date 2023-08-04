//
//  Auth.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

class Parks: ObservableObject{
    @Published var parkData: [String:ParkHours] = [:]
    
    @Published var loadingError = false
    @Published var isLoading = true
    
    var parkIDs = ["mk","epcot","hs","dak"]
    var idIndex = 0
    
    init() {
        Task {
            await getPark()
        }
    }
    
  

    
    @MainActor func getPark() async {
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
            
           
         
            
       
        } catch {
            loadingError = true
            print("There was a loading error")
            print(error)
        }
    }
    
    
    
    
    func getOperatingHours(parkArg:String) -> Schedule {
        //use is loading to stop extra reloads
        if (!isLoading) {
            
            
            let date = Date()
            let dateFormatter = DateFormatter()
             
            dateFormatter.dateFormat = "yyy-MM-dd"
             
            let d = dateFormatter.string(from: date)
            
            let data = parkData[parkArg]
          
            let mkHours =  data?.schedule.filter{ ($0.date.contains(d)) }
           
            let mkOperatingHours = mkHours?.filter{($0).type.contains("OPERATING")}
            
            return mkOperatingHours?[0] ?? Schedule.error()
        }
        
        return Schedule.error()
        
    }
    
    func getParkName (parkArg:String) -> String {
        if parkArg == "dak" {
            return parkData[parkArg]?.name ?? "park"
        }
        return parkData[parkArg]?.name ?? "park"
    }
    
    func getNextID() -> String {
        idIndex += 1
        
        return parkIDs[idIndex % 4]
    }
    
}

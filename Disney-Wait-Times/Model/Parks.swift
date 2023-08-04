//
//  Auth.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation

class Parks: ObservableObject{
    @Published var parks: [ParkHour] = [ParkHour()]
    
    @Published var loadingError = false
    @Published var isLoading = true
    
    init() {
        Task {
            await getPark()
        }
    }
    
  

    
    @MainActor func getPark() async {
        print("get Park")
        loadingError = false
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        
        do {
            let newParks = try await Networker.getDataForPark(park: "WaltDisneyWorldMagicKingdom")
            parks = newParks
            
            print("Printing saved data")
         
            
       
        } catch {
            loadingError = true
            print("There was a loading error")
            print(error)
        }
    }
    
    
    func getData() -> ParkHour {
        print("Chewie punch it!")
        //use is loading to stop extra reloads
        if (!isLoading) {
            return parks[1]
        }
        
        return ParkHour.error()
        
    }
}

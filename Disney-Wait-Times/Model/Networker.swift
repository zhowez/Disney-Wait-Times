//
//  Auth-Networker.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation


enum FetchError: Error {
  case badURL
  case badResponse
  case badJSON
}


enum Networker {
    static func getDataForPark(parkID:String) async throws -> ParkHours {
        
        let address = "https://api.themeparks.wiki/v1/entity/" + parkID + "/schedule"
        guard let url = URL(string: address) else {
            throw FetchError.badURL
        }
        let request = URLRequest(url: url)
        let (data, res) = try await URLSession.shared.data(for: request)
        guard let res =  res as? HTTPURLResponse, res.statusCode < 400 else {
            throw FetchError.badResponse
        }
        
        guard let newParkHours = try? JSONDecoder().decode(ParkHours.self, from: data) else {
            if let debugString = String(data: data, encoding: .utf8) {
                print("Debugging: ")
                print(debugString)
               
                
            }
            throw FetchError.badJSON
        }
        
        return newParkHours
    }
}

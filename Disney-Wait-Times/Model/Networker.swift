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
    static func getDataForPark(park:String) async throws -> [ParkHour] {
        
        let address = "https://api.themeparks.wiki/preview/parks/" + park + "/calendar"
        guard let url = URL(string: address) else {
            throw FetchError.badURL
        }
        let request = URLRequest(url: url)
        let (data, res) = try await URLSession.shared.data(for: request)
        guard let res =  res as? HTTPURLResponse, res.statusCode < 400 else {
            throw FetchError.badResponse
        }
        
        guard let newPark = try? JSONDecoder().decode([ParkHour].self, from: data) else {
            if let debugString = String(data: data, encoding: .utf8) {
                print("Debugging: ")
                print(debugString)
               
                
            }
            throw FetchError.badJSON
        }
        
        return newPark
    }
}

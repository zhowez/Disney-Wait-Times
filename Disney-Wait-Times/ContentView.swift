//
//  ContentView.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import SwiftUI



struct ContentView: View {
    @EnvironmentObject var parksApp:Parks

    var backgrounds = ["mk": Image("MK_BG"),"epcot": Image("EPCOT_BG"),"hs": Image("HS_BG"), "dak": Image("DAK_BG"),"ds": Image("DAK_BG") ]
    
   
    
    @State private var parkType = "mk"
    
    let timer = Timer.publish(every: 20, on: .main, in: .common).autoconnect()
    
        

    

    var open: String  {
        parksApp.getOperatingHours(parkArg: parkType).0
    }
    var close: String  {
        parksApp.getOperatingHours(parkArg: parkType).1
    }
    var title: String {
        parksApp.getParkName(parkArg: parkType)
    }
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 18).fill(Color.gray.opacity(0.9)).overlay(
                VStack {
                    HStack {
                        Text(title).foregroundColor(.black).font(.system(size: 100,weight: .bold))
                    };
                    Spacer().frame(height: 25);
                    HStack{
                        VStack {
                            Text("Opening Time").foregroundColor(.black).font(.system(size: 50,weight: .bold))
                            Text(open).foregroundColor(.black).font(.system(size: 50,weight: .bold))
                        };
                        VStack {
                            Text("Closing Time").foregroundColor(.black).font(.system(size: 50,weight: .bold))
                            Text(close).foregroundColor(.black).font(.system(size: 50,weight: .bold))
                        }; 
                    }
                    Spacer().frame(height: 25);
                }
            ).offset(y:350).frame(width: 1750, height: 300)
           
          
        }
        .padding()
        .background(backgrounds[parkType])
        .onAppear{AudioManager.shared.Start()}
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
        .onReceive(timer, perform: { time in
            parkType = parksApp.getNextID()
        })
    }
}


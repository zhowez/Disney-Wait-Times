//
//  ContentView.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import SwiftUI



struct ContentView: View {
    @EnvironmentObject var parksApp:Parks

    var backgrounds = ["mk": Image("MK_BG"),"epcot": Image("EPCOT_BG"),"hs": Image("HS_BG"), "dak": Image("DAK_BG"),"ds": Image("DS_BG") ]
    
   
    
    @State private var parkType = "mk"
    
    let timer = Timer.publish(every: 20, on: .main, in: .common).autoconnect()
    
        

    

    var open: String  {
        parksApp.getOperatingHoursOpen(parkArg: parkType)
    }
    var close: String  {
        parksApp.getOperatingHoursClose(parkArg: parkType)
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
            ).offset(y:350).frame(minWidth: 1200, idealWidth: 1600, maxWidth: 1750, minHeight: 100, idealHeight: 300, maxHeight: 300, alignment: .center)
           
          
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


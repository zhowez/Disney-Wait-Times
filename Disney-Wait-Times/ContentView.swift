//
//  ContentView.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import SwiftUI



struct ContentView: View {
    @EnvironmentObject var parksApp:Parks

        

    

    var open: String  {
        parksApp.getData().displayOpen
    }
    var close: String  {
        parksApp.getData().displayClose
    }
    
    var body: some View {
        
        VStack {
            Capsule().fill(Color.gray.opacity(0.9)).overlay(
                VStack {
                    HStack {
                        Text("Magic Kingdom").foregroundColor(.black).font(.system(size: 100,weight: .bold))
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
                        };  VStack {
                            Text("Fireworks").foregroundColor(.black).font(.system(size: 50,weight: .bold))
                            Text("9:00 PM").foregroundColor(.black).font(.system(size: 50,weight: .bold))
                        };
                    }
                    Spacer().frame(height: 25);
                }
            ).offset(y:350).frame(width: 1750, height: 300)
           
          
        }
        .padding()
        .background(Image("MK_BG"))
        .onAppear{AudioManager.shared.Start()}
    }
}


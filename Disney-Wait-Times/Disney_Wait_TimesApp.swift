//
//  Disney_Wait_TimesApp.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import SwiftUI

@main
struct Disney_Wait_TimesApp: App {
    @StateObject var parksApp = Parks()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(parksApp)
        }
    }
}

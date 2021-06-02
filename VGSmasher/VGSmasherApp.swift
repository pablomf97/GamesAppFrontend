//
//  VGSmasherApp.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

@main
struct VGSmasherApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView(viewRouter: viewRouter)
        }
    }
}

//
//  RootView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct RootView: View {
    // To change simply use --> viewRouter.currentPage = .anonymous
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .anonymous:
            WelcomeView(viewRouter: viewRouter)
        case .loggedIn:
            TabbedView(viewRouter: viewRouter)
        }
    }
}

enum RootPage {
    case anonymous
    case loggedIn
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewRouter: ViewRouter())
    }
}

//
//  BottomNavigationView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct TabbedView: View {
    @StateObject var viewRouter: ViewRouter
    var body: some View {
        TabView {
            GamesView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Games")
                }
            
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }
            
            AccountView(viewRouter: viewRouter)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView(viewRouter: ViewRouter())
    }
}

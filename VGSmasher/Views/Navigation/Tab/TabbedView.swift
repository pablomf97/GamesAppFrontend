//
//  BottomNavigationView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct TabbedView: View {
    @StateObject var viewRouter: ViewRouter
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            TopGamesView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Games")
                }
                .onTapGesture(perform: {
                    selection = 0
                })
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }
                .onTapGesture(perform: {
                    selection = 1
                })
                .tag(1)
            
            AccountView(viewRouter: viewRouter)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
                .onTapGesture(perform: {
                    selection = 2
                })
                .tag(2)
        }
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView(viewRouter: ViewRouter())
    }
}

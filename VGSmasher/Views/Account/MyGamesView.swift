//
//  MyGamesView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 9/6/21.
//

import SwiftUI

struct MyGamesView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Text("Waiting...").onAppear(perform: {
                viewModel.loadMyGames()
            })
        case .loading:
            ProgressView("Loading your games...")
        case .loaded:
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.games, id: \.self) { game in
                        NavigationLink(
                            destination: GameView(url: game.pageUrl)){
                            HStack {
                                URLImage(url: game.imageUrl).padding(.vertical, 6).frame(maxWidth: 125, maxHeight: 125)
                                VStack(alignment: .leading) {
                                    Text(game.name).font(.title2).fontWeight(.semibold)
                                    Text(game.description).lineLimit(4)
                                }.padding([.vertical, .trailing], 6).frame(maxHeight: .infinity, alignment: .topLeading)
                            }
                            .padding(5)
                            .background(Color("BrokenWhite"))
                            .cornerRadius(8)
                            .shadow(radius: 10)
                        }.foregroundColor(.black)
                        }
                }.padding()
            }
        case .empty:
            Button("We could not find any game here...\nTap here to refresh.") {
                viewModel.loadMyGames()
            }
            .multilineTextAlignment(.center)
            .font(.title3)
            .foregroundColor(.white)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(8.0)
            .shadow(radius: 10)
        }
    }
}

extension MyGamesView {
    class ViewModel: ObservableObject {
        enum State { case idle, loading, loaded, empty }
        
        @Published private(set) var state: State = .idle
        var games: [Game] = []
        
        func loadMyGames() {
            state = .loading
            DataSource().getMyGames(onComplete: { games in
                DispatchQueue.main.async {
                    if games.isEmpty {
                        self.state = .empty
                    } else {
                        self.games = games
                        self.state = .loaded
                    }
                }
            })
        }
    }
}

struct MyGamesView_Previews: PreviewProvider {
    static var previews: some View {
        MyGamesView()
    }
}

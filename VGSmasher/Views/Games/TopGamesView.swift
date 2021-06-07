//
//  TopGamesView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 3/6/21.
//

import SwiftUI

struct TopGamesView: View {
    
    @StateObject var viewModel = TopGamesView.ViewModel()
    
    var body: some View {
        NavigationView {
            
            switch viewModel.state {
            case .idle:
                Text("Waiting...")
                    .onAppear(perform: {
                        viewModel.getTopGames()
                    })
            case .loading:
                ProgressView("Looking for games...")
            case .loaded:
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.games, id: \.self) { game in
                            NavigationLink(destination: GameView(url: game.href)) {
                                VStack {
                                    HStack {
                                        Text(game.name)
                                            .font(.title2)
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }

                                    HStack(alignment: .lastTextBaseline) {
                                        Spacer()
                                        Text("In " + game.merchant + " for")
                                            .font(.footnote)
                                            .foregroundColor(.black)
                                        Text(game.price)
                                            .font(.title)
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                    }

                                }
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color("BrokenWhite"))
                                .cornerRadius(6)
                                .shadow(color: .gray, radius: 3, x: 2, y: 2)
                            }
                        }.padding(.horizontal).padding(.top, 5)
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("Top games")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { viewModel.getTopGames() }, label: {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                        })
                    }
                }
            case .error:
                Text("Whoops! Could not find any game. Hit that refresh button to try again!")
                    .font(.title2)
                    .padding()
            }
        }
    }
}

extension TopGamesView {
    class ViewModel: ObservableObject {
        enum State { case idle, loading, loaded, error }
        
        @Published private(set) var state = State.idle
        var games = [GameListItem]()
        
        func idle() {
            self.state = .idle
        }
        
        func getTopGames() {
            state = .loading
            DataSource().getTopGames(onComplete: { games in
                DispatchQueue.main.async {
                    if !games.isEmpty {
                        self.games = games
                        self.state = .loaded
                    } else {
                        self.state = .error
                    }
                }
            })
        }
    }
}

struct TopGamesView_Previews: PreviewProvider {
    static var previews: some View {
        TopGamesView()
    }
}

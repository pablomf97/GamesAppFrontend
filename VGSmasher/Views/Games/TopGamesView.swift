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
            if viewModel.isLoading {
                ProgressView("Looking for games...")
                    .foregroundColor(Color("PrimaryColor"))
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryColor")))
                    .onAppear(perform: {
                        viewModel.getTopGames()
                    })
            } else {
                ScrollView {
                    if viewModel.error {
                        Text("Whoops! Could not find any game. Hit that refresh button to try again!")
                            .font(.title2)
                            .padding()
                    } else {
                        LazyVStack {
                            ForEach(viewModel.games, id: \.self) { game in
                                // TODO: GAME INFO
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
                }
                .navigationBarTitle("Top games")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { viewModel.getTopGames() }, label: {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                        })
                    }
                }
            }
        }
    }
}

extension TopGamesView {
    class ViewModel: ObservableObject {
        @Published var games = [GameListItem]()
        @Published var isLoading = true
        @Published var error = false
        
        func getTopGames() {
            isLoading = true
            DataSource().getTopGames(onComplete: { games in
                DispatchQueue.main.async {
                    if !games.isEmpty {
                        self.games = games
                        
                        self.isLoading = false
                        self.error = false
                    } else {
                        self.error = true
                        self.isLoading = false
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

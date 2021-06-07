//
//  GameView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameView.ViewModel
    let url: String
    
    init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: GameView.ViewModel())
    }
    
    var body: some View {
        VStack {
            
            if let game = viewModel.game {
                VStack {
                    
                    if !game.imageUrl.isEmpty {
                        URLImage(url: game.imageUrl)
                    } else {
                        Image("GameController")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 170, maxHeight: 170)
                    }
                    
                    
                    Text(game.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        VStack {
                            
                            // Release date
                            Text("Released on:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(game.releaseDate)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Developer
                            Text("Developer:")
                                .padding(.top, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(game.developer)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Publisher
                            Text("Publisher:")
                                .padding(.top, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(game.publisher)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            // Platforms
                            Text("Platforms:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(game.platforms)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Pegi
                            Text("PEGI:")
                                .padding(.top, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(game.pegi)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                            
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top)
                    
                    // About the game
                    Text("About:")
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    Text(game.description)
                        .font(.title3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    
                    // Tags
                    Text("Tags:")
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    LazyHGrid(rows: [
                                GridItem(.adaptive(minimum: 25, maximum: 50)),
                                GridItem(.adaptive(minimum: 25, maximum: 50))], content: {
                                ForEach(0 ..< viewModel.tags.count, id: \.self) { i in
                                    if i < 6 {
                                        Text(viewModel.tags[i])
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color("AccentColor"))
                                            .cornerRadius(100)
                                    }
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .topLeading)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .background(Color("BrokenWhite"))
                .cornerRadius(16)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                
                NavigationLink(destination: OfferListView(gameUrl: self.url)) {
                    
                    HStack {
                        Text("Load offers")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable(resizingMode: .tile)
                            .frame(maxWidth: 20, maxHeight: 30)
                            .foregroundColor(.black)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(Color("BrokenWhite"))
                .cornerRadius(16)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                    
            } else {
                if viewModel.error {
                    Text("Oops! We could not get the game you were looking for. Please try again in a few seconds!")
                } else {
                    ProgressView("Loading games...")
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear(perform: {
            viewModel.getGame(url)
        })
    }
}

extension GameView {
    class ViewModel: ObservableObject {
        @Published var game: Game?
        @Published var error = false
        @Published var tags: [Substring] = []
        
        func getGame(_ url: String) {
            DataSource().getGameByUrl(game_url: url, onComplete: { game in
                DispatchQueue.main.async {
                    guard let game = game else {
                        self.error = true
                        return
                    }
                    
                    self.game = game
                    self.tags = game.tags.split(separator: "/")
                }
            })
        }
        
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(url: "https://www.allkeyshop.com/blog/buy-resident-evil-village-cd-key-compare-prices/")
    }
}

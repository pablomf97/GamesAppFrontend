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
                viewModel.loadMyGames(nil, nil)
            })
        case .loading:
            ProgressView("Loading your games...")
        case .loaded:
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.games, id: \.self) { game in
                            NavigationLink(
                                destination: GameView(url: game.pageUrl)){
                                HStack {
                                    if game.imageUrl.isEmpty {
                                        Image("GameController").padding(.vertical, 6).frame(maxWidth: 125, maxHeight: 125)
                                    } else {
                                        URLImage(url: game.imageUrl).padding(.vertical, 6).frame(maxWidth: 125, maxHeight: 125)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(game.name).font(.title2).fontWeight(.semibold)
                                        Text(game.description).lineLimit(4)
                                    }.padding([.vertical, .trailing], 6).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                }
                                .padding(5)
                                .background(Color("BrokenWhite"))
                                .cornerRadius(8)
                                .shadow(radius: 10)
                            }.foregroundColor(.black)
                        }
                    }.padding()
                }
                
                HStack {
                    if let prev = viewModel.prev {
                        Button("Previous") {
                            viewModel.loadMyGames(nil, prev)
                        }.padding().background(Color("PrimaryColor")).foregroundColor(.white).cornerRadius(50).shadow(color: .gray, radius:10.0)
                    }
                    
                    Spacer()
                    
                    if let next = viewModel.next {
                        Button("Next") {
                            viewModel.loadMyGames(next, nil)
                        }.padding().background(Color("PrimaryColor")).foregroundColor(.white).cornerRadius(50).shadow(color: .gray, radius:10.0)
                    }
                    
                }.zIndex(1.0).padding()
            }.navigationBarTitle(Text("Saved games"))
        case .empty:
            Button("We could not find any game here...\nTap here to refresh.") {
                viewModel.loadMyGames(nil, nil)
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
        var next: String?
        var prev: String?
        
        func loadMyGames(_ next: String?, _ previous: String?) {
            state = .loading
            DataSource().getMyGames(next: next, previous: previous, onComplete: { games, next, previous in
                DispatchQueue.main.async {
                    if games.isEmpty {
                        self.state = .empty
                    } else {
                        self.games = games
                        self.next = next
                        self.prev = previous
                        
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

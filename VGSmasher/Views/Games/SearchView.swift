//
//  SearchView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 11/6/21.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel: SearchView.ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onTextChanged: { text in
                    viewModel.searchGames(text: text)
                })
                .padding(.horizontal)
                
                switch viewModel.state {
                case .idle:
                    Text("Type something to search for a game!").padding()
                case .wrongInput:
                    Text("Type at least 3 characters to start looking!").padding()
                case .loading:
                    ProgressView("Searching...")
                case .loaded:
                    List {
                        ForEach(viewModel.games) { game in
                            NavigationLink(
                                destination: GameView(url: game.href),
                                label: {
                                    Text(game.name)
                                })
                        }
                    }
                case .noResults:
                    Text("It looks like we could not find any game matching what you typed...").padding()
                }
            }
            .navigationBarTitle(Text("Search for a game"))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }.onDisappear{ viewModel.idle() }
    }
}

extension SearchView {
    class ViewModel: ObservableObject {
        enum State { case idle, loading, loaded, wrongInput, noResults }
        
        @Published private(set) var state: State = .idle
        var games: [GameListItem] = []
        
        func idle() {
            state = .idle
        }
        
        func searchGames(text: String) {
            if state != .loading {
                if text.count < 3 {
                    state = .wrongInput
                } else {
                    state = .loading
                    let formattedText = text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "-")
                    DataSource().searchGames(gameName: formattedText, onComplete: { games in
                        DispatchQueue.main.async {
                            if games.isEmpty {
                                self.state = .noResults
                            } else {
                                self.games = games
                                self.state = .loaded
                            }
                        }
                    })
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

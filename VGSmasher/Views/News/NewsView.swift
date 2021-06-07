//
//  NewsView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject var viewModel: NewsView.ViewModel = ViewModel()
    
    var newsType = ["All", "Deals", "Giveaway", "Gaming", "Top"]
    @State private var selectedType = 0
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Text("Waiting...")
                .onAppear(perform: {
                    viewModel.getNews(selected: "All")
                })
        case .loading:
            ProgressView("Loading news...")
        case .loaded:
            VStack {
                Picker(selection: $selectedType, label: Text("News"), content: {
                    ForEach(0 ..< newsType.count) { i in
                        Text(self.newsType[i]).tag(i)
                    }
                })
                .onChange(of: selectedType, perform: { value in
                    viewModel.getNews(selected: newsType[value])
                })
                .pickerStyle(SegmentedPickerStyle())
                
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.news) { newsPiece in
                            HStack {
//                                URLImage(url: newsPiece.picture)
//                                    .frame(width: 100, height: 100, alignment: .center)
//                                    .cornerRadius(8)
                                
                                VStack {
                                    Text(newsPiece.headline)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(newsPiece.contentPreview)
                                        .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
                                }
                                .padding(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color("BrokenWhite"))
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 3, x: 3, y: 3)
                            .onTapGesture {
                                let url = URL(string: newsPiece.link)!
                                UIApplication.shared.open(url)
                            }
                            
                        }
                    }.padding()
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onDisappear(perform: {
                viewModel.idle()
            })
        }
    }
}

extension NewsView {
    class ViewModel: ObservableObject {
        enum State { case idle, loading, loaded }
        
        @Published private(set) var state = State.idle
        var news: [NewsRowItem] = []
        
        func idle() {
            state = .idle
        }

        func getNews(selected: String) {
            self.state = .loading
            var type: NewsRowItem.NewsType = .all
            switch selected {
                case "Deals":
                    type = .deals
                    break
                case "Giveaway":
                    type = .giveaway
                    break
                case "Gaming":
                    type = .gaming
                    break
                case "Top":
                    type = .top
                    break
                default:
                    type = .all
                    break
            }
            
            DataSource().getNews(type, onComplete: { news in
                if !news.isEmpty {
                    DispatchQueue.main.async {
                        self.news = news
                        self.state = .loaded
                    }
                }
            })
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

//
//  OfferListView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 6/6/21.
//

import SwiftUI

struct OfferListView: View {
    
    @StateObject var viewModel: OfferListView.ViewModel
    var gameUrl: String
    
    init(gameUrl: String) {
        self.gameUrl = gameUrl
        _viewModel = StateObject(wrappedValue: OfferListView.ViewModel())
    }
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading offers...")
                .onAppear(perform: {
                    viewModel.getGameOffers(gameUrl)
                })
        } else {
            if viewModel.offers.isEmpty {
                Text("Whoah... There were no offers for this game. Try again another time.")
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.offers, id:\.self) { offer in
                            HStack {
                                VStack {
                                    Text(offer.shop)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 30) {
                                        VStack(alignment: .leading) {
                                            Text("Platform:")
                                            Text(offer.platform)
                                                .font(.title2)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text("Edition:")
                                            Text(offer.edition)
                                                .font(.title2)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 5)
                                    
                                }
                                .frame(alignment: .leading)
                                
                                Spacer()
                                
                                Text(offer.priceBeforeFees)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color("BrokenWhite"))
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 3, x: 3, y: 3)
                            .onTapGesture {
                                let url = URL(string: offer.shopUrl)!
                                UIApplication.shared.open(url)
                            }

                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            }
        }
    }
}

extension OfferListView {
    class ViewModel: ObservableObject {
        // OfferRowItem(["shop": "Gamivo", "platform": "Steam", "edition": "Standard", "price_before_fees": "35,47€", "shop_url": ""])
        @Published var offers: [OfferRowItem] = []
        @Published var isLoading = true
        
        func getGameOffers(_ url: String) {
            isLoading = true
            DataSource().getGameOffersByUrl(game_url: url, onComplete: { offers in
                DispatchQueue.main.async {
                    self.offers = offers
                    self.isLoading = false
                }
            })
        }
    }
}

struct OfferListView_Previews: PreviewProvider {
    static var previews: some View {
        OfferListView(gameUrl: "")
    }
}

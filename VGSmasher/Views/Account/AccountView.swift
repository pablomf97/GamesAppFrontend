//
//  AccountView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewRouter: ViewRouter
    @StateObject var viewModel: AccountView.ViewModel = ViewModel()
    @State var isPresented: Bool = false

    var body: some View {
        ZStack {
            
            if viewModel.isLoading {
                ProgressView("Logging out...")
                    .zIndex(1.0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BrokenWhite").opacity(0.8))
            }
            
            NavigationView {
                List {
                    Section(header: Text("My games")) {
                        NavigationLink(
                            destination: MyGamesView(),
                            label: {
                                Text("My saved games")
                            })
                    }
                    
                    Section(header: Text("Account")) {
                        Button(action: { isPresented = true }, label: {
                            Text("Logout").foregroundColor(.black)
                        }).alert(isPresented: $isPresented, content: {
                            Alert(title: Text("Logout?"), message: Text("You are about to logout. Are you sure?"), primaryButton: .cancel(), secondaryButton: .default(Text("Yes"), action: {
                                viewModel.logout(viewRouter: viewRouter)
                            }))
                        })
                    }
                    
                    Section(header: Text("About")) {
                        NavigationLink(destination: VStack(alignment: .leading) {
                            Text("Welcome to VGSmasher!").font(.title2)
                            Text("First of all, VGSmasher is an app developed as part of a final thesis to my master's studies. I say as part because it consists in three different parts:\n   - A backend built using Python + Django.\n  - The deployment of this backend to a cloud service.\n  - A frontend built using Swift 5.0 and SwiftUI").padding(.top)
                            Text("The app works by doing HTTP requests to the backend we already mentioned. This backend will then perform a webscrapping of a webpage called AllKeyShop, where you can fing offers for almost every game there is. This webpage is accessible through the folowing link:").padding(.top)
                            Button("https://www.allkeyshop.com/", action: {
                                let url = URL(string: "https://www.allkeyshop.com/")!
                                UIApplication.shared.open(url)
                            }).padding(.top)
                            Text("Lastly, the information displayed in here belongs to AllKeyShop. This app is not going to be released to any app store nor I intent to profit from it in any way. It is, as I already said, just a project to use as my final master's thesis.").padding(.top)
                        }.padding().navigationBarTitle(Text("About the app")).frame(maxHeight: .infinity, alignment: .top)) {
                            Text("About the app")
                        }
                        
                        NavigationLink(destination: AppPolicyView()) {
                            Text("Privacy")
                        }
                    }
                }
                .navigationBarTitle("Account")
                .listStyle(InsetGroupedListStyle())
            }
        }
    }
}

extension AccountView {
    class ViewModel: ObservableObject {
        @Published var isLoading = false
        
        func logout(viewRouter: ViewRouter) {
            isLoading = true
            DataSource().logout(onComplete: { message in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if message as? String == "Successfully logged out" {
                        UserDefaults().removeSuite(named: "token")
                        viewRouter.currentPage = .anonymous
                    }
                }
            })
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewRouter: ViewRouter())
    }
}

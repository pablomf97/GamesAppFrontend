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
                        // TODO: Navigation Link
                        NavigationLink(
                            destination: Text("My saved games"),
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
                        NavigationLink(destination: Text("Destination")) {
                            Text("About the app")
                        }
                        
                        NavigationLink(destination: Text("Destination")) {
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

//
//  RegistrationView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 3/6/21.
//

import SwiftUI

struct RegistrationView: View {
    // View router
    @StateObject var viewRouter: ViewRouter
    
    // View model
    @StateObject var viewModel: RegistrationView.ViewModel
    
    // Form fields
    @State var email: String = ""
    @State var username: String = ""
    @State var userpass: String = ""
    @State var userpass2: String = ""
    
    init(viewRouter: ViewRouter) {
        _viewRouter = StateObject(wrappedValue: viewRouter)
        _viewModel = StateObject(wrappedValue: RegistrationView.ViewModel(viewRouter: viewRouter))
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image("GameController")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    
                    Text("Create new account.")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(Color("PrimaryColor"))
                }.frame(maxWidth: .infinity).padding(.bottom)
                
                TextField("Username", text: $username)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color("BrokenWhite"))
                    .cornerRadius(6.0)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1.5).foregroundColor(Color("PrimaryColor"))
                    )
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color("BrokenWhite"))
                    .cornerRadius(6.0)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1.5).foregroundColor(Color("PrimaryColor"))
                    )
                        
                SecureField("Password", text: $userpass)
                    .padding()
                    .background(Color("BrokenWhite"))
                    .cornerRadius(6.0)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1.5).foregroundColor(Color("PrimaryColor"))
                    )
                
                SecureField("Confirm your password", text: $userpass2)
                    .padding()
                    .background(Color("BrokenWhite"))
                    .cornerRadius(6.0)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 1.5).foregroundColor(Color("PrimaryColor"))
                    )
                
                Button("Sign up", action: {
                    viewModel.register(username: username, email: email, password: userpass, password2: userpass2)
                })
                .padding()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(6.0)
                .padding(.top, 25.0)
                .alert(isPresented: Binding<Bool>(
                    get: { self.viewModel.errors }, set: { _ in self.viewModel.errors = false }
                ), content: {
                    Alert(title: Text("Could not register"), message: Text(viewModel.errorText), dismissButton: .default(Text("OK"), action: { viewModel.errors = false }))
                })
                
            }
            
            Rectangle()
                .opacity(0.8)
                .foregroundColor(Color("BrokenWhite"))
                .hidden(!viewModel.isLoading)
            
            ProgressView("Loading...")
                .foregroundColor(Color("PrimaryColor"))
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color("PrimaryColor"))
                ).hidden(!viewModel.isLoading)
            
        }.padding(.horizontal).navigationBarTitleDisplayMode(.inline).navigationBarTitle(Text("Create account"))
    }
}

extension RegistrationView {
    class ViewModel: ObservableObject {
        @Published var isLoading = false
        @Published var errors = false
        @Published var errorText = ""
        
        @StateObject var viewRouter: ViewRouter
        
        init(viewRouter: ViewRouter) {
            _viewRouter = StateObject(wrappedValue: viewRouter)
        }
        
        func register(username: String, email: String, password: String, password2: String) {
            let formCheck = checkRegisterFormValidity(username: username, email: email, password: password, password2: password2)
            
            let isValid = formCheck["isValid"] as! Bool
            let errors = formCheck["errors"] as! [String]
            
            if isValid {
                isLoading = true
                let dataSource = DataSource()
                dataSource.register(
                    username: username,
                    email: email,
                    password: password,
                    password2: password2,
                    onComplete: { response in
                        DispatchQueue.main.async {
                            if let token = response as? String {
                                UserDefaults().set(token, forKey: "token")
                                self.viewRouter.currentPage = .loggedIn
                            } else {
                                self.errorText = "It looks like the email you are using is already registered."
                                self.errors = true
                                self.isLoading = false
                            }
                        }
                    }
                )
            } else {
                errorText = ""
                for (index, error) in errors.enumerated() {
                    if index == errors.count - 1 {
                        errorText += error
                    } else {
                        errorText += error + "\n"
                    }
                }
                self.errors = true
            }
        }
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewRouter: ViewRouter())
    }
}

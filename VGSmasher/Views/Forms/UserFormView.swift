//
//  UserFormView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct UserFormView: View {
    // View router
    @StateObject var viewRouter: ViewRouter
    
    // View model
    @StateObject var viewModel: UserFormView.ViewModel
    
    // Form fields
    @State var username: String = ""
    @State var userpass: String = ""
    
    // View
    var progressView: ProgressView = ProgressView()
    
    // Type of the form
    var formType: FormType
    
    init(viewRouter: ViewRouter, formType: FormType) {
        _viewRouter = StateObject(wrappedValue: viewRouter)
        _viewModel = StateObject(wrappedValue: UserFormView.ViewModel(viewRouter: viewRouter))
        
        self.formType = formType
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("GameController")
                    .resizable()
                    .frame(width: 170, height: 170, alignment: .center)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                
                Text("Sign in to your account.")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding()
                    .foregroundColor(Color("PrimaryColor"))
                
                TextField("Username", text: $username)
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
                
                Button("Sign in", action: {
                    viewModel.login(username: username, password: userpass)
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
                    Alert(title: Text("Could not login"), message: Text("Are you sure you are using the correct credentials?"), dismissButton: .default(Text("OK"), action: { viewModel.errors = false }))
                })
                
            }
            .padding()
            
            Rectangle()
                .opacity(0.8)
                .foregroundColor(Color("BrokenWhite"))
                .hidden(!viewModel.isLoading)
            
            ProgressView("Loading...")
                .foregroundColor(Color("PrimaryColor"))
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color("PrimaryColor"))
                ).hidden(!viewModel.isLoading)
        }
    }
}

extension UserFormView {
    class ViewModel: ObservableObject {
        @Published var isLoading = false
        @Published var errors = false
        
        @StateObject var viewRouter: ViewRouter
        
        init(viewRouter: ViewRouter) {
            _viewRouter = StateObject(wrappedValue: viewRouter)
        }
        
        func login(username: String, password: String) {
            let condition = username.trimmingCharacters(in: .whitespacesAndNewlines).count > 4 && password.trimmingCharacters(in: .whitespacesAndNewlines).count > 6
            if condition {
                isLoading = true
                let dataSource = DataSource()
                dataSource.login(
                    username: username,
                    password: password,
                    onComplete: { token in
                        DispatchQueue.main.async {
                            if let token = token as? String {
                                UserDefaults().set(token, forKey: "token")
                                self.viewRouter.currentPage = .loggedIn
                            } else {
                                self.errors = true
                                self.isLoading = false
                            }
                        }
                    }
                )
            }
        }
    }
}

enum FormType {
    case login
    case registration
}

struct UserFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserFormView(viewRouter: ViewRouter(), formType: .login)
    }
}

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
        
    // Form fields
    @State var username: String = ""
    @State var userpass: String = ""
    
    // View
    var progressView: ProgressView = ProgressView()
    
    // Type of the form
    var formType: FormType
    var titleText: String
    var buttonText: String
    
    init(viewRouter: ViewRouter, formType: FormType) {
        _viewRouter = StateObject(wrappedValue: viewRouter)
        
        self.formType = formType
        
        if formType == .login {
            titleText = "Sign in to your account."
            buttonText = "Sign in"
        } else {
            titleText = "Register a new account."
            buttonText = "Sign up"
        }
    }
    
    var body: some View {
        ZStack {
            if formType == .login {
                LoginView(viewRouter: viewRouter)
            } else {
                RegistrationView(viewRouter: viewRouter)
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

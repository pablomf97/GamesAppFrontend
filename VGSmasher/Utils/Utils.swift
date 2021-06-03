//
//  Utils.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 2/6/21.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide { hidden() }
        else { self }
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func checkRegisterFormValidity(username: String, email: String, password: String, password2: String) -> [String: Any] {
    var isValid = true
    var errors: [String] = []
    
    if username.count < 4 {
        if isValid { isValid = false }
        errors.append("The username must be at least 4 characters long.")
    }
    
    if email.isEmpty || !isValidEmail(email) {
        if isValid { isValid = false }
        errors.append("Please provide a valid email.")
    }
    
    if password.count < 6 || password2.count < 6 {
        if isValid { isValid = false }
        errors.append("The password must be at least 6 characters long.")
    }
    
    if password != password2 {
        if isValid { isValid = false }
        errors.append("Password confirmation must be exactly the same as the password.")
    }
    
    return ["isValid": isValid, "errors": errors]
}

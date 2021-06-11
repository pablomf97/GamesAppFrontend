//
//  Utils.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 2/6/21.
//

import Foundation
import SwiftUI

// Extensions
extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide { hidden() }
        else { self }
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

// Views
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onTextChanged: (String) -> Void
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var onTextChanged: (String) -> Void
        @Binding var text: String
        
        init(text: Binding<String>, onTextChanged: @escaping (String) -> Void) {
            _text = text
            self.onTextChanged = onTextChanged
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            onTextChanged(text)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onTextChanged: onTextChanged)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

// Other funcs
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


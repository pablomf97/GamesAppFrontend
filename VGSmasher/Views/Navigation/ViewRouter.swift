//
//  ViewRouter.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: RootPage
    
    init() {
        if let _ = UserDefaults.init().string(forKey: "token") {
            currentPage = .loggedIn
        } else {
            currentPage = .anonymous
        }
    }
}

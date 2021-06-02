//
//  AccountView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewRouter: ViewRouter

    var body: some View {
        Text("ACCOUNT")
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewRouter: ViewRouter())
    }
}

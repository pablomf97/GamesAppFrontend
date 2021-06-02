//
//  WelcomeView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 1/6/21.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            VStack {
                Image("GameController")
                    .resizable()
                    .frame(width: 170, height: 170, alignment: .center)
                
                Text("Welcome to VGSmasher!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding()
                    .foregroundColor(Color("PrimaryColor"))
                                
                NavigationLink(
                    destination: UserFormView(),
                    label: {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                    })
                    .frame(maxWidth: .infinity)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(6)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    .padding()
                
                NavigationLink(
                    destination: UserFormView(),
                    label: {
                        Text("Sign up")
                            .foregroundColor(Color("PrimaryColor"))
                            .fontWeight(.bold)
                            .padding()
                    })
                    .frame(maxWidth: .infinity)
                    .background(Color("BrokenWhite"))
                    .cornerRadius(6)
                    .shadow(color: .gray, radius: 3, x: 4, y: 4)
                    .padding(.horizontal)
                }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewRouter: ViewRouter())
    }
}

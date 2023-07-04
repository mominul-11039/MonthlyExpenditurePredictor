//
//  LoginScreen.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 22/6/23.
//

import SwiftUI

struct LoginScreen: View {

    @EnvironmentObject var sessionManager: SessionManager
    @StateObject var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                switch loginViewModel.isAuthenticated {
                case true:
                    NavigationLink(destination: HomeScreen(tabSelection: .home)
                        .environmentObject(sessionManager)
                        .navigationBarBackButtonHidden(true), isActive: $loginViewModel.isAuthenticated) {
                        EmptyView()
                    }
                default:
                    if loginViewModel.notHaveAccount {
                        NavigationLink(destination: RegistrationView()
                            .environmentObject(sessionManager)
                            .navigationBarBackButtonHidden(false), isActive: $loginViewModel.notHaveAccount) {
                            EmptyView()
                        }
                    } else {
                        TextField("User email", text: $loginViewModel.userEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.default)
                            .padding(10)
                        TextField("Password", text: $loginViewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.default)
                            .padding(10)
                        Button("Submit") {
                            loginViewModel.login()
                        }
                        Button("Don't have an Account? Please register") {
                            loginViewModel.navigateToRegistrationScreen()
                        }
                        .padding(EdgeInsets(top: 50, leading: 10, bottom: 0, trailing: 10))
                    }
                }
            }
        }
        .onAppear{
            self.loginViewModel.setUpEnv(session: sessionManager)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

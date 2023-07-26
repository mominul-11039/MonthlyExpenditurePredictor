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
            VStack(alignment: .center) {
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
                        Text("Login")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                        TextField("User email", text: $loginViewModel.userEmail)
                            .styledTextField()
                            .frame(alignment: .center)
                            .keyboardType(.emailAddress)
                        TextField("Password", text: $loginViewModel.password)
                            .styledTextField()
                            .frame(alignment: .center)
                            .keyboardType(.default)
                        if loginViewModel.willShowInvalidMsg {
                            Text("Invalid email or password")
                                .foregroundColor(.red)
                        }
                        if loginViewModel.isWrongEmailOrPassword {
                            Text("Wrong email or password")
                                .foregroundColor(.red)
                        }
                        Button {
                            loginViewModel.login()
                        } label: {
                            Text("Submit")
                                .registrationButtonStyle()
                        }
                        .padding(.vertical)
                        Button {
                            loginViewModel.navigateToRegistrationScreen()
                        } label: {
                            Text("Don't have an Account? Please register")
                            //.registrationButtonStyle()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }  //:- VSTACK
        } //:- NAVIGATION VIEW
        .padding()
        .accentColor(Constant.primaryBgColor)
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

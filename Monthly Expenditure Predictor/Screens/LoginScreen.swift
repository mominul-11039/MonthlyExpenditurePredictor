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
    @State var deviceWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {

            ZStack{
                Constant.appBackground
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
                            NavigationLink(destination: RegistrationScreen()
                                .environmentObject(sessionManager)
                                .navigationBarBackButtonHidden(false), isActive: $loginViewModel.notHaveAccount) {
                                    EmptyView()
                                }
                        } else {
                            
                            VStack{
                                Image("ExpIcon")
                                    .resizable()
                                    .imageScale(.small)
                                    .scaledToFit()
                                    .frame(maxWidth: 100, maxHeight: 100)
                                Text("SPENDWISE")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 24))
                                    .foregroundColor(.black.opacity(0.6))
                                Text("Empowering Your Financial Future")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            .padding(.top, 80)
                            Spacer()
                            TextField("User email", text: $loginViewModel.userEmail)
                                .styledTextField()
                                .padding(.horizontal,10)
                            
                            
                                .keyboardType(.emailAddress)
                            TextField("Password", text: $loginViewModel.password)
                                .styledTextField()
                                .padding(.horizontal,10)
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
                                Text("Login")
                                    .font(.system(.title3))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: deviceWidth * 0.85, height: 50)
                                    .background(Constant.gradientBG)
                                    .cornerRadius(8)
                                    .shadow(color: .gray, radius: 3, x: 2, y: 3)
                                    .padding()
                                
                            }
                            .padding(.vertical)
                            
                            Text("Don't have an account?")
                                .padding(.top, 20)
                            Button {
                                loginViewModel.navigateToRegistrationScreen()
                            } label: {
                                Text("Create New Account")
                                    .font(.system(.subheadline))
                                    .fontWeight(.bold)
                                    .foregroundColor(Constant.primaryBgColor.opacity(0.7))
                                //.registrationButtonStyle()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.7), radius: 3, x: 2, y: 3)
                            )
                            
                            .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }
                    }
                }  //:- VSTACK
            }//:- zestack
        } //:- NAVIGATION VIEW
        .padding()
        .background(Constant.appBackground)
        .accentColor(Constant.primaryBgColor)
        .onAppear{
            self.loginViewModel.setUpEnv(session: sessionManager)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().environmentObject(SessionManager())
    }
}

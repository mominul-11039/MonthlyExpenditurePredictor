//
//  RegistrationScreen.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 16/6/23.
//

import SwiftUI

struct RegistrationScreen: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var viewModel = RegistrationViewModel()
    @State private var isRegistrationComplete = false
    @State var deviceWidth = UIScreen.main.bounds.width

    
    var body: some View {
       
            VStack(alignment: .center) {
                SloganView()
                Spacer()
                TextField(Constant.emailPlaceholderText, text: $viewModel.email)
                    .styledTextField()
                    .keyboardType(.emailAddress)
                    .padding(.horizontal, 20)
                SecureField(Constant.passwordPlaceholderText, text: $viewModel.password)
                    .styledTextField()
                    .padding(.horizontal, 20)
                SecureField(Constant.confirmPasswordPlaceholderText, text: $viewModel.confirmPassword)
                    .styledTextField()
                    .frame(alignment: .center)
                    .padding(.horizontal, 20)
                
                if viewModel.isUserExists{
                    Text(Constant.alreadyExistsAlertMessage)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .padding(8)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }else{
                    NavigationLink(destination: RegisterPersonalDetailsView(viewModel: viewModel)
                        .environmentObject(sessionManager)
                        .navigationBarBackButtonHidden(true), isActive: $viewModel.isUserActive) {
                            EmptyView()
                        }
                }
                
                if viewModel.isValid {
                    Button(action: {viewModel.checkIfUserExists()}) {
                        Text("Next")
                            .font(.system(.title3))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: deviceWidth * 0.92, height: 50)
                            .background(Constant.gradientBG)
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 3, x: 2, y: 3)
                            .padding()
                    }
                    .padding()
                } else {
                    Button(action: {}) {
                        Text("Next")
                            .font(.system(.title3))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: deviceWidth * 0.90, height: 50)
                            .background(Constant.gradientBG)
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 3, x: 2, y: 3)
                            .padding()
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(Constant.appBackground)
         
        .onAppear{
            self.viewModel.setUpEnv(session: sessionManager)
        }
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen().environmentObject(SessionManager())
    }
}

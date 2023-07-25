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
                TextField("Email", text: $viewModel.email)
                    .styledTextField()
                    .keyboardType(.emailAddress)
                SecureField("Password [At least 6 char]", text: $viewModel.password)
                    .styledTextField()
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .styledTextField()
                    .frame(alignment: .center)
                
                if viewModel.isUserExists{
                    Text("""
                         This email address is already registered. Please use a different email address or try logging in.
                         """)
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

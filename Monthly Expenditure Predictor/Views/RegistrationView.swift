//
//  RegistrationView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//

import SwiftUI


struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @State private var isRegistrationComplete = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                TextField("Email", text: $viewModel.email)
                    .styledTextField()
                    .keyboardType(.emailAddress)
                SecureField("Password [At least 6 char]", text: $viewModel.password)
                    .styledTextField()
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .styledTextField()
                    .frame(alignment: .center)
                
                if viewModel.isUserExists{
                    Text("The provided email address is already registered. Please use a different email address or try logging in.")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .padding(8)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                }else{
                    NavigationLink(destination: RegisterPersonalDetailsView(viewModel: viewModel), isActive: $viewModel.isUserActive) {
                            EmptyView()
                        }
                }
                if viewModel.isValid {
                    Button(action: {viewModel.checkIfUserExists()}) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                } else {
                    Button(action: {}) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            
        }
        .padding()
    }
}

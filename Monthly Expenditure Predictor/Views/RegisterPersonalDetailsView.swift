//
//  RegisterPersonalDetailsView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//

import SwiftUI

struct RegisterPersonalDetailsView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
       
        ZStack {
            Constant.appBackground
                .ignoresSafeArea()
            if viewModel.isAuthenticated {
                NavigationLink(destination: HomeScreen(tabSelection: .home)
                    .environmentObject(sessionManager)
                    .navigationBarBackButtonHidden(true), isActive: $viewModel.isAuthenticated) {
                        EmptyView()
                }
            } else {
                VStack {
                    Image("AvaterImage")
                        .resizable()
                        .frame(width: 180, height: 180)
                        
                    Text("Personal Details")
                        .font(.system(.title))
                        .fontWeight(.heavy)
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.bottom,60)
                    TextField("Full Name", text: $viewModel.fullName)
                        .styledTextField()
                        .padding(.horizontal, 20)
                    TextField("Number of family member", text: Binding(
                        get: { viewModel.noOfFamilyMember == 0 ? "" : String(viewModel.noOfFamilyMember) },
                        set: { viewModel.noOfFamilyMember = Int($0) ?? 0 }
                    ))
                        .styledTextField()
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 20)
                    TextField("Address", text: $viewModel.address)
                        .styledTextField()
                        .padding(.horizontal, 20)
                    TextField("Age", text: Binding(
                        get: {viewModel.age == 0 ? "" : String(viewModel.age)},
                        set: { viewModel.age = Int($0) ?? 0}
                    ))
                        .styledTextField()
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 20)
                    
                    Button(action: viewModel.register) {
                        Text("Finish")
                            .foregroundColor(.white)
                            .font(.system(.title3))
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Constant.gradientBG )
                            .cornerRadius(8)
                    }
    //                .disabled(viewModel.isValid)
                    .padding()
                }
            .padding()
            }
        }
    }
}

struct RegisterPersonalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPersonalDetailsView(viewModel: RegistrationViewModel())
    }
}

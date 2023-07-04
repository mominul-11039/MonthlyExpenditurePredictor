//
//  RegisterPersonalDetailsView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//

import SwiftUI

struct RegisterPersonalDetailsView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
       
        NavigationView {
            if viewModel.isAuthenticated {
                NavigationLink(destination: HomeScreen(tabSelection: .home).navigationBarBackButtonHidden(true), isActive: $viewModel.isAuthenticated) {
                        EmptyView()
                }
            } else {
                VStack {
                    Text("Personal Details")
                        .fontWeight(.bold)
                    TextField("Full Name", text: $viewModel.fullName)
                        .styledTextField()
                    TextField("Number of family member", text: Binding(
                        get: { viewModel.noOfFamilyMember == 0 ? "" : String(viewModel.noOfFamilyMember) },
                        set: { viewModel.noOfFamilyMember = Int($0) ?? 0 }
                    ))
                        .styledTextField()
                        .keyboardType(.numberPad)
                    TextField("Address", text: $viewModel.address)
                        .styledTextField()
                    TextField("Age", text: Binding(
                        get: {viewModel.age == 0 ? "" : String(viewModel.age)},
                        set: { viewModel.age = Int($0) ?? 0}
                    ))
                        .styledTextField()
                        .keyboardType(.numberPad)
                    
                    Button(action: viewModel.register) {
                        Text("Finish")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue )
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

//struct RegisterPersonalDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterPersonalDetailsView()
//    }
//}

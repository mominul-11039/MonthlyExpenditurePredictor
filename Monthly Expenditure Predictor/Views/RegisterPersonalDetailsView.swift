//
//  RegisterPersonalDetailsView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//

import SwiftUI

struct RegisterPersonalDetailsView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Personal Details")
                    .fontWeight(.bold)
                TextField("Full Name", text: $viewModel.fullName)
                    .styledTextField()
                TextField("Number of family member", text: $viewModel.noOfFamilyMember)
                    .styledTextField()
                    .keyboardType(.numberPad)
                TextField("Address", text: $viewModel.address)
                    .styledTextField()
                TextField("Age", text: $viewModel.age)
                    .styledTextField()
                    .keyboardType(.numberPad)
                
                Button(action: viewModel.register) {
                    Text("Finish")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isValid ? Color.blue : Color.gray)
                        .cornerRadius(8)
                        
                }
                .disabled(viewModel.isValid)
                .padding()
            }
            
        }
        .padding()
    }
}

struct RegisterPersonalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPersonalDetailsView()
    }
}

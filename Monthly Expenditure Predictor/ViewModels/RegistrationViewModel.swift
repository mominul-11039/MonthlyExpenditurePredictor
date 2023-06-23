//
//  RegistrationViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//
import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var address = ""
    @Published var age = ""
    @Published var noOfFamilyMember = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
            Publishers.CombineLatest($password, $confirmPassword)
                .receive(on: DispatchQueue.main)
                .map { password, confirmPassword in
                    return !password.isEmpty && password == confirmPassword
                }
                .assign(to: \.isValid, on: self)
                .store(in: &cancellables)
        }
       
        func register() {
        print("Registration successful!")
    }
}

//
//  LoginViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 22/6/23.
//

import Foundation
import Combine
import CloudKit

class LoginViewModel: ObservableObject{

    var cancellables = Set<AnyCancellable>()
    @Published var userEmail = ""
    @Published var password = ""

    var user: User?
    @Published var isAuthenticated: Bool = false
    @Published var notHaveAccount: Bool = false

    // MARK: - Fetch employee from cloudkit
    func login(){
        let predicate = NSPredicate(format: "user_email == %@", userEmail)
        let recordType = "expenditure_user"
        print("User email : \(userEmail)")
        print("User password : \(password)")
        CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] returnedItems in
                self?.user = returnedItems.first
                if returnedItems.count > 0 && self?.user?.userPasswrod == self?.password {
                    DispatchQueue.main.async {
                        self?.isAuthenticated = true
                    }
                    
                }
            }
            .store(in: &cancellables)
    }

    func navigateToRegistrationScreen() {
        DispatchQueue.main.async { [weak self] in
            self?.notHaveAccount = true
        }
    }
}

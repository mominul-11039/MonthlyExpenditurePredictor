//
//  LoginViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 22/6/23.
//

import Foundation
import Combine
import CloudKit
import SwiftUI

class LoginViewModel: ObservableObject{

    var sessionManager: SessionManager?
    var cancellables = Set<AnyCancellable>()
    @Published var userEmail = ""
    @Published var password = ""
    @Published var willShowInvalidMsg: Bool = false

    var user: User?
    @Published var isAuthenticated: Bool = false
    @Published var notHaveAccount: Bool = false
    @Published var isWrongEmailOrPassword = false

    func setUpEnv(session: SessionManager) {
        self.sessionManager = session
    }

    // MARK: - Fetch employee from cloudkit
    func login(){
        if userEmail == "" || password == "" {
            DispatchQueue.main.async { [weak self] in
                self?.willShowInvalidMsg = true
                self?.isWrongEmailOrPassword = false
            }
            return
        }
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
                    DispatchQueue.main.async { [weak self] in
                        self?.willShowInvalidMsg = false
                        self?.isWrongEmailOrPassword = false
                        self?.isAuthenticated = true
                    }
                    UserDefaults.standard.set(self?.user?.userEmail, forKey: "MEP_LOGGED_IN_USER_NAME")
                    self?.sessionManager?.login()
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.willShowInvalidMsg = false
                        self?.isWrongEmailOrPassword = true
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

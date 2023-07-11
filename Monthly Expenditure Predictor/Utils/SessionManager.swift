//
//  SessionManager.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 4/7/23.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var isLoggedIn = false

    init() {
        let userEmail = UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME") ?? ""
        if userEmail == "" {
            logout()
        } else {
            login()
        }
    }

    func login() {
        // Perform login logic here
        DispatchQueue.main.async { [weak self] in
            self?.isLoggedIn = true
        }
    }

    func logout() {
        // Perform logout logic here
        DispatchQueue.main.async { [weak self] in
            UserDefaults.standard.set("", forKey: "MEP_LOGGED_IN_USER_NAME")
            self?.isLoggedIn = false
        }
    }
}

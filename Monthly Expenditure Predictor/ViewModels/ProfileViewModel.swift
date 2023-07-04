//
//  ProfileViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by Sadat Ahmed on 2023/06/23.
//

import Foundation
import CloudKit
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userInfo: [User] = []
    var vm: CloudKitViewModel = CloudKitViewModel()
    var userEmail: String?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.userEmail = UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME")
        if let userEmail =  userEmail {
            self.getUserInformations(email: userEmail)
        }
    }
    
    private func getUserInformations(email: String) {
        let email = email
        let predicate = NSPredicate(format: "user_email == %@", email)
        
        let recordType = "expenditure_user"
        CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                //
            } receiveValue: { [weak self] returnedInfo in
                self?.userInfo = returnedInfo
            }
            .store(in: &cancellables)
    }
    
    func getUser() -> [User] {
        return userInfo
    }
}

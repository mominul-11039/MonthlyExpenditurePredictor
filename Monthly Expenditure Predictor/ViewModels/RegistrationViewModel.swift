//
//  RegistrationViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//
import Foundation
import Combine
import CloudKit
import SwiftUI

class RegistrationViewModel: ObservableObject {

    var sessionManager: SessionManager?
    @Published var fullName = ""
    @Published var address = ""
    @Published var age = 0
    @Published var noOfFamilyMember = 0
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isValid = false
    @Published var isUserExists = false
    @Published var isUserActive = false
    @Published var isAuthenticated = false

    private var cancellables = Set<AnyCancellable>()

    init() {
            Publishers.CombineLatest3($password, $confirmPassword, $email)
                .receive(on: DispatchQueue.main)
                .map { password, confirmPassword, email in
                    return !password.isEmpty && password == confirmPassword && !email.isEmpty
                }
                .assign(to: \.isValid, on: self)
                .store(in: &cancellables)
        }

    func setUpEnv(session: SessionManager) {
        self.sessionManager = session
    }

    // MARK: Save User to cloudkit
    private func saveUser(){
        let record = CKRecord(recordType: Constant.expUserRecordType)

        record[Constant.ckUserNameRecord] = self.fullName as CKRecordValue
        record[Constant.ckUserEmailRecord] = self.email as CKRecordValue
        record[Constant.ckUserAddressRecord] = self.address as CKRecordValue
        record[Constant.ckUserAgeRecord] = self.age as CKRecordValue
        record[Constant.ckNoOfFamilyMemberRecord] = self.noOfFamilyMember as CKRecordValue
        record[Constant.ckPasswordRecord] = self.password as CKRecordValue
        record[Constant.ckConfirmPasswordRecord] = self.confirmPassword as CKRecordValue

        CloudKitViewModel.add(item: User(record: record)!) { [weak self] result in
            switch result{
            case .failure(let err):
                print(err)
            case .success(_):
                print("Succeed!!")
                DispatchQueue.main.async { [weak self] in
                    self?.isAuthenticated = true
                    UserDefaults.standard.set(self?.email, forKey: Constant.loggedinUserKey)
                    self?.sessionManager?.login()

                }
            }
        }
    }

    // MARK: Check if user exist
    func checkIfUserExists(){
        CloudKitViewModel.checkUserExistsWithEmail(email: email) {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let isUserExists):
                DispatchQueue.main.async {
                    self.isUserExists = isUserExists
                    self.isUserActive = !isUserExists
                }
            case .failure(let err):
                print(err)
            }
            
            
        }
    }

    func register() {
        isValid ? saveUser() : print()
    }
}

//
//  RegistrationViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//
import Foundation
import Combine
import CloudKit
class RegistrationViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var address = ""
    @Published var age = 0
    @Published var noOfFamilyMember = 0
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isValid = false
    @Published var isUserExists = false
    
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
    
    
    // MARK: Save User to cloudkit
    private func saveUser(){
        let record = CKRecord(recordType: "expenditure_user")
            
        record["user_name"] = self.fullName as CKRecordValue
        record["user_email"] = self.email as CKRecordValue
        record["user_address"] = self.address as CKRecordValue
        record["user_age"] = self.age as CKRecordValue
        record["no_of_family_member"] = self.noOfFamilyMember as CKRecordValue
        record["password"] = self.password as CKRecordValue
        record["confirm_password"] = self.confirmPassword as CKRecordValue
        
        CloudKitViewModel.add(item: User(record: record)!) { result in
            switch result{
            case .failure(let err):
                print(err)
            case .success(_):
                // TODO: make status authenticated
                print("Succeed!!")
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
                }
            case .failure(let err):
                print(err)
            }
            
            
        }
    }

       
        func register() {
            isValid ? saveUser() : print("registration unsuccessful")
    }
}

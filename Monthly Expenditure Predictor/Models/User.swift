//
//  User.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import Foundation
import CloudKit


struct User: Hashable, CloudKitableProtocol{
    init?(record: CKRecord) {
        self.fullName = record["user_name"] ?? ""
        self.userEmail = record["user_email"] ?? ""
        self.userAddress = record["user_address"] ?? ""
        self.userAge = record["user_age"] ?? 0
        self.userNoOfFamilyMember = record["no_of_family_member"] ?? 0
        self.userPasswrod = record["password"] ?? ""
        self.userConfirmPassword = record["password"] ?? ""
        self.record = record
    }
    
    let fullName: String
    let userEmail: String
    let userAddress: String
    let userAge: Int
    let userNoOfFamilyMember: Int
    let userPasswrod:String
    let userConfirmPassword:String
    let record: CKRecord
}




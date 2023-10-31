//
//  ExpenditurePredictionParams.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 16/10/23.
//

import Foundation

class ExpenditurePredictionParams{
    init(userName: String,
         userAge: Int,
         address: String,
         noOfFamilyMember: Int,
         expenseAmount: Int,
         cumulativeSum: Double,
         month: Int,
         day: Int) 
    {
        self.userName = userName
        self.userAge = Int64(userAge)
        self.address = address
        self.noOfFamilyMember = Int64(noOfFamilyMember)
        self.expenseAmount = Int64(expenseAmount)
        self.cumulativeSum = Int64(cumulativeSum)
        self.month = Int64(month)
        self.day = Int64(day)
    }
    // MARK: - Protperties
    final var userName: String
    final var userAge: Int64
    final var address: String
    final var noOfFamilyMember: Int64
    final var expenseAmount: Int64
    final var cumulativeSum: Int64
    final var month: Int64
    final var day: Int64
}

// MARK: - Expenditure Error
enum PredictionError: Error {
    // Throw when NSError Occured
    case SomethingWentWrong(message:String)
    // Throw in all other cases
    case unexpected(message:String)
}

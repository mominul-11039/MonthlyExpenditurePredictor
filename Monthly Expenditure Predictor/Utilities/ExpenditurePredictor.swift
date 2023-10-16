//
//  ExpenditurePredictor.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 16/10/23.
//

import Foundation
import CoreML

class ExpenditurePredictor : ExpenditurePredictionProtocol{
    // MARK: - Month End Expense Prediction
    func getApproximateMonthendExpense(feature data: ExpenditurePredictionParams) -> Result<Double, PredictionError> {
        do{
            let config = MLModelConfiguration()
            let model = try BJIT_Monthly_Expenditure_Predictor_1(configuration: config)
            let prediction =
            try model.prediction(User_Name: data.userName,
                                 User_Age: data.userAge,
                                 Address: data.address,
                                 Family_Members: data.noOfFamilyMember,
                                 Expense_Amount: data.expenseAmount,
                                 Cumulative_Sum: data.cumulativeSum,
                                 Month: data.month,
                                 Day: data.day
            )
            
            return Result.success(prediction.Month_End_Expense)
            
        }catch  {
            return Result.failure(.SomethingWentWrong(message: "Something went wrong!"))
        }
    }
}

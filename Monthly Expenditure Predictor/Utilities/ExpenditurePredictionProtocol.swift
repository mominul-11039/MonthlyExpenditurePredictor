//
//  ExpenditurePredictionProtocol.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 16/10/23.
//

import Foundation

protocol ExpenditurePredictionProtocol{
    // MARK: - Predict Month-End expendigture
    /**
         Returns an object of type `BJIT_Monthly_Expenditure_Predictor_1Output` that represents the approximate month-end expense based on the given `ExpenditurePredictionParams` data.

         - Parameter data: An object of type `ExpenditurePredictionParams` that contains the necessary data to predict the approximate month-end expense.

         - Returns: An object of type `BJIT_Monthly_Expenditure_Predictor_1Output` that represents the approximate month-end expense.
         */
    func getApproximateMonthendExpense(feature data: ExpenditurePredictionParams) -> Result<Double, PredictionError>
}

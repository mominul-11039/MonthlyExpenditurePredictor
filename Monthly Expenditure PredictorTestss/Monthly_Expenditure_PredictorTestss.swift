//
//  Monthly_Expenditure_PredictorTestss.swift
//  Monthly Expenditure PredictorTestss
//
//  Created by YeasirArefinTusher-11702 on 17/10/23.
//

import XCTest
@testable import Monthly_Expenditure_Predictor
final class Monthly_Expenditure_PredictorTestss: XCTestCase {
    var sut: CurrentMonthExpenditureViewModel!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CurrentMonthExpenditureViewModel()
    }
    
    
    // MARK: - Tear Down
    override func tearDownWithError() throws {
       sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Test Functions
    func testExpenditurePredictorWhenParameterPassedShouReturnDouble(){
        // When
        sut.predictMonthEndExpenditure()
        
        // Then
        let result = sut.predictedMonthEndExpense > 0
        
        XCTAssertTrue(result, "Predict monthend result test failed")
        
    }


}

//
//  Monthly_Expenditure_PredictorUITestsLaunchTests.swift
//  Monthly Expenditure PredictorUITests
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import XCTest

final class Monthly_Expenditure_PredictorUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

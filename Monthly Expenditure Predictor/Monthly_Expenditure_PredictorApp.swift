//
//  Monthly_Expenditure_PredictorApp.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import SwiftUI

@main
struct Monthly_Expenditure_PredictorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NavigationLink(destination: DashBoardView()) {
                    Text("Home")
                }
            }
        }
    }
}

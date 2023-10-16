//
//  CurrentMonthExpenseView.swift
//  Monthly Expenditure Predictor
//
//  Created by SADAT AHMED on 2023/07/24.
//

import SwiftUI

struct CurrentMonthExpenseView: View {
    // MARK: - PROPERTIES
    var dailyExpense: [DailyExpense] = []
    var expectedMonthEndExpense:Double = 0
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            // MARK: Title View
            HStack {
                Text("Date")
                    .fontWeight(.bold)
                    .font(Font.system(size: 16))
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                Text("Price")
                    .fontWeight(.bold)
                    .font(Font.system(size: 16))
                    .foregroundColor(Color.black.opacity(0.7))
            } //:- HSTACK
            .padding(.horizontal, 15)
            .padding(.top, 15)
            // MARK:  Expense View
            List(dailyExpense) { expense in
                HStack {
                    Text(expense.date)
                        .font(Font.system(size: 14))
                    Spacer()
                    Text("৳ \(expense.price)")
                        .font(Font.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Constant.primaryBgColor)
                } //:- HSTACK
                .listRowBackground(Color.clear)
            } //:- Expense View
            HStack {
                Text("Predicted Month-End Expense:")
                    .fontWeight(.bold)
                    .font(Font.system(size: 12))
                    .foregroundColor(Color.black.opacity(0.6))
                Spacer()
                Text("৳ \(Int(expectedMonthEndExpense))")
                    .fontWeight(.bold)
                    .font(Font.system(size: 12))
                    .foregroundColor(Constant.primaryBgColor)
            } //:- HSTACK
            .padding(10)
        } //:- VSTACK
        .frame(width: 300, height: UIScreen.screenHeight - 400)
        .listStyle(.plain)
    } //:- View
}

// MARK: - PREVIEW
struct CurrentMonthExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentMonthExpenseView()
    }
}

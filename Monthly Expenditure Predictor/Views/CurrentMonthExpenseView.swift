//
//  CurrentMonthExpenseView.swift
//  Monthly Expenditure Predictor
//
//  Created by SADAT AHMED on 2023/07/24.
//

import SwiftUI

struct CurrentMonthExpenseView: View {
    // MARK: - PROPERTIES
    @ObservedObject var vm = CurrentMonthExpenditureViewModel()
    
    // MARK: - VIEW
    var body: some View {
        VStack {
            HStack {
                Text("Date")
                    .fontWeight(.medium)
                Spacer()
                Text("Price")
                    .fontWeight(.medium)
            } //:- HSTACK
            .padding(.horizontal, 15)
            List(vm.dailyExpense) { expense in
                HStack {
                    Text(expense.date)
                        .font(Font.system(size: 14))
                    Spacer()
                    Text("৳ \(expense.price)")
                        .font(Font.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("PrimaryBackgroundColor"))
                } //:- HSTACK
                .listRowBackground(Color.clear)
            } //:- LIST
            .padding(.bottom, 30)
        } //:- VSTACK
        .frame(width: 300, height: 450)
        .listStyle(.plain)
    }
}

// MARK: - PREVIEW
struct CurrentMonthExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentMonthExpenseView()
    }
}

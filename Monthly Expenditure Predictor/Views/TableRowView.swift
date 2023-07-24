//
//  TableRowView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import SwiftUI
import Foundation

struct TableRowView: View {
    let record: ExpenditureRecord

    var body: some View {
        ScrollView {
            HStack {
                Text("\(record.dateProcessed)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(15)
                Spacer()
                Text(record.productName)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(15)
                Spacer()
                Text("\(record.productQuantity)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(15)
                Spacer()
                Text("\(record.productPrice)")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color("PrimaryBackgroundColor"))
                    .cornerRadius(15)
            }
        }
        .listRowBackground(
            Color("SecondaryBackgroundColor")
        )
        .padding(0)
    }
}

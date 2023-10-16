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
                    .font(Font.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(15)
                Spacer()
                Text(record.productName)
                    .font(Font.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(15)
                Spacer()
                Text("\(record.productQuantity)")
                    .font(Font.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(15)
                Spacer()
                Text("৳\(record.productPrice)")
                    .font(Font.system(size: 12))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Constant.primaryBgColor)
                    .cornerRadius(15)
            }
        }
        .listRowBackground(
            Constant.secondaryBgColor
        )
        .padding(0)
    }
}

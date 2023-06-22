//
//  TableRowView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import SwiftUI

struct TableRowView: View {
    let record: ExpenditureRecord

    var body: some View {
        HStack {
            Text(record.productName)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("\(record.productQuantity)")
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            Text("$\(record.productPrice)")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

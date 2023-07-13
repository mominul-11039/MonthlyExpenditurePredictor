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
        ZStack {
            HStack {
                Text("\(record.dateProcessed)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("app_bg").opacity(0.7))
                Spacer()
                Text(record.productName)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("app_bg").opacity(0.7))
                Spacer()
                Text("\(record.productQuantity)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("app_bg").opacity(0.7))
                Spacer()
                Text("\(record.productPrice)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("app_bg").opacity(0.7))
            }
        }
    }
}

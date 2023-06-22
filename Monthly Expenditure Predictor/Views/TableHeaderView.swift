//
//  TableHeaderView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import SwiftUI

struct TableHeaderView: View {
    var body: some View {
        HStack {
            Text("Product Name")
            //.frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("Quantity")
            //.frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            Text("Price")
            //.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.headline)
        .padding(.horizontal)
    }
}


struct TableHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TableHeaderView()
    }
}

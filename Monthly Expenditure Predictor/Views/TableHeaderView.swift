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
            Text("Date")
                .font(Font.system(size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.medium)
                .frame(alignment: .center)
            Spacer()
            Text("Product\nName")
                .font(Font.system(size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.medium)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Quantity")
                .font(Font.system(size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.medium)
                .frame(alignment: .center)
            Spacer()
            Text("Price")
                .font(Font.system(size: 14))
                .foregroundColor(Color.black)
                .fontWeight(.medium)
                .frame(alignment: .center)
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

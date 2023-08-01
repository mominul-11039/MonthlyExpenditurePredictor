//
//  EmptyRecordView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 22/6/23.
//

import SwiftUI

struct EmptyRecordView: View {
    var state = 0
    var body: some View {
        VStack {
            Image(systemName: Constant.emptyRecordViewIcon)
                .resizable()
                .foregroundColor(Constant.primaryBgColor).opacity(0.7)
                .frame(width: UIScreen.screenWidth/6, height: UIScreen.screenHeight/12)
                .cornerRadius(15)
            Text(state == 0 ? Constant.selectYearMonthMessage : state == 2 ? Constant.selectYearFirstMessage : Constant.noExpenseDataMessage)
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.7))
                .fontWeight(.semibold)
                .padding(20)
                .buttonStyle(PlainButtonStyle()) 
        }
    }
}

struct EmptyRecordView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRecordView()
    }
}

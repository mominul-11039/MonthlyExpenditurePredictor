//
//  EmptyRecordView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 22/6/23.
//

import SwiftUI

struct EmptyRecordView: View {
    var body: some View {
        Text("Please Select Year & Month Properly!")
            .font(.title)
            .fontWeight(.semibold)
            .padding(20)
            .frame(alignment: .center)
            .multilineTextAlignment(.center)
            .background(Color("app_bg"))
           .cornerRadius(20)

    }
}

struct EmptyRecordView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRecordView()
    }
}

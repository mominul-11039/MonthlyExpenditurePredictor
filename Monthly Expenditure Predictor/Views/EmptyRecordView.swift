//
//  EmptyRecordView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 22/6/23.
//

import SwiftUI

struct EmptyRecordView: View {
    var body: some View {
        VStack {
            Image(systemName: "bookmark.slash")
                .resizable()
                .foregroundColor(Color.black).opacity(0.7)
                .frame(width: UIScreen.screenWidth/6, height: UIScreen.screenHeight/12)
                .cornerRadius(15)
            Text("Please Select Year & Month Properly!")
                .font(.footnote)
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

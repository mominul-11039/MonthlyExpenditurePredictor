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
                .foregroundColor(Color.black)
                .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/7)
                .cornerRadius(15)
            Text("Please Select Year & Month Properly!")
                .font(.subheadline)
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

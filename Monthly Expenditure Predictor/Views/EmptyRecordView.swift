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
            Image(systemName: "list.bullet.rectangle.fill")
                .resizable()
                .foregroundColor(Color.black).opacity(0.7)
                .frame(width: UIScreen.screenWidth/6, height: UIScreen.screenHeight/12)
                .cornerRadius(15)
            Text(state == 0 ? "Please Select Year & Month" : state == 2 ? "Please select year first then month!" : "No expense data available!")
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

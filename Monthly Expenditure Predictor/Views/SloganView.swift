//
//  SloganView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 1/8/23.
//

import SwiftUI

struct SloganView: View {
    var body: some View {
        VStack{
            Image(Constant.appIcon)
                .resizable()
                .imageScale(.small)
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
            Text(Constant.appName)
                .fontWeight(.heavy)
                .font(.system(size: 24))
                .foregroundColor(.black.opacity(0.6))
            Text(Constant.appSlogan2)
                .fontWeight(.heavy)
                .font(.system(size: 12))
                .foregroundColor(.black.opacity(0.5))
        }
    }
}

struct SloganView_Previews: PreviewProvider {
    static var previews: some View {
        SloganView()
    }
}

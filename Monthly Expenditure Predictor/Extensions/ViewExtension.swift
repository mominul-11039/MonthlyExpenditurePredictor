//
//  ViewExtension.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 22/6/23.
//

import Foundation
import SwiftUI
extension View {
    func styledTextField() -> some View {
        return self
            .frame(maxHeight: 24)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
    func styledHeader() -> some View{
        return self
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(Constant.primaryBgColor)
    }
    
    func registrationButtonStyle()-> some View{
        return self
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(8)
    }
}

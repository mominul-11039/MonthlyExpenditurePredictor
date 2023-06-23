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
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
    
    func registrationButtonStyle()-> some View{
        return self
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
    }
}

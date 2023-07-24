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
            .background(Color.blue)
            .cornerRadius(8)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape( RoundedCorner(radius: radius, corners: corners) )
        }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

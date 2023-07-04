//
//  LogoutView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 4/7/23.
//

import Foundation
import SwiftUI

struct LogoutButtonView: View {
    @EnvironmentObject var sessionManager: SessionManager
    // MARK: - VIEW
    var body: some View {
        HStack {
            Capsule()
                .fill(.ultraThinMaterial)
                .frame(width: 125, height: 60)
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                .overlay(
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 30)
                        .tint(.red.opacity(0.6))
                )
                .padding(.trailing, -45)
                .onTapGesture {
                    sessionManager.logout()
                }
        } //: HSTACK
    }
}

struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

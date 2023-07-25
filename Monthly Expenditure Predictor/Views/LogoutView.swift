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
            Text("Logout")
                .foregroundColor(Color.red)
            Spacer()
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.trailing, 15)
                .tint(.red.opacity(0.6))
        } //: HSTACK
        .onTapGesture {
            DispatchQueue.main.async {
                sessionManager.logout()
            }
        }
    }
}

struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

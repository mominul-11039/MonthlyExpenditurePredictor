//
//  DashBoardView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import SwiftUI

struct DashBoardView: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ProfileButtonView()
                    Spacer()
                    LogoutButtonView()
                        .environmentObject(sessionManager)
                }
                Spacer()
            } //: VSTACK
        } //: NAVIGATION VIEW
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}

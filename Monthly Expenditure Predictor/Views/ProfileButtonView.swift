//
//  ProfileButtonView.swift
//  Monthly Expenditure Predictor
//
//  Created by SADAT AHMED on 2023/06/16.
//

import SwiftUI

struct ProfileButtonView: View {
    
    // MARK: - VIEW
    var body: some View {
        HStack {
            NavigationLink(destination: UserProfileView()) {
                Capsule()
                    .fill(.ultraThinMaterial)
                    .frame(width: 125, height: 60)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                    .overlay(
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .padding(10)
                            .padding(.leading, 30)
                            .tint(.red.opacity(0.6))
                    )
                    .padding(.leading, -45)
            } //: NAVIGATION
            Spacer()
        } //: HSTACK
    }
}

struct ProfileButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtonView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

//
//  UserProfileView.swift
//  Monthly Expenditure Predictor
//
//  Created by SADAT AHMED on 2023/06/16.
//

import SwiftUI

struct UserProfileView: View {
    // MARK: - PROPERTIES
    @State private var isShimmering = false
    @ObservedObject var vm: ProfileViewModel = ProfileViewModel()
    
    // MARK: - VIEW
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.userInfo, id: \.self) { user in
                    Section(header: Text("Profile")) {
                        VStack {
                            ZStack {
                                Image("AvaterImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 60)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.clear, .white.opacity(0.4), .clear]),
                                                    startPoint: UnitPoint(x: 0.7, y: 0.7),
                                                    endPoint: UnitPoint(x: 0.3, y: 0.3)
                                                )
                                            )
                                            .mask(
                                                Rectangle()
                                                    .frame(width: 150, height: 150)
                                                    .offset(x: isShimmering ? -400 : 400, y: 0)
                                            )
                                    )
                                    .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false))
                                Circle()
                                    .frame(width: 45)
                                    .padding(.top, 70)
                                    .padding(.leading, 70)
                                    .foregroundColor(.black.opacity(0.4))
                                    .overlay(
                                        Text("\(user.userAge)")
                                            .frame(width: 45)
                                            .padding(.top, 70)
                                            .padding(.leading, 70)
                                            .foregroundColor(.white)
                                            .font(.system(size: 19, weight: .bold, design: .rounded))
                                    )
                            }
                            
                            Text(user.fullName)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onAppear {
                            isShimmering = true
                        }
                    }
                    
                    Section(header: Text("Personal Information")) {
                        InfoRow(label: "Family Member", value: "\(user.userNoOfFamilyMember)")
                        InfoRow(label: "Email", value: "\(user.userEmail)")
                        //InfoRow(label: "Phone", value: "+1 123-456-7890")
                    }
                    
                    Section(header: Text("Address")) {
                        Text(user.userAddress)
                            .multilineTextAlignment(.center)
                    }
                }
                .listStyle(.grouped)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}
struct InfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - PREVIEW
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(vm: ProfileViewModel())
    }
}

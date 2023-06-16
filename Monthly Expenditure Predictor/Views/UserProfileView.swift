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
    
    // MARK: - VIEW
    var body: some View {
        NavigationView {
            List {
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
                        }
                        
                        Text("John Doe")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onAppear {
                        isShimmering = true
                    }
                }
                
                Section(header: Text("Contact Information")) {
                    InfoRow(label: "Email", value: "johndoe@example.com")
                    InfoRow(label: "Phone", value: "+1 123-456-7890")
                }
                
                Section(header: Text("Bio")) {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .multilineTextAlignment(.center)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Profile")
        }
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
        UserProfileView()
    }
}

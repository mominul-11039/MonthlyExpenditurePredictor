//
//  IntialScreen.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 13/6/23.
//

import SwiftUI

struct InitialScreenView: View {
    @State private var isDiaryVisible = false
    @State private var isNavigationActive = false


    var body: some View {
        NavigationView {
            ZStack {
                Color("app_bg")
                VStack {
                    Image("bill_prev_ui")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .offset(x: isDiaryVisible ? 0 : -300, y: 0)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 10))
                        .opacity(isDiaryVisible ? 1 : 0)

                    NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true), isActive: $isNavigationActive) {
                        Button(action: {
                            isNavigationActive = true
                        }) {

                            Text("Login or Register")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(Color("tint_color").opacity(0.8))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all) // Extend the background color to edges
            .onAppear {
                withAnimation {
                    isDiaryVisible = true
                }
            }
        }
    }
}

struct InitialScreenView_Previews: PreviewProvider {
    static var previews: some View {
        InitialScreenView()
    }
}

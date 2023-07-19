//
//  IntialScreen.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 13/6/23.
//

import SwiftUI

struct InitialScreenView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var isAnimating = false
    @State private var isNavigationActive = false
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0


    var body: some View {
        NavigationView {
            if sessionManager.isLoggedIn {
                HomeScreen(tabSelection: .home)
                    .environmentObject(sessionManager)
            } else {
                ZStack {
                    Color("AppBackground")
                        .ignoresSafeArea(.all,edges: .all)
                    VStack {
                        VStack{
                            Text("SpendWise")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color("PrimaryBackgroundColor"))
                                .padding(.vertical, 8)
                            Text("""
                            The simple and efficient expense tracker app to effortlessly manage your finances on the go
                            """)
                            .font(.system(size: 16))
                              .fontWeight(.light)
                              .foregroundColor(.gray)
                              .multilineTextAlignment(.center)
                              .padding(.horizontal, 18)
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -40)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        
                        Image("InitialScreenImage")
                            .resizable()
                            .scaledToFit()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeOut(duration: 1), value: isAnimating)
                            .animation(.interpolatingSpring(stiffness: 100, damping: 25))
                            .opacity(isAnimating ? 1 : 0)
                        
                        Spacer()
                        
                        ZStack{
                            // Background
                            Capsule(style: .circular)
                                .fill(Color.gray.opacity(0.2))
                                
                            Capsule(style: .circular)
                                .fill(Color.gray.opacity(0.2))
                                .padding(8)
                            
                            // Call to action
                            Text("Get Started")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryBackgroundColor"))
                                .offset(x: 20)
                        
                            // Dynamic capsul
                            HStack{
                                Capsule()
                                    .fill(Color("PrimaryBackgroundColor"))
                                    .frame(width: buttonOffset + 80, alignment: .center)
                                Spacer()
                            }//:Dynamic Capsul
                            HStack{
                                ZStack{
                                    Circle()
                                        .fill(Color("PrimaryBackgroundColor"))
                                    Circle()
                                        .fill(.black.opacity(0.15))
                                        .padding(8)
                                    Image(systemName: "chevron.forward.2")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                }
                                .frame(width: 80, height: 80, alignment: .center)
                                .offset(x: buttonOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ dragGesture in
                                            let gestureWidth = dragGesture.translation.width
                                            if gestureWidth > 0 && gestureWidth <= buttonWidth-80 {
                                                buttonOffset = gestureWidth
                                            }
                                        })
                                        .onEnded({ dragGesture in
                                            let gestureWidth = dragGesture.translation.width
                                            if gestureWidth <= buttonWidth/2 {
                                                buttonOffset = 0
                                            }else{
                                                buttonOffset = buttonWidth - 80
                                                isNavigationActive = true
                                            }
                                        })
                                )//: gesture
                                Spacer()
                            }//:Hstack
                               
                        }//: Footer
                        .frame(width:buttonWidth, height: 80)
                        .padding()
                        
                        NavigationLink("", destination:
                                        LoginScreen()
                            .environmentObject(sessionManager)
                            .navigationBarBackButtonHidden(true), isActive: $isNavigationActive)
                    }
                }
                .onAppear {
                    withAnimation {
                        isAnimating = true
                    }
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

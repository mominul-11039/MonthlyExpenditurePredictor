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
                // MARK: - Background View
                ZStack {
                    Constant.appBackground
                        .ignoresSafeArea(.all,edges: .all)
                    VStack {
                        // MARK: - Header View
                        VStack{
                            Text(Constant.appName)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Constant.primaryBgColor)
                                .padding(.vertical, 8)
                            Text(Constant.appSlogan)
                            .font(.system(size: 16))
                              .fontWeight(.light)
                              .foregroundColor(.gray)
                              .multilineTextAlignment(.center)
                              .padding(.horizontal, 18)
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -40)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        // MARK: - Document Image View
                        Image(Constant.onBoardingScreenImage)
                            .resizable()
                            .scaledToFit()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeOut(duration: 1), value: isAnimating)
                            .animation(.interpolatingSpring(stiffness: 100, damping: 25))
                            .opacity(isAnimating ? 1 : 0)
                        
                        Spacer()
                        // MARK: - Footer
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
                                .foregroundColor(Constant.primaryBgColor)
                                .offset(x: 20)
                        
                            // Dynamic capsul
                            HStack{
                                Capsule()
                                    .fill(Constant.gradientBG)
                                    .frame(width: buttonOffset + 80, alignment: .center)
                                Spacer()
                            }//:Dynamic Capsul
                            HStack{
                                ZStack{
                                    Circle()
                                        .fill(Constant.gradientBG)
                                    Circle()
                                        .fill(.black.opacity(0.10))
                                        .padding(8)
                                    Image(systemName: Constant.forwardIcon)
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
                                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                                    impactMed.impactOccurred()
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
        InitialScreenView().environmentObject(SessionManager())
    }
}

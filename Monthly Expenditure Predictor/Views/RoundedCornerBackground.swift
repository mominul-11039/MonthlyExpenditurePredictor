//
//  RoundedCornerBackground.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 19/7/23.
//

import SwiftUI


struct RoundedCornerBackground<Content: View>: View {
    var content: Content
    var header: Content
    let backgroundColor: Color
    let screenHeight = UIScreen.screenHeight
    
    init(backgroundColor:Color, @ViewBuilder content: () -> Content, @ViewBuilder header: () -> Content) {
        self.content = content()
        self.header = header()
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                ZStack {
                    backgroundColor
                        header
                        }
                .cornerRadius(50, corners: [.bottomRight])
                .frame(width: .infinity, height: screenHeight * 0.20)
                .ignoresSafeArea(edges: .top)
                .padding(.trailing, 0)
                
                ZStack {
                    backgroundColor
                        content
                        }
                .cornerRadius(50, corners: [.topLeft])
                .frame(width: .infinity)
                .ignoresSafeArea(edges: .bottom)
                .padding(.leading, 0)
                
            }
        }
        
       
    }
}


struct RoundedCornerBackground_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}



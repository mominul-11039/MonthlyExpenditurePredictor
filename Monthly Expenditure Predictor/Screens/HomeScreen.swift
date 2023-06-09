//
//  HomeScreen.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var tabSelection: TabBarItem

    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            DashBoardView()
                .tabBarView(tab: .home, selection: $tabSelection)
                .environmentObject(sessionManager)
            MonthlyExpenditureView()
                .tabBarView(tab: .expenditure, selection: $tabSelection)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(tabSelection: .home)
    }
}

//
//  DashBoardView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import SwiftUI

struct DashBoardView: View {
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    @StateObject var viewModel = DashBoardViewModel()
    @State var screenHeight = UIScreen.screenHeight

    var body: some View {
        VStack {
            HomeBackGroundView()
                .background(Constant.gradientBG.opacity(0.8))
        } //: VSTACK
        .padding(EdgeInsets(top: 40, leading: 0, bottom: 100, trailing: 0))
    }
}
// MARK: - Preview
struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}

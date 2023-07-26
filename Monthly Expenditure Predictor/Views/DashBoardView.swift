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
        .padding(EdgeInsets(top: 40, leading: 0, bottom: 60, trailing: 0))
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}




//HStack {
//    ProfileButtonView()
//    Spacer()
//    LogoutButtonView()
//        .environmentObject(sessionManager)
//}
//VStack{
//    HStack{
//        Spacer()
//        Button(action: {
//            self.showScannerSheet = true
//        }, label: {
//            Image(systemName: "doc.text.magnifyingglass")
//                .font(.title)
//        })
//        .sheet(isPresented: $showScannerSheet, content: {
//            self.makeScannerView()
//        })
//    }
//    if texts.count > 0{
//        List{
//            ForEach(texts){text in
//                let items = viewModel.extractItems(from: text.content)
//                NavigationLink(
//                    destination: DailyExpenditureEditableView(viewModel: DailyExpenditureEditableViewModel(items: items))) {
//                        Text(viewModel.storeName)
//                    }
//            }
//        }
//        .listStyle(.grouped)
//
//    }
//    else{
//        Text("No scan yet").font(.title)
//    }
//}
//Spacer()

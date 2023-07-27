//
//  ScanView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 21/7/23.
//

import SwiftUI


struct ScanView: View {
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    @StateObject var viewModel = DashBoardViewModel()
    @State private var screenHeight: Double = UIScreen.main.bounds.height
    @State private var screenWidth: Double = UIScreen.main.bounds.width
    var body: some View {
        ZStack{
            Color("listBackground")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Scan Document")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.7))
                    Spacer()
                }
                .padding(18)
                   
                if texts.count > 0 && viewModel.isValidDocument  {
                    List{
                        ForEach(texts){text in
                            let items = viewModel.extractItems(from: text.content)
                            NavigationLink(
                                destination: DailyExpenditureEditableView(viewModel: DailyExpenditureEditableViewModel(items: items))) {
                                    Text(viewModel.storeName)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Constant.primaryBgColor)
                                }
                                .accentColor(Constant.primaryBgColor)
                        }
                        
                    }
                    .listStyle(.automatic)
                    
                }
                else{
                    Spacer()
                    if !viewModel.isValidDocument{
                        Text("The scanned document is not valid! Please, try again with a valide document")
                            .font(.system(.caption2))
                            .foregroundColor(.red)
                            .padding(20)
                            .multilineTextAlignment(.center)
                            
                    }
                    VStack{
                        Image("EmptyData")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 20)
                           
                        Text("No scan data").font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                
                // MARK: Camera
                HStack{
                    Spacer()
                    Button(action: {
                        self.showScannerSheet = true
                        print(showScannerSheet)
                    }, label: {
                        Image(systemName: "camera.viewfinder")
                            .font(.title)
                    })
                    .padding()
                    .background(Constant.gradientBG)
                                
                                .foregroundColor(.white)
                                .clipShape(Circle())
                    .sheet(isPresented: $showScannerSheet, content: {
                        self.makeScannerView()
                    })
                }
                .padding(.trailing, 36)
                .padding(.bottom, 60)
            }
            //: VSTACK
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 60, trailing: 0))
        }
        
    }
    
    // MARK: ScannerView
    private func makeScannerView()-> DocumentCameraView {
        DocumentCameraView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}


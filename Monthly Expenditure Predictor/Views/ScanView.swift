//
//  ScanView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 21/7/23.
//

import SwiftUI


struct ScanView: View {
    @State private var showScannerSheet = false
    @ObservedObject var viewModel = DashBoardViewModel()
    @State private var screenHeight: Double = UIScreen.main.bounds.height
    @State private var screenWidth: Double = UIScreen.main.bounds.width
    @State private var itemsArray:[Items] = []
    var body: some View {
        ZStack{
            Color("listBackground")
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "doc.viewfinder.fill")
                        .foregroundColor(Constant.primaryBgColor)
                        .font(.system(size: 34))
                    
                    Text("Scan Document")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(.black.opacity(0.6))
                    Spacer()
                }
                .padding(20)
                
                if itemsArray.count > 0 && !viewModel.showAlert {
                    List{
                        ForEach($itemsArray){$items in
                            NavigationLink(
                                destination: DailyExpenditureEditableView(items: items.content)) {
                                    Text(items.storeName)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Constant.primaryBgColor)
                                }
                                .accentColor(Constant.primaryBgColor)
                        }
                    }
                    .listStyle(.automatic)
                }
                else{
                    Spacer()
                    if itemsArray.count > 0 {
                        List{
                            ForEach($itemsArray){$items in
                                NavigationLink(
                                    destination: DailyExpenditureEditableView(items: items.content)) {
                                        Text(items.storeName)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Constant.primaryBgColor)
                                    }
                                    .accentColor(Constant.primaryBgColor)
                            }
                        }
                        .listStyle(.automatic)
                    }else{
                        VStack{
                            Image("EmptyData")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .padding(.bottom, 20)
                            
                            Text("No scan data").font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }//:-Vstack
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
        }.alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text("Invalid Document"),
                  message: Text("The scanned document is not valid! Please try again with a valid document."),
                  primaryButton: .default(Text("Cancel"), action: {
//                self.itemsArray = []
                viewModel.showAlert = false
            }),
                  secondaryButton: .default(Text("Try Again"), action: {
//                self.itemsArray = []
                self.showScannerSheet = true
            })//:- secondary button
            ) //:- Alert
        })//:- .alert
    }
    
    // MARK: ScannerView
    private  func makeScannerView()-> DocumentCameraView {
        DocumentCameraView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanData(content: outputText)
                let data = viewModel.extractItems(from: newScanData.content)
                if !data.isEmpty{
                    self.itemsArray.append(Items(content: data, storeName: viewModel.storeName))
                }
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


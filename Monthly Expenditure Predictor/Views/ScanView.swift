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
    
    // MARK: - View
    var body: some View {
        // MARK: - BackgroundView
        ZStack{
           Constant.listBackground 
                .ignoresSafeArea()
            // MARK: - Contents View
            VStack{
                // MARK: Title
                HStack{
                    Image(systemName: Constant.documentViewFinderIcon)
                        .foregroundColor(Constant.primaryBgColor)
                        .font(.system(size: 34))
                    Text("Scan Document")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(.black.opacity(0.6))
                    Spacer()
                } //:- Title
                .padding(.top, 30)
                .padding(.horizontal, 20)
                // MARK: Document list
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
                    // If there is items show
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
                    }else{ // otherwise show empty screen
                        VStack{
                            Image(Constant.emptyImage)
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
                //:- Document List
                
                // MARK: Camera
                HStack{
                    Spacer()
                    Button(action: {
                        self.showScannerSheet = true
                        print(showScannerSheet)
                    }, label: {
                        Image(systemName: Constant.cameraScannerIcon)
                            .font(.title)
                    })
                    .padding()
                    .background(Constant.gradientBG)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .sheet(isPresented: $showScannerSheet, content: {
                        self.makeScannerView()
                    })
                } //:- Camera
                .padding(.trailing, 36)
                .padding(.bottom, 60)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 1)
            }//: - Contents view
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 60, trailing: 0))
        }.alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(Constant.invalidDocumentTitle),
                  message: Text(Constant.invalidDocumentMessage),
                  primaryButton: .default(Text("Cancel"), action: {
                
                viewModel.showAlert = false
            }),
                  secondaryButton: .default(Text("Try Again"), action: {
                
                self.showScannerSheet = true
            })//:- secondary button
            )})//:- .alert
        .navigationBarHidden(true)
    }
    
    // MARK: - ScannerView
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

// MARK: - Preview

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}


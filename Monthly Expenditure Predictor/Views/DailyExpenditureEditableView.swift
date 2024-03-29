//
//  DailyExpenditureEditableView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 12/6/23.
//

import SwiftUI
import CloudKit

struct DailyExpenditureEditableView: View {
        @ObservedObject var viewModel: DailyExpenditureEditableViewModel = DailyExpenditureEditableViewModel(items: [])
        private let currencyFormatter: NumberFormatter
       @State var deviceWidth = UIScreen.main.bounds.width
    
        init(items: [Item]) {
            currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.decimalSeparator = ","
            currencyFormatter.maximumFractionDigits = 2
            self.viewModel = DailyExpenditureEditableViewModel(items: items)
            UINavigationBar.appearance().barTintColor = UIColor(Constant.primaryBgColor)
        }
    
    var body: some View {
        ZStack{
            Constant.listBackground
                .ignoresSafeArea()
            VStack{List {
                    Section{
                        ForEach($viewModel.items.indices, id: \.self) { index in
                            HStack {
                                TextEditor(text: $viewModel.items[index].name)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.secondary)
                                TextField("Quantity", value: $viewModel.items[index].quantity, formatter: NumberFormatter())
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.secondary)
                                TextField("Price", value: $viewModel.items[index].price, formatter: currencyFormatter)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }header: {
                        HStack(){
                            Text("Item")
                                .multilineTextAlignment(.leading)
                                .styledHeader()
                                .frame(alignment: .leading)
                                
                            Text("Quantity")
                                .styledHeader()
                               
                            Text("Price")
                                .styledHeader()
                        }
                        .padding(0)
                    }
                    .padding(0)
                }
            .listStyle(.plain)
                .navigationTitle("Save To CloudKit")
                .navigationBarTitleDisplayMode(.inline)
                
                Button(action: {
                    viewModel.saveToCloudKit()
                }, label: {Text("Submit")
                        .font(.system(.subheadline))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: deviceWidth * 0.8, height: 40)
                        .background(Constant.gradientBG)
                        .cornerRadius(8)
                        .padding(10)
                })
            }
            if viewModel.willShowLoader {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Constant.secondaryBgColor)
            }
        }
        .alert(isPresented: $viewModel.isError, content: {
            Alert(title: Text(Constant.wrongAlertTitle),
                  message: Text(Constant.notAvailableMessage),
                  primaryButton: .default(Text("Cancel"), action: {
                
                viewModel.isError = false
            }),
                  secondaryButton: .default(Text("Try Again"), action: {
                  viewModel.saveToCloudKit()
            })//:- secondary button
            )})
    }
       
        
    
    struct DailyExpenditureEditableView_Previews: PreviewProvider {
        static var previews: some View {
            DailyExpenditureEditableView(items: [])
        }
    }
}

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
            VStack{
                if viewModel.isError {
                    Text("Something Went Wrong! Please Try Again" )
                        .font(.system(.callout))
                        .foregroundColor(.red)
                        .padding(20)
                }
               
                List {
                    Section{
                        ForEach($viewModel.items.indices, id: \.self) { index in
                            HStack {
                                //                    TextField("Item Description", text: $items[index].name)
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
                                .styledHeader()
                                
                            Text("Quantity")
                                .styledHeader()
                               
                            Text("Price")
                                .styledHeader()
                                
                        }
                            
                    }
                }
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
                    .background(Color("SecondaryBackgroundColor"))
            }
        }
    }
        
    
    struct DailyExpenditureEditableView_Previews: PreviewProvider {
        static var previews: some View {
            DailyExpenditureEditableView(items: [])
        }
    }
}

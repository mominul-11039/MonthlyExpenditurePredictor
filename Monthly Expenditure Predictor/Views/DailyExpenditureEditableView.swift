//
//  DailyExpenditureEditableView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 12/6/23.
//

import SwiftUI
import CloudKit

struct DailyExpenditureEditableView: View {
        @ObservedObject var viewModel:DailyExpenditureEditableViewModel
        private let currencyFormatter: NumberFormatter
        
        init(viewModel : DailyExpenditureEditableViewModel) {
            currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.decimalSeparator = ","
            currencyFormatter.maximumFractionDigits = 2
            self.viewModel = viewModel
            UINavigationBar.appearance().tintColor = UIColor(Constant.primaryBgColor)

                        
        }
    
    var body: some View {
        ZStack{
            Constant.listBackground
                .ignoresSafeArea()
            VStack{
                List {
                    HStack(alignment: .center){
                        Text("Item")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 12))
                            .foregroundColor(Constant.primaryBgColor)
                        Text("Quantity")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 12))
                            .foregroundColor(Constant.primaryBgColor)

                        Text("Price")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 12))
                            .foregroundColor(Constant.primaryBgColor)

                    }
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
                }
                .navigationTitle("Save to CloudKit")
                .navigationBarTitleDisplayMode(.automatic)
                
                Button(action: {
                    viewModel.saveToCloudKit()
                }, label: {Text("Submit")
                        .font(.system(.subheadline))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    
                })
                .padding()
                            .buttonStyle(.borderedProminent)
                            .tint(Constant.primaryBgColor)
                            
            }
        }
    }
        
    
    struct DailyExpenditureEditableView_Previews: PreviewProvider {
        static var previews: some View {
            DailyExpenditureEditableView(viewModel: DailyExpenditureEditableViewModel(items: []))
        }
    }
}

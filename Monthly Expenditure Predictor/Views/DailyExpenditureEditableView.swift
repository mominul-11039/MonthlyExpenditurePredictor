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
        }
    
    var body: some View {
        List {
            HStack(alignment: .center){
                Text("Item")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 12))
                Text("Quantity")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 12))
                Text("Price")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 12))
            }
            ForEach($viewModel.items.indices, id: \.self) { index in
                HStack {
                    //                    TextField("Item Description", text: $items[index].name)
                    TextEditor(text: $viewModel.items[index].name)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .font(.system(size: 12))
                    TextField("Quantity", value: $viewModel.items[index].quantity, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .font(.system(size: 12))
                    TextField("Price", value: $viewModel.items[index].price, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                        .font(.system(size: 12))
                    
                }
            }
        }
        Button(action: {
//            let record = CKRecord(recordType: "expenditure_info")
//            record["product_name"] = "hello"
//            record["category"] = "entertainment"
//            record["date"] = 10101010
//            record["product_price"] = 10
//            record["product_quantity"] = 10
//            record["user_email"] = "email@email.com"
//
//            let record2 = CKRecord(recordType: "expenditure_info")
//            record2["product_name"] = "name2"
//            record2["category"] = "name2"
//            record2["date"] = 101010102
//            record2["product_price"] = 102
//            record2["product_quantity"] = 102
//            record2["user_email"] = "name2"
//
//            let item = ExpenditureRecord(record: record)
//            let item2 = ExpenditureRecord(record: record2)
//            let items:[ExpenditureRecord] = [item, item2].compactMap { $0 }
            viewModel.saveToCloudKit()
            
        }, label: {Text("Save").font(.system(.title3))})
    }
    
    struct DailyExpenditureEditableView_Previews: PreviewProvider {
        static var previews: some View {
            DailyExpenditureEditableView(viewModel: DailyExpenditureEditableViewModel(items: []))
        }
    }
}

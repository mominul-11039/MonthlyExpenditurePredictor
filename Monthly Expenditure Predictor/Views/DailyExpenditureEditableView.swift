//
//  DailyExpenditureEditableView.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 12/6/23.
//

import SwiftUI
struct Item: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Int
    var price: Double
}

struct DailyExpenditureEditableView: View {
    @State private var items: [Item] = [
        Item(name: "Item 1", quantity: 10, price: 10.5),
        Item(name: "Item 2", quantity: 5, price: 12.5),
        Item(name: "Item 3", quantity: 3, price: 16000.3)
    ]
    
    private let currencyFormatter: NumberFormatter

    init() {
          currencyFormatter = NumberFormatter()
          currencyFormatter.numberStyle = .currency
          currencyFormatter.decimalSeparator = ","
          currencyFormatter.maximumFractionDigits = 2
        }
    
    var body: some View {
        List {
            HStack(alignment: .center){
                Text("Item")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Quantity")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Price")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    
            }
            ForEach(items.indices, id: \.self) { index in
                HStack {
                    TextField("Item Description", text: $items[index].name)
                        .multilineTextAlignment(.center)
                    TextField("Quantity", value: $items[index].quantity, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                    TextField("Price", value: $items[index].price, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
                    
                }
                
            }
        }
        
    }
    
    
    struct DailyExpenditureEditableView_Previews: PreviewProvider {
        static var previews: some View {
            DailyExpenditureEditableView()
        }
    }
}

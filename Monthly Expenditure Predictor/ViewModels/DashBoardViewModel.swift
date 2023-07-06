//
//  DashBoardViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 5/7/23.
//

import Foundation
import CloudKit
class DashBoardViewModel: ObservableObject{
    
    var storeName = ""
    
//     MARK: Extract items from vndocument
     func extractItems(from text: String) -> [Item] {
        var items: [Item] = []
        var lines = text.components(separatedBy: .newlines)
         storeName = lines[0]
         lines.removeFirst(5)

        for (index, line) in lines.enumerated() {
              if index % 3 == 0 {
                  let item = Item(name: line, quantity: 0, price: 0)
                  items.append(item)
              } else if index % 3 == 1 {
                  items[items.count - 1].quantity = Int(line) ?? 0
              } else if index % 3 == 2 {
                  items[items.count - 1].price = Double(line) ?? 0
              }
          }
        return items
    }
    
    
}

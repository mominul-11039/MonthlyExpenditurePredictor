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
    @Published var showAlert = false
    
    fileprivate func documentNotValid() {
        DispatchQueue.main.async {[weak self] in
            self?.storeName = ""
            self?.showAlert = true
        }
    }
    
    fileprivate func documentValid() {
        DispatchQueue.main.async {[weak self] in
            
            self?.showAlert = false
        }
    }
//      MARK: - Extract items
    func extractItems(from text: String) -> [Item]{
       print(text)
        if !text.contains("Product Name") || !text.contains("Product Quantity") || !text.contains("Total price"){
            documentNotValid()
            return []
        }else{
            documentValid()
            if #available(iOS 16.0, *) {
                return extractItem16Devv(from: text)
            } else {
                return extractItemsLegacy(from: text)
                
            }
        }
    }
    
    // MARK: devices legecy
    private func  extractItemsLegacy(from text: String) -> [Item] {
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
    
    // MARK: Extract item for iphone 16+ devices
    private func extractItem16Dev(from text: String) -> [Item]{
        var items: [Item] = []
        var lines = text.components(separatedBy: .newlines)
        storeName = lines[0]
        lines.removeFirst(2)
        let a = lines.count/3
        let b = a+a
        for i in 0...a-2{
            items.append(Item(name: lines[i+1], quantity: Int(lines[a+i+1]) ?? 0, price: Double(lines[b+i+1]) ?? 0.0))
        }
        return items
    }
    
    private func extractItem16Devv(from text: String)-> [Item] {
        var items: [Item] = []
        var lines = text.components(separatedBy: .newlines)

        guard lines.count >= 3 else {
           documentNotValid()
            return []
        }

        storeName = lines[0]
        lines.removeFirst(2)
        let a = lines.count / 3
        let b = a + a

        // Ensure there are enough lines to extract data for each item.
        guard a > 0, lines.count >= b + a else {
            documentNotValid()
            return []
        }

        for i in 0...(a - 2) {
            let nameIndex = i + 1
            let quantityIndex = a + i + 1
            let priceIndex = b + i + 1

            // Extract data for each item, handling potential conversion errors.
            guard let quantity = Int(lines[quantityIndex]),
                  let price = Double(lines[priceIndex]) else {
                documentNotValid()
                return []
            }
            items.append(Item(name: lines[nameIndex], quantity: quantity, price: price))
        }
        return items
    }
}

enum documentError: Error {
    case invalidDocument
    case insufficientData
}

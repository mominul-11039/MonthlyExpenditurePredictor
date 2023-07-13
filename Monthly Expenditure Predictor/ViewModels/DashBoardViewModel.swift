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
    @Published var isValidDocument = true
    @Published var items:[Item] = []

    func extractItems(from text: String) -> [Item]{
        if #available(iOS 16.0, *) {
        extractItem16Dev(from: text)
            return self.items
        } else {
        extractItemsLegacy(from: text)
            return self.items
        }
    }
   // devices < ios 16
    private func  extractItemsLegacy(from text: String) {
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
        self.items = items
    }

    // MARK: Extract item for iphone 16+ devices
    private func extractItem16Dev(from text: String){
        var items: [Item] = []
        var lines = text.components(separatedBy: .newlines)


        storeName = lines[0]
        lines.removeFirst(2)
        let a = lines.count/3
        let b = a+a
        for i in 0...a-2{
            items.append(Item(name: lines[i+1], quantity: Int(lines[a+i+1]) ?? 0, price: Double(lines[b+i+1]) ?? 0.0))
        }
        DispatchQueue.main.async { [weak self] in
            self?.items = items
        }
    }


//    // MARK: Remove storename and date from the array
//    private func removeElementsBeforeProductQuantity(_ array: [String]) -> [String] {
//        guard let productQuantityIndex = array.firstIndex(of: "Product Quantity") else {
//            return array
//        }
//        let indexToRemove = max(productQuantityIndex - 2, 0)
//        var newArray = array
//        newArray.remove(at: indexToRemove)
//        newArray.remove(at: indexToRemove)
//
//        return newArray
//    }
    
}

enum documentError: Error {
    case invalidDocument
    case insufficientData
}

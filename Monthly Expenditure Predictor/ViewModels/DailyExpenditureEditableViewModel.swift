//
//  ExpenditureEditableViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 6/7/23.
//

import Foundation
import CloudKit

class DailyExpenditureEditableViewModel: ObservableObject{
    @Published var items: [Item]
    init(items: [Item]) {
        self.items = items
    }
    
    
   private func makeCkRecordList() -> [ExpenditureRecord]{
        
        let items:[ExpenditureRecord] = items.compactMap {
            let record = CKRecord(recordType: "expenditure_info")
            record["product_name"] = $0.name
            record["category"] = "default"
            record["date"] = Int(Date().formatted())
            record["product_price"] = $0.price
            record["product_quantity"] = $0.quantity
            record["user_email"] = "email@email.com"
            return ExpenditureRecord(record: record)
        }
        return items
    }
    
    func saveToCloudKit(){
        let items = makeCkRecordList()
        CloudKitViewModel.saveItemsToCloudKit(items)
    }
}

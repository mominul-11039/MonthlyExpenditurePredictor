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
            record["date"] = Int(Date().timeIntervalSince1970)
            record["product_price"] = $0.price
            record["product_quantity"] = $0.quantity
            record["user_email"] = UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME") ?? ""
            return ExpenditureRecord(record: record)
        }
        return items
    }
    
    func saveToCloudKit(){
        let items = makeCkRecordList()
        CloudKitViewModel.saveItemsToCloudKit(items)
    }
}

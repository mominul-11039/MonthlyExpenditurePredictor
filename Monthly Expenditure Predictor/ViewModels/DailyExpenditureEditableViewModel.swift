//
//  ExpenditureEditableViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 6/7/23.
//

import Foundation
import CloudKit

class DailyExpenditureEditableViewModel: ObservableObject{
    @Published var items: [Item] = []
    @Published var willShowLoader = false
    @Published var isError = false

    init(items: [Item]) {
        self.items = items
    }
    
    
   private func makeCkRecordList() -> [ExpenditureRecord]{
        
        let items:[ExpenditureRecord] = items.compactMap {
            let record = CKRecord(recordType: Constant.expInfoRecordType)
            record[Constant.ckProductNameRecord] = $0.name
            record[Constant.ckCategoryRecord] = "default"
            record[Constant.ckDateRecord] = Int(Date().timeIntervalSince1970)
            record[Constant.ckProductPriceRecord] = $0.price
            record[Constant.ckProductQuantityRecord] = $0.quantity
            record[Constant.ckUserEmailRecord] = UserDefaults.standard.string(forKey: Constant.loggedinUserKey) ?? ""
            return ExpenditureRecord(record: record)
        }
        return items
    }
    
    func saveToCloudKit(){
        DispatchQueue.main.async {
            self.willShowLoader = true
            let items = self.makeCkRecordList()
            CloudKitViewModel.saveItemsToCloudKit(items ?? []) { status in
                DispatchQueue.main.async {
                    self.willShowLoader = false
                    self.isError = !status
                    print(self.isError)
                }
            }
        }
    }
}

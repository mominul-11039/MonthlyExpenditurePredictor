//
//  ExpenditureRecord.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 14/6/23.
//

import Foundation
import CloudKit
struct ExpenditureRecord : Hashable, CloudKitableProtocol{
    let expenditureRecordId = UUID()
    let userEmail: String
    let timestamp: Int
    let productName: String
    let productQuantity: Int
    let productPrice: Int
    let category: String
    let record: CKRecord
    let dateProcessed: String

    init?(record: CKRecord) {
        self.userEmail = record["user_email"] ?? ""
        self.timestamp = record["date"] ?? 0
        self.productName = record["product_name"] ?? ""
        self.productQuantity = record["product_quantity"] ?? 0
        self.productPrice = record["product_price"] ?? 0
        self.category = record["category"] ?? ""
        self.record = record //CKRecord(recordType: "expenditure_info")
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: TimeInterval(self.timestamp))
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.string(from: date)
        self.dateProcessed = dateFormatter.string(from: date)
    }
}

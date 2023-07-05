//
//  Item.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 4/7/23.
//

import Foundation
import CloudKit
struct Item: Identifiable{
    let id = UUID()
    var name: String
    var quantity: Int
    var price: Double
 
}

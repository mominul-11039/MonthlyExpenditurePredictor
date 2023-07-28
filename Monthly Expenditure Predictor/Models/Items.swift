//
//  Items.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 28/7/23.
//

import Foundation
struct Items:Identifiable {
    var id = UUID()
    let content:[Item]
    let storeName: String
    
    init(content:[Item], storeName: String) {
        self.content = content
        self.storeName = storeName
    }
}

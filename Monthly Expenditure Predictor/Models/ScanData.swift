//
//  ScanData.swift
//  Monthly Expenditure Predictor
//
//  Created by YeasirArefinTusher-11702 on 4/7/23.
//

import Foundation


struct ScanData:Identifiable {
    var id = UUID()
    let content:String
    
    init(content:String) {
        self.content = content
    }
}

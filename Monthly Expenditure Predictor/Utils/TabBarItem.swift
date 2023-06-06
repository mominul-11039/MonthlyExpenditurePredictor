//
//  Constant.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, expenditure
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .expenditure: return "pencil.and.ellipsis.rectangle"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .expenditure: return "Expenditure"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .expenditure: return Color.green
        }
    }
}

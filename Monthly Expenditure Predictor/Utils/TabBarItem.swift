//
//  Constant.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, expenditure, scan, profile
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .expenditure: return "pencil.and.ellipsis.rectangle"
        case .scan: return "doc.text.magnifyingglass"
        case .profile: return "person.crop.circle"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .expenditure: return "Expenditure"
        case .scan: return "Scan"
        case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color("PrimaryBackgroundColor")
        case .expenditure: return Color("PrimaryBackgroundColor")
        case .scan: return Color("PrimaryBackgroundColor")
        case .profile: return Color("PrimaryBackgroundColor")
        }
    }
}

//
//  Constant.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import Foundation
import SwiftUI

public class Constant {
    public static let cloudKitContainerName = "iCloud.TeamCombine.bjitgroup.upskilldev"
    public static let appLexiconDictionary = ["rent",
                                              "utilities",
                                              "groceries",
                                              "transportation",
                                              "entertainment",
                                              "Product Name",
                                              "Product Quantity",
                                              "Total price",
                                              "Rice",
                                              "Dal",
                                              "Mango",
                                              "Fish",
                                              "Banana",
                                              "Macbook",
                                              "iPhone",
                                              "1",
                                              "XYZ",
                                              "Departmental",
                                              "Store"
    ]
    
   public static let primaryBgColor = Color("PrimaryBackgroundColor")
   public static let listBackground = Color("listBackground")
   public static let gradientColor = Color("Gradient")
   public static let appBackground = Color("AppBackground")

   public static let gradientBG = LinearGradient(gradient: Gradient(colors: [primaryBgColor,gradientColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
     
   
}

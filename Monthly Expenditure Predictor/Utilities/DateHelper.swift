//
//  DateHelper.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 14/6/23.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }

    func endOfMonth() -> Date {
        let calendar = Calendar.current
        let plusOneMonth = calendar.date(byAdding: DateComponents(month: 1), to: self.startOfMonth()) ?? self.startOfMonth()
        let components = DateComponents(day: -1)
        return calendar.date(byAdding: components, to: plusOneMonth)!
    }

}

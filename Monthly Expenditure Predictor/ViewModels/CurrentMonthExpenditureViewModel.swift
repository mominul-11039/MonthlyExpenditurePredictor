//
//  CurrentMonthExpenditureViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by SADAT AHMED on 2023/07/24.
//

import Foundation
import CloudKit
import Combine

class CurrentMonthExpenditureViewModel: ObservableObject {
    @Published var expenditureList: [ExpenditureRecord] = []
    var dailyExpense: [DailyExpense] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getExpenditures()
        //        getDailyExpenditure()
    }
    
    func getExpenditures() {
        let userEmail = UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME") ?? ""
        let startingTimestamp = Int(Date().timeIntervalSince1970)
        let endingTimestamp = startingTimestamp - (14 * 24 * 60 * 60)
        print(startingTimestamp)
        print(endingTimestamp)
        print(userEmail)
        let predicate = NSPredicate(format: "date >= %d AND date <= %d AND user_email == %@",  endingTimestamp,  startingTimestamp, userEmail)
        let recordType = "expenditure_info"
        CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] returnedItems in
                self?.expenditureList = returnedItems
                self?.getDailyExpenditure()
            }
            .store(in: &cancellables)
    }
    
    func convertTimestampToDate(timestamp: TimeInterval) -> String {
        let format = "MMM dd, yyyy"
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func getRelativeDateTime(timestamp: TimeInterval) -> String {
        var displayDate = ""
        if Calendar.current.isDateInToday(Date(timeIntervalSince1970: timestamp)) {
            displayDate = NSLocalizedString("Today", comment: "")
        } else if Calendar.current.isDateInYesterday(Date(timeIntervalSince1970: timestamp)) {
            displayDate = NSLocalizedString("Yesterday", comment: "")
        } else {
            return convertTimestampToDate(timestamp: timestamp)
        }
        
        return displayDate
    }
    
    func getDailyExpenditure() {
        for i in 0...13 {
            let timeStamprange = getTimestampRange(numberOfDay: i)
            
            dailyExpense.append(DailyExpense(date: getRelativeDateTime(timestamp: timeStamprange.startTimestamp + 1), price: 0))
            expenditureList.forEach { expenditure in
                if expenditure.timestamp >= Int(timeStamprange.startTimestamp) && expenditure.timestamp <= Int(timeStamprange.endTimestamp) {
                    dailyExpense[i].price = dailyExpense[i].price + expenditure.productPrice
                }
            }
        }
        print(dailyExpense[1].date)
    }
    
    func getTimestampRange(numberOfDay: Int) -> (startTimestamp: TimeInterval, endTimestamp: TimeInterval) {
        let calendar = Calendar.current
        let now = Date()
        // Get the start of today (00:00:00)
        let startOfToday = calendar.startOfDay(for: now)
        // Subtract one day from the start of today to get the start of yesterday
        guard let startOfYesterday = calendar.date(byAdding: .day, value: -numberOfDay, to: startOfToday) else {
            // If for some reason we cannot calculate start of yesterday, return 0 for both timestamps
            return (0, 0)
        }
        // Get the end of yesterday (23:59:59)
        let endOfYesterday = calendar.date(byAdding: .second, value: -numberOfDay, to: startOfToday)
        // Convert to UNIX timestamp format
        let startTimestamp = startOfYesterday.timeIntervalSince1970
        let endTimestamp = endOfYesterday?.timeIntervalSince1970 ?? startTimestamp
        
        return (startTimestamp, endTimestamp)
    }
}

struct DailyExpense: Identifiable {
    var id = UUID()
    var date: String
    var price: Int
}

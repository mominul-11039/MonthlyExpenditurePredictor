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
    @Published var isShowGraph: Bool = false
    @Published var isShowList: Bool = false
    @Published var monthlyExpenditureSum: Double?
    @Published var weeklyExpense:Double = 0.0
    @Published var predctDynamicThreshold: Double = 1.0
    
    var dailyExpense: [DailyExpense] = []
    var graphData: [Double] = []
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Expense Prediction Service Variable
    var expensePredictor: ExpenditurePredictionProtocol = ExpenditurePredictor()
    @Published var predictedMonthEndExpense: Double = 0.0
    @Published var predictionError: String = ""
    @Published var tuningPredictionValue: Double = 0.0
    
    init() {
        getExpenditures()
        getTotalMonthlyExpenditure()
    }
    
    func getExpenditures() {
        let userEmail = UserDefaults.standard.string(forKey: Constant.loggedinUserKey) ?? ""
        let startingTimestamp = Int(Date().timeIntervalSince1970)
        let endingTimestamp = startingTimestamp - (14 * 24 * 60 * 60)
        print(startingTimestamp)
        print(endingTimestamp)
        print(userEmail)
        let predicate = NSPredicate(format: "date >= %d AND date <= %d AND user_email == %@",  endingTimestamp,  startingTimestamp, userEmail)
        let recordType = Constant.expInfoRecordType
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

    func getExpenseListForGraph() {
        graphData.removeAll()
        dailyExpense.forEach { dailyExpense in
            graphData.append(Double(dailyExpense.price))
        }
        graphData.reverse()
        DispatchQueue.main.async { [weak self] in
            self?.isShowGraph = true
        }
    }

    func getDailyExpenditure() {
        for i in 0...13 {
            let timeStamprange = getTimestampRange(numberOfDay: i)
            dailyExpense.append(DailyExpense(date: getRelativeDateTime(timestamp: timeStamprange.startTimestamp + 1), price: 0))
            print(timeStamprange.startTimestamp)
            print(timeStamprange.endTimestamp)
            expenditureList.forEach { expenditure in
                if expenditure.timestamp >= Int(timeStamprange.startTimestamp) && expenditure.timestamp <= Int(timeStamprange.endTimestamp) {
                    dailyExpense[i].price = dailyExpense[i].price + expenditure.productPrice
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.isShowList = true
            self?.getExpenseListForGraph()
        }
    }
    
    func getTimestampRange(numberOfDay: Int) -> (startTimestamp: TimeInterval, endTimestamp: TimeInterval) {
        let calendar = Calendar.current
        let now = Date()
        // Get the start of today (00:00:00)
        let startOfToday = calendar.startOfDay(for: now)
        // Subtract one day from the start of today to get the start of yesterday
        guard let startOfTheDay = calendar.date(byAdding: .day, value: -numberOfDay, to: startOfToday) else {
            // If for some reason we cannot calculate start of yesterday, return 0 for both timestamps
            return (0, 0)
        }
        // Get the end of the day (23:59:59)
        let endOfTheDay = calendar.date(byAdding: .day, value: numberOfDay == 0 ? 1 : -(numberOfDay - 1), to: startOfToday)
        // Convert to UNIX timestamp format
        let startTimestamp = numberOfDay == 0 ? startOfToday.timeIntervalSince1970 : startOfTheDay.timeIntervalSince1970
        print("enddd : \(endOfTheDay?.timeIntervalSince1970)" ?? "default")
        let endTimestamp = endOfTheDay?.timeIntervalSince1970 ?? startTimestamp - 1
        
        return (startTimestamp, endTimestamp)
    }

    func getTotalMonthlyExpenditure() {
        guard let userEmail = UserDefaults.standard.string(forKey: Constant.loggedinUserKey) else {
            print("User email not found.")
            return
        }

        let currentDate = Date()
        let calendar = Calendar.current

        guard let startDateOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start else {
            print("Failed to calculate the start date of the current month.")
            return
        }

        let endDateOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDateOfMonth)!

        let startingTimestamp = Int(startDateOfMonth.timeIntervalSince1970)
        let endingTimestamp = Int(endDateOfMonth.timeIntervalSince1970)

        print("Starting Timestamp:", startingTimestamp)
        print("Ending Timestamp:", endingTimestamp)
        print("User Email:", userEmail)

        let predicate = NSPredicate(format: "date >= %d AND date <= %d AND user_email == %@",  startingTimestamp,  endingTimestamp, userEmail)
        let recordType = Constant.expInfoRecordType

        CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] returnedItems in
                self?.expenditureList = returnedItems
                self?.monthlyExpenditureSum = self?.calculateTotalMonthlyExpenditure()
                self?.predictMonthEndExpenditure()
            }
            .store(in: &cancellables)
    }

    func calculateTotalMonthlyExpenditure() -> Double {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let startDateOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start else {
            print("Error calculating startdate.")
            return 0
        }
        
        let startingTimestamp = Int(startDateOfMonth.timeIntervalSince1970)
        let totalMonthlyExpenditure = expenditureList.filter({ $0.timestamp >= startingTimestamp }).reduce(0, { $0 + $1.productPrice })
        
        return Double(totalMonthlyExpenditure)
    }

    // MARK: - Month-end expenditure prediction
    func predictMonthEndExpenditure(){
        // TODO: Add real values
        let parameters =
        ExpenditurePredictionParams(userName: "Yeasir Arefin Tusher",
                                    userAge: 28,
                                    address: "Dhaka",
                                    noOfFamilyMember: 4,
                                    expenseAmount: 450,
                                    cumulativeSum: calculateTotalMonthlyExpenditure(),
                                    month: 10,
                                    day: 5)

        var result = expensePredictor.getApproximateMonthendExpense(feature: parameters)

        switch result{
        case .success(let monthEndExpense):
            debugPrint("Expected Month-End Expenditure: \(monthEndExpense)")
            self.predictedMonthEndExpense = monthEndExpense
            tuningPredictionAccuracy(cumulativeValue: calculateTotalMonthlyExpenditure(), prediction: predictedMonthEndExpense)
            self.predictedMonthEndExpense = (monthEndExpense * predctDynamicThreshold) + tuningPredictionValue
            print("Final Prediction: \(self.predictedMonthEndExpense)")
            
        case .failure(let errorMessage):
            debugPrint("Prediction Error: \(errorMessage.localizedDescription)")
            self.predictionError = errorMessage.localizedDescription
        }
    }
    
    /// This function adjusts the prediction accuracy based on cumulative value and prediction.
    /// - Parameters:
    ///   - cumulativeValue: The cumulative value to compare with the prediction.
    ///   - prediction: The predicted value to compare with the cumulative value.
    func tuningPredictionAccuracy_old(cumulativeValue: Double, prediction: Double) {
        
        // Default dynamic threshold for prediction
        var predctDynamicThreshold: Double = 0.9 // Default value
        
        // Get the current date and day of the month
        let calendar = Calendar.current
        let currentDate = Date()
        let currentDay = calendar.component(.day, from: currentDate)
        
        // Adjust the predctDynamicThreshold based on the current day of the month
        if currentDay >= 1 && currentDay <= 10 {
            predctDynamicThreshold = 0.8
        } else if currentDay >= 11 && currentDay <= 20 {
            predctDynamicThreshold = 0.9
        } else if currentDay >= 21 && currentDay <= 30 {
            predctDynamicThreshold = 0.95
        }
        
        // Check if the cumulative value is greater than the prediction or the cumulative value multiplied by the dynamic threshold is greater than the prediction
        if cumulativeValue > prediction || (cumulativeValue * predctDynamicThreshold) >= prediction {
            print("Prediction:--> \(prediction)")
            
            // Calculate the last day of the current month
            if let lastDayOfCurrentMonth = calendar.date(byAdding: DateComponents(month: 1, day: -currentDay), to: currentDate) {
                
                // Get the total number of days in the month and divide it into 4 weeks
                let daysInMonth = calendar.component(.day, from: lastDayOfCurrentMonth)
                let daysPerWeek = daysInMonth / 4 // Divide the month into 4 weeks
                
                // Initialize an array to store weekly expenses
                var weeklyExpenses: [Double] = []
                
                // Iterate through each week
                for weekNumber in 0..<4 {
                    let startOfWeek = weekNumber * daysPerWeek
                    let endOfWeek = min(startOfWeek + daysPerWeek, daysInMonth)
                    var weeklyExpense = 0.0
                    
                    // Calculate weekly expenses based on daily expenses
                    for day in startOfWeek..<endOfWeek {
                        if day < dailyExpense.count && day <= currentDay {
                            print("Day \(day): Weekly Expense \(weeklyExpense)")
                            weeklyExpense += Double(dailyExpense[day].price)
                        }
                    }
                    
                    // Add the weekly expense to the array
                    weeklyExpenses.append(weeklyExpense)
                }
                
                // Find the maximum weekly expenditure
                if let maxExpenditure = weeklyExpenses.max() {
                    print("Weekly Expenses: \(weeklyExpenses[0])")
                    print("Weekly Expenses: \(weeklyExpenses[1])")
                    print("Max: \(maxExpenditure)")
                    
                    // If the maximum expenditure is greater than the tuning prediction value, update the tuning prediction value
                    if maxExpenditure > tuningPredictionValue {
                        tuningPredictionValue += maxExpenditure
                        print("Current Expense: \(tuningPredictionValue)")
                    }
                }
            }
        }
    }
    
    
    func tuningPredictionAccuracy(cumulativeValue: Double, prediction: Double) {
        var dynamicThreshold: Double = 0.0
        let calendar = Calendar.current
        let currentDate = Date()
        let currentDay = calendar.component(.day, from: currentDate)
        
        // Adjust the predctDynamicThreshold based on the current day
        if currentDay >= 1 && currentDay <= 10 {
            dynamicThreshold = 0.8
        } else if currentDay >= 11 && currentDay <= 20 {
            dynamicThreshold = 0.85
        } else if currentDay >= 21 && currentDay <= 30 {
            dynamicThreshold = 0.9
        }
        
        if currentDay >= 1 && currentDay <= 3 {
            predctDynamicThreshold = 1
        } else if currentDay >= 4 && currentDay <= 6 {
            predctDynamicThreshold = 0.9
        } else if currentDay >= 7 && currentDay <= 9 {
            predctDynamicThreshold = 0.8
        } else if currentDay >= 10 && currentDay <= 12 {
            predctDynamicThreshold = 0.7
        } else if currentDay >= 13 && currentDay <= 15 {
            predctDynamicThreshold = 0.6
        } else if currentDay >= 16 && currentDay <= 18 {
            predctDynamicThreshold = 0.5
        } else if currentDay >= 19 && currentDay <= 21 {
            predctDynamicThreshold = 0.4
        } else if currentDay >= 22 && currentDay <= 24 {
            predctDynamicThreshold = 0.3
        } else if currentDay >= 25 && currentDay <= 27 {
            predctDynamicThreshold = 0.25
        } else if currentDay == 28 {
            predctDynamicThreshold = 0.15
        } else if currentDay == 29 {
            predctDynamicThreshold = 0.1
        } else if currentDay == 30 {
            predctDynamicThreshold = 0.05
        } else { predctDynamicThreshold = 0.02 }
        
        if cumulativeValue > prediction || (cumulativeValue * predctDynamicThreshold) >= prediction {
            print("Prediction:--> \(prediction)")
            // Calculate the last day of the current month
            tuningPredictionValue += calculateTotalMonthlyExpenditure()
        }
    }
}

struct DailyExpense: Identifiable {
    var id = UUID()
    var date: String
    var price: Int
}

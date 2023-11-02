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
    
    var dailyExpense: [DailyExpense] = []
    var graphData: [Double] = []
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Expense Prediction Service Variable
    var expensePredictor: ExpenditurePredictionProtocol = ExpenditurePredictor()
    @Published var predictedMonthEndExpense: Double = 0.0
    @Published var predictionError: String = ""
    
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
        case .failure(let errorMessage):
            debugPrint("Prediction Error: \(errorMessage.localizedDescription)")
            self.predictionError = errorMessage.localizedDescription
        }
    }
}

struct DailyExpense: Identifiable {
    var id = UUID()
    var date: String
    var price: Int
}

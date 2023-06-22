////
////  MonthlyExpenditureView.swift
////  Monthly Expenditure Predictor
////
////  Created by Md. Mominul Islam on 6/6/23.
////
//
import SwiftUI
import Foundation

struct MonthlyExpenditureView: View {
    let months: [String] = [
        "January", "February", "March", "April",
        "May", "June", "July", "August",
        "September", "October", "November", "December"
    ]

    let expenditureRecords: [ExpenditureRecord] = []

    @State private var selectedYear: Int?
    @State private var selectedMonth: String?
    @State private var isShowingRecordsView = false
    @State var options = ["2020", "2021", "2022", "2023"]
    @State private var startingTimestamp: Int? = 0
    @State private var endingTimestamp: Int? = 0
    @State private var expenditureVM = ExpenditureRecordViewModel(startingTimestamp: 0, endingTimestamp: 0)
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            VStack {
                // Year Dropdown
                Picker("Please choose a color", selection: $selectedYear) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                //Text("You selected: \(selectedYear)")
                .padding()
                .background(selectedYear == nil ? Color.clear : Color.blue)
                .foregroundColor(selectedYear == nil ? .black : .white)
                .cornerRadius(8)
                .onChange(of: selectedYear) { newValue in
                    // Reset the selected month when changing the year
                    selectedMonth = nil
                }

                ScrollView {
                    // Month Grid
                    LazyVGrid(columns: gridItemLayout, spacing: 16) {
                        ForEach(months, id: \.self) { month in
                            Button(action: {
                                // Update the selected month
                                selectedMonth = month
                                isShowingRecordsView = true
                            }) {
                                Text(month)
                                    .font(.title)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(selectedMonth == month ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Monthly Books")
            .sheet(isPresented: $isShowingRecordsView) {
                if let selectedMonth = selectedMonth, let selectedYear = 2023 {
                    let startingTimestamp = getStartingTimestamp(for: selectedMonth, year: selectedYear)
                    let endingTimestamp = getEndingTimestamp(for: selectedMonth, year: selectedYear)
                    if (Int(startingTimestamp) != 0) && (Int(endingTimestamp) != 0) {
//                        let filteredRecords = expenditureVM.getExpenditures(startingTimestamp: Int(startingTimestamp), endingTimestamp: Int(endingTimestamp))
                        RecordsView(selectedMonth: selectedMonth, startingTime: Int(startingTimestamp), endingTime: Int(endingTimestamp))
                    }
                }
            }
        }
    }

    func getStartingTimestamp(for month: String, year: Int) -> TimeInterval {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let dateString = "\(month) \(year)"
        if let date = formatter.date(from: dateString) {
            print("date.startOfMonth().timeIntervalSince1970",date.startOfMonth().timeIntervalSince1970)
            return date.startOfMonth().timeIntervalSince1970
        }
        return Date().timeIntervalSince1970
    }

    func getEndingTimestamp(for month: String, year: Int) -> TimeInterval {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let dateString = "\(month) \(year)"
        if let date = formatter.date(from: dateString) {
            print("date.startOfMonth().timeIntervalSince1970",date.endOfMonth().timeIntervalSince1970)
            return date.endOfMonth().timeIntervalSince1970
        }
        return Date().timeIntervalSince1970
    }

    func getExpenditureRecords(for month: String, startingTimestamp: Int, endingTimestamp: Int) -> [ExpenditureRecord] {
        return expenditureRecords.filter { record in
            let timestamp = record.timestamp
            return getMonth(from: TimeInterval(timestamp)) == month &&
            timestamp >= startingTimestamp &&
            timestamp <= endingTimestamp
        }
    }

    func getMonth(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }
}

struct MonthlyExpenditureView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyExpenditureView()
    }
}

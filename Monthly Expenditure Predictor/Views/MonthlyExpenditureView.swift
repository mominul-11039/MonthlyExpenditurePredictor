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

    @State private var selectedYear: String = ""
    @State private var selectedMonth: String?
    @State private var isShowingRecordsView = false
    @State private var isShowingEmptyView = false
    var options = ["2022", "2023", "2024", "2025"]
    @State private var startingTimestamp: Int? = 0
    @State private var endingTimestamp: Int? = 0
    let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    let gridItemLayoutH = [GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryBackgroundColor").opacity(0.8)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Text("Please choose a year") // Title
                            .font(.headline)
                            .padding(10)
                        GeometryReader { geometry in
                            Picker("", selection: $selectedYear) {
                                ForEach(options, id: \.self) {
                                    Text($0)
                                }
                            }
                            .background(Color("PrimaryBackgroundColor").opacity(0.2))
                            .pickerStyle(.segmented) // Optionally, specify the picker style
                            .frame(height: 50) // Set frame size
                        }
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                        .onChange(of: selectedYear) { newValue in
                            // Reset the selected month when changing the year
                            selectedMonth = nil
                        }
                    }
                    .frame(height: 100)

                    GeometryReader { geometry in
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: gridItemLayoutH, spacing: 10) {
                                ForEach(months, id: \.self) { month in
                                    Button(action: {
                                        // Update the selected month
                                        selectedMonth = month
                                        if selectedYear != "" {
                                            isShowingRecordsView = true
                                        } else {
                                            isShowingEmptyView = true
                                        }
                                    }) {
                                        Text(month)
                                            .font(.subheadline)
                                            .frame(maxHeight: .infinity) // Adjusted to fill the height of each cell
                                            .padding()
                                            .background(selectedMonth == month ? Color.gray.opacity(0.5) : Color.white)//("PrimaryBackgroundColor").opacity(0.2))
                                            .border(Color.black, width: 2)
                                            .foregroundColor(selectedMonth == month ? Color.white : Color.black)
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(width: geometry.size.width, height: 50) // Set a fixed height for ScrollView

                        if let selectedMonth = selectedMonth, let selectedYear = Int(selectedYear) {
                            let startingTimestamp = getStartingTimestamp(for: selectedMonth, year: selectedYear)
                            let endingTimestamp = getEndingTimestamp(for: selectedMonth, year: selectedYear)
                            if (Int(startingTimestamp) != 0) && (Int(endingTimestamp) != 0) {
                                RecordsView(selectedMonth: selectedMonth, startingTime: Int(startingTimestamp), endingTime: Int(endingTimestamp), expenditureVM: ExpenditureRecordViewModel(startingTimestamp: Int(startingTimestamp), endingTimestamp: Int(endingTimestamp)))
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
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

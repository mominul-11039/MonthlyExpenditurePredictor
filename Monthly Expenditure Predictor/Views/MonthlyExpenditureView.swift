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
        ZStack (alignment: .top) {
            Color("PrimaryBackgroundColor").opacity(0.8)
            ZStack (alignment: .bottom) {
                ZStack(alignment: .top) {
                    WaveShape()
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2),radius: 5, x: -5, y: -5)
                        .ignoresSafeArea()
                }
                listContainerView()
                    .fill(Color("SecondaryBackgroundColor"))
                    .shadow(color: Color.black.opacity(0.2),radius: 3, x: -5, y: -5)
                    .ignoresSafeArea()
                    .overlay (alignment: .bottom) {
                        if isShowingRecordsView {
                            if let selectedMonth = selectedMonth, let selectedYear = Int(selectedYear) {
                                let startingTimestamp = getStartingTimestamp(for: selectedMonth, year: selectedYear)
                                let endingTimestamp = getEndingTimestamp(for: selectedMonth, year: selectedYear)
                                if (Int(startingTimestamp) != 0) && (Int(endingTimestamp) != 0) {
                                    RecordsView(selectedMonth: selectedMonth, startingTime: Int(startingTimestamp), endingTime: Int(endingTimestamp), expenditureVM: ExpenditureRecordViewModel(startingTimestamp: Int(startingTimestamp), endingTimestamp: Int(endingTimestamp)))
//                                        .background(Color.red)
                                }
                            }
                        }
                    }
            }

            topView
                .padding(.top, 30)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
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

    var topView: some View {
        VStack {
            Text("Please choose a year")
                .font(.headline)
                .padding(.top, 50)
                .frame(height: 40)
                .foregroundColor(Color("SecondaryBackgroundColor"))

            ScrollView(.horizontal) {
                LazyHGrid(rows: gridItemLayoutH, spacing: 10) {
                    ForEach(2023...2100, id: \.self) { year in
                        Text(verbatim: "\(year)")
                            .font(.subheadline)
                            .padding(6)
                            .background(selectedYear == "\(year)" ? Color("SecondaryBackgroundColor"): Color("PrimaryBackgroundColor").opacity(0.7))
                            .cornerRadius(10)
                            .foregroundColor(selectedYear == "\(year)" ? Color("PrimaryBackgroundColor") : Color("SecondaryBackgroundColor"))
                            .onTapGesture {
                                selectedYear = "\(year)"
                            }
                            .shadow(color: Color.black.opacity(0.2),radius: 3, x: 3, y: 3)
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 20)
                .padding(.top, 30)
            }

            ScrollView(.horizontal) {
                LazyHGrid(rows: gridItemLayoutH, spacing: 10) {
                    ForEach(months, id: \.self) { month in
                        Button(action: {
                            selectedMonth = month
                            if selectedYear != "" {
                                isShowingRecordsView = true
                                isShowingEmptyView = false
                            } else {
                                isShowingRecordsView = false
                                isShowingEmptyView = true
                            }
                        }) {
                            Text(month)
                                .font(.subheadline)
                                .frame(maxHeight: .infinity)
                                .padding(8)
                                .background(selectedMonth == month ? Color("PrimaryBackgroundColor").opacity(0.7) : Color("SecondaryBackgroundColor"))
                                .cornerRadius(10)
                                .foregroundColor(selectedMonth == month ? Color("SecondaryBackgroundColor") : Color.black)
                                .shadow(color: Color.black.opacity(0.2),radius: 3, x: 3, y: 3)
                        }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.screenWidth, height: 50)
        }
    }
}

struct MonthlyExpenditureView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyExpenditureView()
    }
}

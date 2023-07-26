//
//  RecordsView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import SwiftUI

struct RecordsView: View {
    let selectedMonth: String
    var startingTime : Int
    var endingTime : Int
    @ObservedObject var expenditureVM : ExpenditureRecordViewModel
    init(selectedMonth: String, startingTime: Int, endingTime: Int, expenditureVM: ExpenditureRecordViewModel) {
        self.selectedMonth = selectedMonth
        self.expenditureVM = ExpenditureRecordViewModel(startingTimestamp: startingTime, endingTimestamp: endingTime)
        self.startingTime = startingTime
        self.endingTime = endingTime
    }

    var body: some View {
        ZStack {
            if expenditureVM.willShowLoader {
                ProgressView()
                    .frame(height: UIScreen.screenHeight - 400)
                    .background(Color.clear)
            } else {
                let filteredRecords = expenditureVM.expenditureList
                if filteredRecords.count != 0 {
                    VStack {
                        Text("Records of \(selectedMonth)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        List {
                            Section(header: TableHeaderView()) {
                                ForEach(filteredRecords, id: \.expenditureRecordId) { record in
                                    TableRowView(record: record)
                                        .cornerRadius(8) // Corner radius for each row
                                }
                            }
                        }
                        .listStyle(.plain)
                        .clipped()
                        .cornerRadius(20)
                        .padding(.leading, 40) // Add padding around the entire List
                    }
                    .frame(height: UIScreen.screenHeight - 400)
                } else {
                    VStack {
                        EmptyRecordView(state: 1)
                    }
                    .frame(height: UIScreen.screenHeight - 400)
                }
            }
        }
    }
}

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
        NavigationView {
            VStack {
                Text("Records for \(selectedMonth)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                List {
                    let filteredRecords = expenditureVM.expenditureList
                    Section(header: TableHeaderView()) {
                        ForEach(filteredRecords, id: \.expenditureRecordId) { record in
                            TableRowView(record: record)
                        }
                    }
                }
            }
            //.navigationTitle("Expenditure Records")
        }
    }
}

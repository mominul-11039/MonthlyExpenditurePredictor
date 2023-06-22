//
//  RecordsView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import SwiftUI

struct RecordsView: View {
    let selectedMonth: String
    //var expenditureList: [ExpenditureRecord]
    var startingTime : Int
    var endingTime : Int
    //let expenditureRecords: [ExpenditureRecord]

    var body: some View {
        NavigationView {
            VStack {
                Text("Records for \(selectedMonth)")
                    .font(.title)
                    .padding()

                List {
//                    let filteredRecords = ExpenditureRecordViewModel().getExpenditures(startingTimestamp: Int(startingTime), endingTimestamp: Int(endingTime))
                    let filteredRecords = ExpenditureRecordViewModel(startingTimestamp: startingTime, endingTimestamp: endingTime).expenditureList
                    Section(header: TableHeaderView()) {
                        ForEach(filteredRecords, id: \.expenditureRecordId) { record in
                            TableRowView(record: record)
                        }
                    }
                }
            }
            .navigationTitle("Expenditure Records")
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView(selectedMonth: "June", startingTime: 0, endingTime: 0)
    }
}

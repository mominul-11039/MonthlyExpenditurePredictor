//
//  RecordsView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import SwiftUI

struct RecordsView: View {
    let selectedMonth: String
    @ObservedObject var vm: ExpenditureRecordViewModel
    var startingTime : Int
    var endingTime : Int

    init(selectedMonth: String, vm: ExpenditureRecordViewModel = ExpenditureRecordViewModel(), startingTime: Int, endingTime: Int) {
        self.selectedMonth = selectedMonth
        self.vm = ExpenditureRecordViewModel(startingTimestamp: startingTime, endingTimestamp: endingTime)
        self.startingTime = startingTime
        self.endingTime = endingTime
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Records for \(selectedMonth)")
                    .font(.title)
                    .padding()

                List {
                    Section(header: TableHeaderView()) {
                        ForEach(vm.expenditureList, id: \.expenditureRecordId) { record in
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

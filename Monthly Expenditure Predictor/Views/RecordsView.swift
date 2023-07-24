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
            ZStack {
                Color("PrimaryBackgroundColor").opacity(0.8)
                let filteredRecords = expenditureVM.expenditureList
                if filteredRecords.count != 0 {
                    VStack {
                        Spacer()
                        Text("Records for \(selectedMonth)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        List {
                            Section(header: TableHeaderView()) {
                                ForEach(filteredRecords, id: \.expenditureRecordId) { record in
                                    TableRowView(record: record)
                                        .cornerRadius(8) // Corner radius for each row
                                }
                            }
                        }
                        .listStyle(InsetListStyle())
                        .clipped()
                        .cornerRadius(20)
                        .padding(.leading, 30) // Add padding around the entire List
                    }
                }
                else {
                    VStack {
                        Text("Records for \(selectedMonth)")
                            .font(.title)
                            .fontWeight(.bold)
                        EmptyRecordView()
                    }
                }


            }
        }
        .background(Color("PrimaryBackgroundColor").opacity(1))
    }
}

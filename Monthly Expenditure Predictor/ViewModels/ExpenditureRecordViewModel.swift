//
//  ExpenditureRecordViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 15/6/23.
//

import Foundation
import CloudKit
import Combine

class ExpenditureRecordViewModel: ObservableObject {
    @Published var expenditureList: [ExpenditureRecord] = []
    @Published var willShowLoader = true
    var vm: CloudKitViewModel = CloudKitViewModel()
    var startingTimestamp: Int?
    var endingTimestamp: Int?

    var cancellables = Set<AnyCancellable>()

    init() {
    }

    init(startingTimestamp: Int?, endingTimestamp: Int?) {
        self.startingTimestamp = startingTimestamp
        self.endingTimestamp = startingTimestamp
        if let startingTimestamp = startingTimestamp, let endingTimestamp = endingTimestamp {
            self.getExpenditures(startingTimestamp: startingTimestamp, endingTimestamp: endingTimestamp)
        }
    }

        func getExpenditures(startingTimestamp: Int, endingTimestamp: Int) {
            let userEmail = UserDefaults.standard.string(forKey: Constant.loggedinUserKey) ?? ""
            
            let predicate = NSPredicate(format: "date >= %d AND date <= %d AND user_email == %@",  startingTimestamp,  endingTimestamp, userEmail)

            let recordType = Constant.expInfoRecordType
            CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                } receiveValue: { [weak self] returnedItems in
                    self?.willShowLoader = false
                    self?.expenditureList = returnedItems
                }
                .store(in: &cancellables)
        }
    func getProcessedExpenditureList() -> [ExpenditureRecord] {
        return expenditureList
    }
}


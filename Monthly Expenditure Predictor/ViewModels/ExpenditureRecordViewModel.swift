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
            let userEmail = UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME") ?? ""
            print("startingTimestamp",startingTimestamp)
            print("endingTimestamp",endingTimestamp)
            let predicate = NSPredicate(format: "date >= %d AND date <= %d AND user_email == %@",  startingTimestamp,  endingTimestamp, userEmail)

            let recordType = "expenditure_info"
            CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                } receiveValue: { [weak self] returnedItems in
                    self?.expenditureList = returnedItems
                }
                .store(in: &cancellables)
        }


//    func getExpenditures(startingTimestamp: Int, endingTimestamp: Int) -> [ExpenditureRecord] {
//        print("startingTimestamp", startingTimestamp)
//        print("endingTimestamp", endingTimestamp)
//        let predicate = NSPredicate(format: "date >= %d AND date <= %d", startingTimestamp, endingTimestamp)
//
//        let recordType = "expenditure_info"
//        //var expenditureList: [ExpenditureRecord] = []
//
//        let cancellable = CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//            } receiveValue: { returnedItems in
//                self.expenditureList = returnedItems
//            }
//
//        cancellables.insert(cancellable)
//        return expenditureList
//    }

    
    //    func getExpenditures(startingTimestamp: Int, endingTimestamp: Int, completion: @escaping ([ExpenditureRecord]) -> Void) {
    //        print("startingTimestamp", startingTimestamp)
    //        print("endingTimestamp", endingTimestamp)
    //        let predicate = NSPredicate(format: "date >= %d AND date <= %d", startingTimestamp, endingTimestamp)
    //
    //        let recordType = "expenditure_info"
    //        var expenditureList: [ExpenditureRecord] = []
    //
    //        let cancellable = CloudKitViewModel.fetch(predicate: predicate, recordType: recordType)
    //            .receive(on: DispatchQueue.main)
    //            .sink { _ in
    //            } receiveValue: { returnedItems in
    //                expenditureList = returnedItems
    //                completion(expenditureList) // Call the completion handler when records are received
    //            }
    //
    //        cancellables.insert(cancellable)
    //    }


    func getProcessedExpenditureList() -> [ExpenditureRecord] {
        return expenditureList
    }
}


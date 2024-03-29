//
//  CloudKitViewModel.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import Foundation
import CloudKit
import Combine

protocol CloudKitableProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get }
}

class CloudKitViewModel {

    static let ckContainer = CKContainer(identifier: Constant.cloudKitContainerName)

    init() {
        CloudKitViewModel.requestApplicationPermission()
    }

    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        case iCloudApplicationPermissionNotGranted
        case iCloudCouldNotFetchUserRecordID
        case iCloudCouldNotDiscoverUser
    }

    static private func getiCloudStatus(completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().accountStatus { returnedStatus, returnedError in
            switch returnedStatus {
            case .available:
                completion(.success(true))
            case .noAccount:
                completion(.failure(CloudKitError.iCloudAccountNotFound))
            case .couldNotDetermine:
                completion(.failure(CloudKitError.iCloudAccountNotDetermined))
            case .restricted:
                completion(.failure(CloudKitError.iCloudAccountRestricted))
            default:
                completion(.failure(CloudKitError.iCloudAccountUnknown))
            }
        }
    }

    static func getiCloudStatus() -> Future<Bool, Error> {
        Future { promise in
            CloudKitViewModel.getiCloudStatus { result in
                promise(result)
            }
        }
    }

    static private func requestApplicationPermission(completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            if returnedStatus == .granted {
                completion(.success(true))
            } else {
                completion(.failure(CloudKitError.iCloudApplicationPermissionNotGranted))
            }
        }
    }

    static func requestApplicationPermission() {
        CloudKitViewModel.requestApplicationPermission { _ in
            
        }
    }

    static func fetch<T: CloudKitableProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil
    ) -> Future<[T], Error> {
        Future { promise in
            CloudKitViewModel.fetch(predicate: predicate, recordType: recordType, sortDescriptions: sortDescriptions, resultLimit: resultsLimit) { (items: [T]) in
                promise(.success(items))
            }
        }
    }
    
    static func checkUserExistsWithEmail(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let predicate = NSPredicate(format: Constant.emailPredicate, email)
        let recordType = Constant.expUserRecordType

            fetch(predicate: predicate, recordType: recordType) { (users: [User]) in
                
                if users.isEmpty {
                    
                    // User with the provided email does not exist
                    completion(.success(false))
                } else {
                    // User with the provided email exists
                    completion(.success(true))
                }
            }
        }
    
    // MARK:
    static func fetchUser(){
        // Fetch Public Database
        let publicDatabase = CKContainer.default().publicCloudDatabase
               
               // Initialize Query
        let query = CKQuery(recordType: Constant.expUserRecordType, predicate: NSPredicate(format: Constant.ckUserEmailRecord, "yeasir.arefin@bjitgroup.com"))
               
               
               // Perform Query
        publicDatabase.fetch(withQuery: query) { result in
            print(result)
        }
    }

    static private func fetch<T: CloudKitableProtocol> (
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultLimit: Int? = nil,
        completion: @escaping(_ items: [T]) -> ()) {
            let operation = createOperation(predicate: predicate, recordType: recordType, sortDescriptions: sortDescriptions, resultLimit: resultLimit)
            
            var returnedItems: [T] = []
            addRecordMatchedblock(operation: operation) { item in
                returnedItems.append(item)
            }
            
            addQueryResultBlock(operation: operation) { finished in
                completion(returnedItems)
            }
            
            addOperation(operation: operation)
    }

    static private func createOperation(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultLimit: Int? = nil
    ) -> CKQueryOperation {
        let query: CKQuery = CKQuery(recordType: recordType, predicate: predicate)
        let queryOperation: CKQueryOperation = CKQueryOperation(query: query)
        if let limit = resultLimit {
            queryOperation.resultsLimit = limit
        }
        return queryOperation
    }

    static private func addRecordMatchedblock<T:CloudKitableProtocol>(
        operation: CKQueryOperation,
        completion: @escaping(_ item: T) -> ()) {
        operation.recordMatchedBlock = { (recordId, recordResult) in
            switch recordResult {
            case .success(let record):
                guard let item = T(record: record) else { return }
                completion(item)
            case .failure(_):
                break
            }
        }
    }

    static private func addQueryResultBlock(
        operation: CKQueryOperation,
        completion: @escaping(_ isFinished: Bool) -> ()
    ) {
        operation.queryResultBlock = { (resultCoursor) in
            completion(true)
        }
    }

    static private func addOperation(operation: CKQueryOperation) {
        CloudKitViewModel.ckContainer.publicCloudDatabase.add(operation)
    }

    static func add<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        let record = item.record
        save(record: record, completion: completion)
    }
    
    static func update<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        add(item: item, completion: completion)
    }
    
    static private func save(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CloudKitViewModel.ckContainer.publicCloudDatabase.save(record) { returnedRecord, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    static func delete<T:CloudKitableProtocol>(item: T) -> Future<Bool, Error> {
        Future { promise in
            CloudKitViewModel.delete(item: item, completion: promise)
        }
    }
    
    static private func delete<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        CloudKitViewModel.delete(record: item.record, completion: completion)
    }
    
    static private func delete(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CloudKitViewModel.ckContainer.publicCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

    static func getCount (
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultLimit: Int? = nil,
        completion: @escaping(_ itemCount: Int) -> ()) {
            let operation = createOperation(predicate: predicate, recordType: recordType, sortDescriptions: sortDescriptions, resultLimit: resultLimit)

            var returnedItems: [CKRecord] = []
            operation.recordMatchedBlock = { (recordId, recordResult) in
                switch recordResult {
                case .success(let record):
                    returnedItems.append(record)
                case .failure(_):
                    break
                }
            }

            operation.queryResultBlock = { (resultCoursor) in
                completion(returnedItems.count)
            }

            addOperation(operation: operation)
    }
    
   static func saveItemsToCloudKit(_ items: [ExpenditureRecord], completion: @escaping (Bool) -> ()) {
        let records = items.map { item in
            let recordID = CKRecord.ID(recordName: item.expenditureRecordId.uuidString)
            let record = CKRecord(recordType: Constant.expInfoRecordType, recordID: recordID)
            record[Constant.ckProductNameRecord] = item.productName as CKRecordValue
            record[Constant.ckProductQuantityRecord] = item.productQuantity as CKRecordValue
            record[Constant.ckProductPriceRecord] = item.productPrice as CKRecordValue
            record[Constant.ckDateRecord] = item.timestamp as CKRecordValue
            record[Constant.ckCategoryRecord] = item.category as CKRecordValue
            record[Constant.ckUserEmailRecord] = item.userEmail as CKRecordValue
            return record
        }
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInitiated
        operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
            if error != nil || savedRecords?.isEmpty == true {
                completion(false)
                print("Error saving records: \(error?.localizedDescription ?? "")")
            } else {
                completion(true)
                print("Records saved successfully")
            }
        }
        
       let container = CloudKitViewModel.ckContainer
        let database = container.publicCloudDatabase
        database.add(operation)
    }
}

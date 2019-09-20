//
//  CloudModel.swift
//  NotificationTest
//
//  Created by Henrik on 2019-09-04.
//  Copyright © 2019 Henrik. All rights reserved.
//

import UIKit
import CloudKit

enum JournalKeys: String {
    case journalEntry = "journalEntry"
}

class CloudManager {
    
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase
    
    func saveToCloud(note: String) {
        let newNote = CKRecord(recordType: "Note")
        newNote.setValue(note, forKey: JournalKeys.journalEntry.rawValue)
        database.save(newNote) { (record, error) in
            print(error as Any)
            guard record != nil else {return}
            print("saved")
        }
    }
    
    
//    @objc func queryCloud() {
//        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
//        database.perform(query, inZoneWith: nil) { (records, _) in
//            guard let records = records else {return}
//            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
//            self.notes = sortedRecords
//            DispatchQueue.main.async {
//                //                self.tableView.refreshControl?.endRefreshing()
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    
}

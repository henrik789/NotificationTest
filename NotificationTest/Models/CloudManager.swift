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
    case journalEntry = "journalEntry", alcoEntry = "alcoEntry", foodEntry = "foodEntry",
    trainingEntry = "trainingEntry" , dailyEntry = "dailyEntry"
    
}

class CloudManager {
    
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase
    
    var alcoholValue: Int32 = 0
    var foodValue: Int32 = 0
    var stressValue: Int32 = 0
    var trainingValue: Int32 = 0
    var headlineText: String = ""
    var dailynoteText: String = ""
    
    func saveToCloud() {
        
        let newNote = CKRecord(recordType: "Note")
        newNote.setValue(headlineText, forKey: JournalKeys.journalEntry.rawValue)
        newNote.setValue(alcoholValue, forKey: JournalKeys.alcoEntry.rawValue)
        newNote.setValue(trainingValue, forKey: JournalKeys.trainingEntry.rawValue)
        newNote.setValue(dailynoteText, forKey: JournalKeys.dailyEntry.rawValue)
        database.save(newNote) { (record, error) in
            print(error as Any , error.debugDescription)
            guard record != nil else {return}
            print("saved")
        }
    }
    
    
//    func queryCloud() {
//        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
//        database.perform(query, inZoneWith: nil) { (records, _) in
//            guard let records = records else {return}
//            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
//            self.notes = sortedRecords
//            DispatchQueue.main.async {
//                //                self.tableView.refreshControl?.endRefreshing()
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    
}

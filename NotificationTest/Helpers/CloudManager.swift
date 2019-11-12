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
    case journalEntry = "journalEntry", dailyEntry = "dailyEntry", journalRecordId = "journalRecordId"
}

class CloudManager {
    
    var recordIDs = [CKRecord.ID]()
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase

    var headlineText: String = ""
    var dailynoteText: String = ""
    
    func saveToCloud() {
        
        let newNote = CKRecord(recordType: "Note")
        newNote.setValue(headlineText, forKey: JournalKeys.journalEntry.rawValue)
        newNote.setValue(dailynoteText, forKey: JournalKeys.dailyEntry.rawValue)
        database.save(newNote) { (record, error) in
            print(error as Any , error.debugDescription)
            guard record != nil else {return}
            print("saved")
        }
    }
    
    func updateCloud(record: CKRecord) {
        database.fetch(withRecordID: record.recordID) { (record, error) in
            if error == nil {
                print(record as Any)
            } else {
                print("Could not fetch record")
            }
        }
        
    }
    
    func deletepost(item: CKRecord) {
        database.delete(withRecordID: item.recordID) { (deletedrecordID, error) in
            DispatchQueue.main.async {
                if error == nil {
                    print("Record Deleted: " ,deletedrecordID as Any)
                } else {
                    print("Record Not Deleted")
                }
            }
        }
        updateCloud(record: item)
    }
    
    
    func queryCloud() -> [CKRecord]{
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            
            DispatchQueue.main.async {
                self.notes = sortedRecords
            }
        }
        return self.notes
    }
}

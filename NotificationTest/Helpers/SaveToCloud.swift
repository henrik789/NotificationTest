
import UIKit
import CloudKit



class SaveToCloud {
    
    var diary = DiaryViewController()
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase
    
    func saveToCloud(note: String) {
        let newNote = CKRecord(recordType: "Note")
        newNote.setValue(note, forKey: "content")
        database.save(newNote) { (record, error) in
            print(error as Any)
            guard record != nil else {return}
            print("saved")
        }
    }
    
    @objc func queryCloud() {
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.notes = sortedRecords
            DispatchQueue.main.async {
//                self.diary.collectionView.refreshControl?.endRefreshing()
                self.diary.collectionView.reloadData()
            }
        }
    }
    
}

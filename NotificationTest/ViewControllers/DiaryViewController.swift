//
//  DiaryViewController.swift
//  NotificationTest
//
//  Created by Henrik on 2019-08-20.
//  Copyright © 2019 Henrik. All rights reserved.
//

import UIKit
import CloudKit

class DiaryViewController: UIViewController {
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func refreshButton(_ sender: Any) {
        queryCloud()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print(self.notes.count)
        }
    }
    
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase
    
    func saveToCloud(note: String) {
        let newNote = CKRecord(recordType: "Note")
        newNote.setValue(note, forKey: "journalToday")
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
                //                self.tableView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib.init(nibName: DiaryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DiaryCollectionViewCell.identifier)
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryCloud), for: .valueChanged)        
        queryCloud()
        
    }
    
}

extension DiaryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewCell.identifier, for: indexPath) as! DiaryCollectionViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let noteDate = notes[indexPath.row].creationDate
        
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.string(from: noteDate!)) // Jan 2, 2001
        cell.dateLabel.text = dateFormatter.string(from: noteDate!)
        cell.emojiLabel.text = "👍"
        
//        cell.dateLabel.text = formatter.string(from: notedate!)
        cell.headlineLabel.text = notes[indexPath.row].value(forKey: "content") as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth , height: screenHeight / 8)
    }
    
    // Do any additional setup after loading the view, typically from a nib.
//    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//    layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//    layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
//    layout.minimumInteritemSpacing = 0
//    layout.minimumLineSpacing = 0
//    collectionView!.collectionViewLayout = layout
    
}

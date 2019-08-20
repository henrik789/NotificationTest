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
                //                self.tableView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: DiaryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DiaryCollectionViewCell.identifier)
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryCloud), for: .valueChanged)
        //        self.tableView.refreshControl = refreshControl
        
        queryCloud()
        
    }
    
}

extension DiaryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewCell.identifier, for: indexPath) as! DiaryCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth * 0.94 , height: screenHeight / 5)
    }
    
    
}

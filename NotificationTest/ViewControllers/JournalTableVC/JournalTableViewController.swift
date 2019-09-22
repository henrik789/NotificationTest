
import UIKit
import CloudKit

class JournalTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView?
    var cloudMangaer = CloudManager()
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryCloud), for: .valueChanged)
        tableView?.refreshControl = refreshControl
        queryCloud()
        
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let noteDate = notes[indexPath.row].creationDate
        
        dateFormatter.locale = Locale(identifier: "en_US")

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JournalTableViewCell", for: indexPath) as? JournalTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of JournalTableViewCell")
        }
        
        cell.dateLabel.text = dateFormatter.string(from: noteDate!)
        cell.headlineLabel.text = notes[indexPath.row].value(forKey: "journalEntry") as? String ?? "👍"
        cell.emojiLabel.text = notes[indexPath.row].value(forKey: "trainingEntry") as? String ?? "👍"
        
        
        return cell
    }
    
    @objc func queryCloud() {
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.notes = sortedRecords
            DispatchQueue.main.async {
                self.tableView?.refreshControl?.endRefreshing()
                self.tableView?.reloadData()
                print(self.notes.count)
            }
        }
    }
    
}


/*
 
 import UIKit
 import CloudKit
 
 class JournalTableViewController: UIViewController {
 
 @IBOutlet weak var tableView: UITableView!
 var cloudMangaer = CloudManager()
 var notes = [CKRecord]()
 let database = CKContainer.default().privateCloudDatabase
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 self.title = "Journal"
 tableView.register(UINib.init(nibName: JournalTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: JournalTableViewCell.identifier)
 tableView.delegate = self
 tableView.dataSource = self
 tableView.register(UITableViewCell.self, forCellReuseIdentifier: JournalTableViewCell.identifier)
 
 }
 
 @IBAction func refreshButton(_ sender: Any) {
 queryCloud()
 DispatchQueue.main.async {
 self.tableView.reloadData()
 print(self.notes.count)
 }
 }
 
 func queryCloud() {
 let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
 database.perform(query, inZoneWith: nil) { (records, _) in
 guard let records = records else {return}
 let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
 self.notes = sortedRecords
 DispatchQueue.main.async {
 //                self.tableView.refreshControl?.endRefreshing()
 self.tableView.reloadData()
 }
 }
 }
 
 }
 
 extension JournalTableViewController: UITableViewDelegate, UITableViewDataSource {
 
 
 func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 0
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return 0
 }
 
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: JournalTableViewCell.identifier, for: indexPath) as! JournalTableViewCell
 cell.config()
 
 return cell
 }
 
 
 
 
 
 
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
 }
 
 
 }
 
 */

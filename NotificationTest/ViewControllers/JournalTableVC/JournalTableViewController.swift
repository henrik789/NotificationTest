
import UIKit
import CloudKit

class JournalTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView?
    var cloudMangaer = CloudManager()
    var notes = [CKRecord]()
    let database = CKContainer.default().privateCloudDatabase
    let dateFormatter = DateFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryCloud), for: .valueChanged)
        tableView?.register(UINib.init(nibName: JournalTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: JournalTableViewCell.identifier)
        tableView?.refreshControl = refreshControl
        tableView?.delegate = self
        tableView?.dataSource = self
        queryCloud()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    @objc func removeViewFromSuperView() {
        if let subView = self.detailView{
            subView.removeFromSuperview()
            print("tar bort")
        } else {
            print("ikke!!")
            return
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.addSubview(detailView)
        detailView.backgroundColor = .yellow
        let noteDate = notes[indexPath.row].creationDate
        dateLabel.text = dateFormatter.string(from: noteDate!)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.detailView.alpha = 1
            self.detailView.layer.borderColor = UIColor.gray.cgColor
            self.detailView.layer.borderWidth = 1
            self.detailView.frame = CGRect(x: 10, y: 20, width: self.screenWidth - 20, height: self.screenHeight / 3)
            self.detailView.layer.cornerRadius = 20
            self.detailView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            self.detailView.backgroundColor = .groupTableViewBackground
        }) { _ in

        }
        detailView.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(JournalTableViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        detailView.addGestureRecognizer(tapGesture)
//                newNoteTextView.translatesAutoresizingMaskIntoConstraints = false
//        newNoteTextView.isScrollEnabled = true
        
    }
    

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = tableView?.indexPathForSelectedRow {
//            guard let destinationVC = segue.destination as? DetailViewController else {return}
//            let selectedRow = indexPath.row
//            destinationVC.name = notes[selectedRow].value(forKey: "journalEntry")
//        }
//    }
    
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

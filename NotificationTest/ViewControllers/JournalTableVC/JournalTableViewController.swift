
import UIKit
import CloudKit

class JournalTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailHeadlineLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailCloseButton: UIButton!
    @IBAction func detailCloseButton(_ sender: Any) {
        removeViewFromSuperView()
    }
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
        DispatchQueue.main.async {
            self.queryCloud()
        }
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
            self.navigationController?.navigationBar.layer.zPosition = 0
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
        self.navigationController?.navigationBar.layer.zPosition = -1
        view.addSubview(detailView)
        
        let noteDate = notes[indexPath.row].creationDate
        detailDateLabel.text = dateFormatter.string(from: noteDate!)
        detailTextView.text = notes[indexPath.row].value(forKey: "dailyEntry") as? String ?? "👍"
        detailHeadlineLabel.text = notes[indexPath.row].value(forKey: "journalEntry") as? String ?? "👍"
        detailCloseButton.layer.cornerRadius = 8
        detailCloseButton.layer.borderColor = UIColor.white.cgColor
        detailCloseButton.layer.borderWidth = 1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.detailView.alpha = 1
            self.detailView.layer.borderColor = UIColor.gray.cgColor
            self.detailView.layer.borderWidth = 1
            self.detailView.frame = CGRect(x: 10, y: 20, width: self.screenWidth - 20, height: self.screenHeight * 0.9)
            self.detailView.layer.cornerRadius = 20
            self.detailView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            self.detailView.backgroundColor = .white
        }) { _ in
            self.detailView.isUserInteractionEnabled = true
            let aSelector : Selector = #selector(JournalTableViewController.removeViewFromSuperView)
            let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
            self.detailView.addGestureRecognizer(tapGesture)
        }


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


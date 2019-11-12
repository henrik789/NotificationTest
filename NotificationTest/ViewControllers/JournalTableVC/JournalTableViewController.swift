
import UIKit
import CloudKit

class JournalTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navItem: UINavigationItem!
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
    @IBOutlet weak var blurView: UIVisualEffectView!
    var cloudMangaer = CloudManager()

    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.isHidden = true
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryCloud), for: .valueChanged)
        tableView?.register(UINib.init(nibName: JournalTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: JournalTableViewCell.identifier)
        tableView?.refreshControl = refreshControl
        tableView?.delegate = self
        tableView?.dataSource = self
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.queryCloud()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Antal rader: " ,cloudMangaer.notes.count)
        return cloudMangaer.notes.count
    }
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    @objc func removeViewFromSuperView() {
        if let subView = self.detailView{
            animateOut()
            self.navigationController?.navigationBar.layer.zPosition = 0
            print("tar bort popup")
        } else {
            print("ikke!!")
            return
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteDate = cloudMangaer.notes[indexPath.row].creationDate
        //        let now = Date()
        //
        //        let formatter = DateComponentsFormatter()
        //        formatter.allowedUnits = [.hour, .minute]
        //        print(formatter.string(from: noteDate!, to: now)!)
        //        let timeDifference = formatter.string(from: noteDate!, to: now)!
        //        print(timeDifference)
        dateFormatter.locale = Locale(identifier: "en_US")
//        print("Records: " ,cloudMangaer.recordIDs[indexPath.row])
//        print("Nr records: " ,self.cloudMangaer.recordIDs.count)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JournalTableViewCell", for: indexPath) as? JournalTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of JournalTableViewCell")
        }
        cell.dateLabel.text = dateFormatter.string(from: noteDate!)
        cell.headlineLabel.text = cloudMangaer.notes[indexPath.row].value(forKey: "journalEntry") as? String ?? "👍"
        cell.emojiLabel.text = cloudMangaer.notes[indexPath.row].value(forKey: "trainingEntry") as? String ?? "👍"

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        cloudMangaer.deletepost(item: cloudMangaer.notes[indexPath.row])
        cloudMangaer.notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView?.refreshControl?.endRefreshing()
        self.tableView?.reloadData()
        self.navItem.title = "Number of notes: \(self.cloudMangaer.notes.count)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        print("radnr: " ,selectedRow)
        didPopup(selectedRow: selectedRow)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    func animateIn() {
        blurView.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.detailView.alpha = 1
            self.detailView.layer.borderColor = UIColor.bgColorFive
                .cgColor
            self.detailView.layer.borderWidth = 1
            self.detailView.center = self.view.center
//            self.detailView.frame = CGRect(x: 10, y: 30, width: self.screenWidth - 20, height: self.screenHeight - 60)
            self.detailView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
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
    
    
    func animateOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.detailView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            self.detailView.alpha = 0
            
        }) { (success:Bool) in
            self.detailView.removeFromSuperview()
            self.blurView.isHidden = true
        }
    }
    
    @objc func queryCloud() {
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        cloudMangaer.database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.cloudMangaer.notes = sortedRecords
            DispatchQueue.main.async {
                self.tableView?.refreshControl?.endRefreshing()
                self.tableView?.reloadData()
                self.navItem.title = "Number of notes: \(self.cloudMangaer.notes.count)"
                print("Inlägg: " ,self.cloudMangaer.notes.count)

            }
        }
    }
    
    func didPopup(selectedRow: Int) {
        self.navigationController?.navigationBar.layer.zPosition = -1
        self.view.layoutIfNeeded()
        let noteDate = cloudMangaer.notes[selectedRow].creationDate
        let now = Date()
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        print(formatter.string(from: noteDate!, to: now)!)
        let timeDifference = formatter.string(from: noteDate!, to: now)!
        print("Time diff: " ,timeDifference)
        dateFormatter.locale = Locale(identifier: "sv")
        detailDateLabel.text = dateFormatter.string(from: noteDate!)
        detailDateLabel.textColor = UIColor.bgColorFive
        detailTextView.text = cloudMangaer.notes[selectedRow].value(forKey: "dailyEntry") as? String ?? "👍"
        detailHeadlineLabel.text = cloudMangaer.notes[selectedRow].value(forKey: "journalEntry") as? String ?? "👍"
        detailCloseButton.layer.cornerRadius = detailCloseButton.frame.height / 2
        detailCloseButton.layer.borderColor = UIColor.bgColorFive.cgColor
        detailCloseButton.layer.borderWidth = 1
        detailCloseButton.setTitleColor(UIColor.bgColorFive, for: .normal)
        view.addSubview(detailView)
        animateIn()
    }
    
}


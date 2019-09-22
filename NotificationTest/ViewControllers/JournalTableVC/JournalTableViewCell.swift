
import UIKit

class JournalTableViewCell: UITableViewCell {
    static var identifier: String {
        return "JournalTableViewCell"
    }
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func config() {
        dateLabel.text = "hej hoppppp"
        
    }
    
}

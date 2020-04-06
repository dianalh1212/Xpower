import UIKit

class PointCellVC: UITableViewCell {

    @IBOutlet weak var addButtonImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteIconImage: UIImageView!
        
    var isFavorite : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

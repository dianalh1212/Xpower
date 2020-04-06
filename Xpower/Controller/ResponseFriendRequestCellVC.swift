//
//  ResponseFriendRequestCellVC.swift
//  Xpower
//
//  Created by hui liu on 6/2/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import UIKit
protocol ResponseButtonDelegate {
    func acceptButtonTapped(at index : IndexPath, friendNameLabel : String)
    func rejectButtonTapped(at index : IndexPath, friendNameLabel : String)
}

class ResponseFriendRequestCellVC: UITableViewCell {
    
    var delegate :ResponseButtonDelegate?
    var indexPath : IndexPath!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var friendNameLabel: UILabel!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        self.delegate?.acceptButtonTapped(at: indexPath, friendNameLabel: friendNameLabel.text!)
    }
    @IBAction func rejectButtonTapped(_ sender: Any) {
        self.delegate?.rejectButtonTapped(at: indexPath, friendNameLabel: friendNameLabel.text!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

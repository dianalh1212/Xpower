//
//  SettingVC.swift
//  Xpower
//
//  Created by hui liu on 5/30/19.
//  Copyright © 2019 hui liu. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet var tbView: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var consoarClientObj = ConsoarClient()
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.backgroundView = UIImageView(image: UIImage(named: "IMG_2125"))
        self.tbView.alpha = 1
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    @objc func stateChanged(_ switchState: UISwitch) {
        
        if switchState.isOn {
            consoarClientObj.toggletouchid(username: username, touchID: true) { (response) in
                print("toggleTouchId is true")
            }
        }
    }

}

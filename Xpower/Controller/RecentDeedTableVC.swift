import UIKit

class RecentDeedTableVC: UIViewController {

    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    var deedsModel = [DeedModel]()
    var consoarClientOBj = ConsoarClient()
    //var username : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempImageView = UIImageView(image: UIImage(named: "IMG_0268"))
        tempImageView.frame = self.tbView.frame
        
        self.tbView.backgroundView = tempImageView
        tbView.register(UINib(nibName: "ReusedCell", bundle: nil), forCellReuseIdentifier: "reusedcell")
        self.tbView.alpha = 1
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
            fetchRecentDeedTableData()
    }
    
    func fetchRecentDeedTableData() {
        print("recentdeed:\(username)")
        if username == nil {
            print("recentDeed username is empty!")
        }
        consoarClientOBj.getRecentDeeds(username: username) { (response) in
            self.deedsModel = response
            DispatchQueue.main.async {
                self.tbView.reloadData()
            } //print("viewdidloadRectentDeedTableVC:\(self.deedsModel)")
        }
    }
}

extension RecentDeedTableVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "reusedcell") as! ReusedCell
        
        cell.taskLabel.text = deedsModel[indexPath.row].deed
        cell.favImage.isHidden = true
        cell.addButtonImage.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // self.tbView.reloadData()
       print("deesModel.count is \(deedsModel.count)")
        return deedsModel.count        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = .clear
    }

}

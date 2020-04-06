import UIKit

class FavoriteDeedTableVC: UIViewController {
    
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    var consoarClientOBj = ConsoarClient()
    var favoriteModel : Favorite?
    //var username : String?
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
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
            fetchFavoriteDeedTableData()
    }
    
    func fetchFavoriteDeedTableData() {
        print("fetchFavoriteDeedTableData:\(username)")
        consoarClientOBj.getFavorites(username: username) { (response) in
            self.favoriteModel = response
            DispatchQueue.main.async {
                self.tbView.reloadData()
            }
        print("fetchFavoriteDeedTableData:\(self.favoriteModel)")
        }
    }
}

extension FavoriteDeedTableVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "reusedcell") as! ReusedCell
        
        //cell.favoriteIconImage.image = UIImage()
        cell.favImage.image = UIImage(named: "favorites")
        cell.addButtonImage.image = UIImage(named: "addTask")
        cell.taskLabel.text = favoriteModel?.taskList[indexPath.row].task

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoriteModel = favoriteModel else {
            print("favoriteMdodel is empty")
            return 0
        }
        return favoriteModel.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = .clear
    }
}


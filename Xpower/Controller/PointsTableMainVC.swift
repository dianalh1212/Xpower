import UIKit

class PointsTableMainVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    var consoarClientOBj = ConsoarClient()
    var pointModelArr : [PointModel] = []
    var searching = false
    var allDeedArr = [String]()
    var searchedDeedArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.backgroundColor = UIColor.clear
        fetchPointsTableData()
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        print("1")
    }
    
    func fetchPointsTableData() {
        print("2")
        consoarClientOBj.getPointsTable { (response) in
            self.pointModelArr = response
            DispatchQueue.main.async {
                self.tbView.reloadData()
                print("3")
            }
           // print("viewdidload:\(self.pointModelArr)")
            //extract all deeds description into allDeedArr
            
            self.allDeedArr = self.createDeedArr(pointModelArr: self.pointModelArr)
           // print(self.searchingDeedArr)
            print("4")
        }
    }
    
    func createDeedArr(pointModelArr: [PointModel]) -> [String] {
        for item in pointModelArr {
            allDeedArr.append(item.description)
        }
        return allDeedArr
    }
}

extension PointsTableMainVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("5")        
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell") as! PointCellVC
        cell.contentView.backgroundColor = UIColor.clear
        if searching {
            cell.descriptionLabel.text = searchedDeedArr[indexPath.row]
        } else {
            cell.descriptionLabel.text = pointModelArr[indexPath.row].description
        }

        cell.favoriteIconImage.image = UIImage(named: "NoFavorite")
        cell.addButtonImage.image = UIImage(named: "addTask")
        
        //do not need to do this
        cell.addButtonImage.tag = indexPath.row
        cell.favoriteIconImage.tag = indexPath.row

        let btntapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonImageTapped(tapGestureRecognizer:)))
        btntapGestureRecognizer.numberOfTapsRequired = 1
        btntapGestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        cell.addButtonImage.isUserInteractionEnabled = true
        cell.addButtonImage.addGestureRecognizer(btntapGestureRecognizer)
        
        
        let favTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteImageTapped(tapGestureRecognizer:)))
        favTapGestureRecognizer.numberOfTapsRequired = 1
        favTapGestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        cell.favoriteIconImage.isUserInteractionEnabled = true
        cell.favoriteIconImage.addGestureRecognizer(favTapGestureRecognizer)
        print("6")
        return cell
    }
    
    @objc func addButtonImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imgView = tapGestureRecognizer.view as! UIImageView
        var selectedDeed : String = ""
        guard let indexPathRow = tapGestureRecognizer.view?.tag else {
            return
        }
        guard indexPathRow >= 0 else {
            print("Array index must be greater than zero. Going to return")
            return
        }
        //prepare deed to be added
        if searching {
            selectedDeed = searchedDeedArr[indexPathRow]
            print("1:\(selectedDeed)")
        } else {
            selectedDeed = pointModelArr[indexPathRow].description
            print("2:\(selectedDeed)")
        }
        
        let date = getDate()
        
        // send add deed request
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        print("add deed \(username)")
        consoarClientOBj.addDeeds(username: username, deed: selectedDeed, date: date) { (response) in
            print("addButtonImageTapped:\(String(describing: response))")
        }
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: Date())
        return date
    }
    
    @objc func favoriteImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //let favView = tapGestureRecognizer.view as! UIImageView
        var favoriteTask : String = ""
        
        guard let indexPathRow = tapGestureRecognizer.view?.tag else {
            return
        }
        guard indexPathRow >= 0 else {
            print("Array index must be greater than zero. Going to  return")
            return
        }
        print("indexPathRow is: \(indexPathRow)")
        
        let indexPath = IndexPath.init(row: indexPathRow, section: 0)
        let cell = tbView.cellForRow(at: indexPath) as! PointCellVC
        
//        guard var isFavorite = pointModelArr[indexPath.row].isFavorite else {
//            print("isFavorite for this deed is empty")
//            return
//        }
         //   print(pointModelArr[indexPath.row].isFavorite)
        //if pointModelArr[indexPath.row].isFavorite == false {

            if searching {
                 favoriteTask = searchedDeedArr[indexPathRow]
//                let indexPath = IndexPath.init(row: indexPathRow, section: 0)
//                let cell = tbView.cellForRow(at: indexPath) as! PointCellVC
                cell.favoriteIconImage.image = UIImage(named: "favorites")
                //print(favoriteTask)
            } else {
                 favoriteTask = pointModelArr[indexPathRow].description
//                let indexPath = IndexPath.init(row: indexPathRow, section: 0)
//                let cell = tbView.cellForRow(at: indexPath) as! PointCellVC
                cell.favoriteIconImage.image = UIImage(named: "favorites")
               // print(favoriteTask)
            }
        
            let username = UserDefaults.standard.string(forKey: "username") ?? ""
            consoarClientOBj.setFavorites(username: username, item: favoriteTask, isFavorite: true) { (response) in
                print("\(String(describing: response))")
                print(favoriteTask)
                //print("setting favorite deed done!")
            }
            pointModelArr[indexPath.row].isFavorite = true
//         } else {
//            if searching {
//                //                let indexPath = IndexPath.init(row: indexPathRow, section: 0)
//                //                let cell = tbView.cellForRow(at: indexPath) as! PointCellVC
//                cell.favoriteIconImage.image = UIImage(named: "NoFavorite")
//                //print(favoriteTask)
//            } else {
//                //                let indexPath = IndexPath.init(row: indexPathRow, section: 0)
//                //                let cell = tbView.cellForRow(at: indexPath) as! PointCellVC
//                cell.favoriteIconImage.image = UIImage(named: "NoFavorite")
//                // print(favoriteTask)
//            }
//
//        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedDeedArr.count
        } else {
            return pointModelArr.count
        }
    }
}

extension PointsTableMainVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedDeedArr = allDeedArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tbView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tbView.reloadData()
    }
}

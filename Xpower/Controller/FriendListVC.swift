import UIKit

class FriendListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ResponseButtonDelegate {
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var friendToBeAdded : String?
    var consoarClientOBj = ConsoarClient()
    var selectedSegment = 1
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    var friendRequestLists : [Request] = []
    var friendLists: [Friend] = []
    var status : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriendList()
        tbView.backgroundColor = UIColor.clear
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        print(username)
        print("1")
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        print("segment called")
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 1
            fetchFriendList()
        } else {
            selectedSegment = 2
            fetchFriendRequestLists()
        }
        tbView.reloadData()
    }
    
    func fetchFriendList() {
        consoarClientOBj.getFriendList(username: username) { (response) in
            self.friendLists = response.friends
            DispatchQueue.main.async {
                self.tbView.reloadData()
                print("13")
            }
            print("fetchFriendListshahahs:\(self.friendLists)")
            print("14")
        }
    }
    
    func fetchFriendRequestLists() {
        print("2")
        consoarClientOBj.getFriendRequest(username: username) { (response) in
            self.friendRequestLists = response.requests
            DispatchQueue.main.async {
                self.tbView.reloadData()
                print("3")
            }
            print("fetchFriendRequestLists111:\(self.friendRequestLists)")
            print("4")
        }
    }
    
    @IBAction func addFriendButton(_ sender: Any) {
        let alertController = UIAlertController(title: "XPower", message: "Send Request", preferredStyle: UIAlertController.Style.alert)

        let saveAction = UIAlertAction(title: "Send", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            self.friendToBeAdded = firstTextField.text
            self.addFriendRequest(receiver :  self.friendToBeAdded!)
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Friend Name"
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addFriendRequest(receiver : String) {
        consoarClientOBj.addFriends(sender: username, receiver: receiver) { (response) in
            print(response)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("15")
        if selectedSegment == 2 {
            return friendRequestLists.count
        } else {
            return friendLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          print("16")
        let cell2 = tbView.dequeueReusableCell(withIdentifier: "friendCell2") as! ResponseFriendRequestCellVC
         // cell2.textLabel?.text  = arr[indexPath.row]
       // cell2.textLabel?.text = friendRequestLists![indexPath.row].username
        let cell1 = tbView.dequeueReusableCell(withIdentifier: "friendCell1")! as UITableViewCell
        
        cell2.delegate = self as? ResponseButtonDelegate 
        cell2.indexPath = indexPath
        cell1.contentView.backgroundColor = UIColor.clear
        cell2.contentView.backgroundColor = UIColor.clear
        
        print("friendRequest list is: \(friendRequestLists)")
        print("friendrequestlist count\(friendRequestLists.count)")
        print("indepath is \(indexPath.row)")
        
            print("17")
        if selectedSegment == 1 {
            cell1.textLabel?.text = friendLists[indexPath.row].username
            return cell1
        } else {
            if friendRequestLists.count > 0 {
                cell2.friendNameLabel.text = friendRequestLists[indexPath.row].username
            }
            return cell2
        }
    }
    //todo :handle delete
    func acceptButtonTapped(at index : IndexPath, friendNameLabel: String) {
        status = 2

        consoarClientOBj.responseFriendRequest(sender: friendNameLabel, receiver: username, status: status!) { (response) in

        }
        
    }
    //todo :handle delete
    func rejectButtonTapped(at index : IndexPath, friendNameLabel: String) {
        status = 0
        consoarClientOBj.responseFriendRequest(sender: friendNameLabel, receiver: username, status: status!) { (response) in

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChatVC {
            destination.friendName = friendLists[(tbView.indexPathForSelectedRow?.row)!].username!
            tbView.deselectRow(at: tbView.indexPathForSelectedRow!, animated: true)
        }
    }
            
}

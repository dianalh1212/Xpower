//
//  MenuVC.swift
//  
//
//  Created by hui liu on 5/28/19.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    var menuNameArr : [String] = [String]()
    var filename :String?
    @IBOutlet weak var tbView: UITableView!
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        menuNameArr = ["Home", "Points", "Score", "Friends", "Settings", "Logout"]
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "IMG_0268.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        self.tbView.backgroundView = UIImageView(image: UIImage(named: "IMG_0268.jpg"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let filename = UserDefaults.standard.string(forKey: "filename") ?? ""
        if username != "" {
        profileImage.image = loadImageFromDocumentDirectory(nameOfImage: filename)
        }
    }
    
    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage.init(named: "default.png")!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellVC") as! MenuCellVC
        cell.itemLabel.textAlignment = .center
        cell.backgroundColor = .clear
        cell.itemLabel.text! = menuNameArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealviewcontroller:SWRevealViewController = self.revealViewController()

        let cell:MenuCellVC = tableView.cellForRow(at: indexPath) as! MenuCellVC

        if cell.itemLabel.text! == "Home"
        {
            print("Home Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)

        }
        if cell.itemLabel.text! == "Points"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarController = mainstoryboard.instantiateViewController(withIdentifier: "TabBarVC") as? UITabBarController {
                tabBarController.selectedIndex = 0
                revealviewcontroller.pushFrontViewController(tabBarController, animated: true)
            }
        }
        
        if cell.itemLabel.text! == "Score"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "SchoolPointsVC") as! SchoolPointsVC
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        
        if cell.itemLabel.text! == "Friends"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "FriendListVC") as! FriendListVC
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        
        if cell.itemLabel.text! == "Settings"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "Settings") as! SettingVC
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
        
        if cell.itemLabel.text! == "Logout"
        {
            //todo go back to login screnn
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
            print(UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN"))
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
    }
}

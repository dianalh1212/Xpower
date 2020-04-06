import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    var tabBarIteam = UITabBarItem()

    @IBOutlet weak var tab: UITabBar!

    override func viewDidLoad() {
        self.delegate = self
        super.viewDidLoad()

    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
//        if viewController is FirstViewController {
//            print("First tab")
//        } else if viewController is SecondViewController {
//            print("Second tab")
//        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //print("Selected item", item.tag )
        
    }
    


}

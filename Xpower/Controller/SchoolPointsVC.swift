import UIKit

class SchoolPointsVC: UIViewController {
    
    var consoarClientOBj = ConsoarClient()
    var totalPoints : SchoolPoints?
    let hschoolname = "Haverford"
    let aschoolname = "Agnes Irwin"

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var aSchoolPoints: UILabel!
    @IBOutlet weak var hschoolPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchhSchoolPoints(hschoolname: hschoolname)
        fetchaSchoolPoints(aschoolname: aschoolname)
        
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    func fetchhSchoolPoints(hschoolname : String) {
        consoarClientOBj.getSchoolPoints(schoolname: hschoolname) { (response) in
            self.totalPoints = response            
            DispatchQueue.main.async {
                self.hschoolPoints.text = "\(String(describing: self.totalPoints!.totalpoints))"
            }
        }
    }
    
    func fetchaSchoolPoints(aschoolname : String) {
        consoarClientOBj.getSchoolPoints(schoolname: aschoolname) { (response) in
        self.totalPoints = response
        DispatchQueue.main.async {
            self.aSchoolPoints.text = "\(String(describing: self.totalPoints!.totalpoints))"
            }
        }
    }
}

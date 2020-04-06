import UIKit

class HomePageViewController: UIViewController {
    
    var consoarClientOBj = ConsoarClient()
    var dailyPoint : DailyPoint!
    var totalPoint : TotalPoint!
    var progress : Progress!
    let maxPoint = 500.00
    var imageArr = [UIImage]()
    var stageForMonth = ["Apr": 0, "Aug": 0, "Dec": 0, "Feb": 0, "Jan": 0, "Jul": 0, "Jun": 0, "Mar": 0, "May": 0, "Nov": 0, "Oct": 0, "Sep": 0]
    var progressForMonth = ["Apr": 0.0, "Aug": 0.0, "Dec": 0.0, "Feb": 0.0, "Jan": 0.0, "Jul": 0.0, "Jun": 0.0, "Mar": 0.0, "May": 0.0, "Nov": 0.0, "Oct": 0.0, "Sep": 0.0]
    var pointsForMonth = ["Apr": 0, "Aug": 0, "Dec": 0, "Feb": 0, "Jan": 0, "Jul": 0, "Jun": 0, "Mar": 0, "May": 0, "Nov": 0, "Oct": 0, "Sep": 0]
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var totalPointLabel: UILabel!
    @IBOutlet weak var dailyPointLabel: UILabel!
    
    @IBOutlet weak var JanImage: UIImageView!
    @IBOutlet weak var feb: UIImageView!
    @IBOutlet weak var mar: UIImageView!
    @IBOutlet weak var apr: UIImageView!
    @IBOutlet weak var may: UIImageView!
    @IBOutlet weak var jun: UIImageView!
    @IBOutlet weak var jul: UIImageView!
    @IBOutlet weak var aug: UIImageView!
    @IBOutlet weak var sep: UIImageView!
    @IBOutlet weak var oct: UIImageView!
    @IBOutlet weak var nov: UIImageView!
    @IBOutlet weak var dec: UIImageView!
    
    @IBOutlet weak var m1: UILabel!
    @IBOutlet weak var m2: UILabel!
    @IBOutlet weak var m3: UILabel!
    @IBOutlet weak var m4: UILabel!
    @IBOutlet weak var m5: UILabel!
    @IBOutlet weak var m6: UILabel!
    @IBOutlet weak var m7: UILabel!
    @IBOutlet weak var m8: UILabel!
    @IBOutlet weak var m9: UILabel!
    @IBOutlet weak var m10: UILabel!
    @IBOutlet weak var m11: UILabel!
    @IBOutlet weak var m12: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArr.append(UIImage(named: "Tree1.png")!)
        imageArr.append(UIImage(named: "Tree3.png")!)
        imageArr.append(UIImage(named: "Tree4.png")!)
        imageArr.append(UIImage(named: "Tree5.png")!)
        imageArr.append(UIImage(named: "Tree6.png")!)
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserDailyPoints()
        getUserTotalPoints()
        getUserProgress()
    }
    
    func getUserDailyPoints() {
         print("getUserDailyPoints username:\(username)")
        consoarClientOBj.getUserDailyPoints(username: username) { (response) in
            self.dailyPoint = response
            DispatchQueue.main.async {
                if self.dailyPoint != nil {
                    self.dailyPointLabel.text = "\(self.dailyPoint!.dailypoints)"
                } else {
                    self.dailyPointLabel.text = "0"
                }
            }
        }
    }
    
    func getUserTotalPoints() {
        consoarClientOBj.getUserTotalPoints(username: username) { (response) in
            self.totalPoint = response
            DispatchQueue.main.async {
                if self.totalPoint != nil {
                self.totalPointLabel.text = "\(self.totalPoint!.totalpoints)"
                } else {
                    self.totalPointLabel.text = "0"
                }
            }
        }
    }
    
    func getUserProgress() {
        consoarClientOBj.getUserProgress(username: username) { (response) in
            self.progress = response
            DispatchQueue.main.async {
                self.assignPoints(progress: self.progress)
                print("progress:")
                print(self.progress)
                print("pointsfotmont:")
                print(self.pointsForMonth)
                
                self.caculateProgressForEachMonth(progress: self.progress)
                self.caculateStage(pointsForMonth: self.progressForMonth)
                self.showImages(stageForMonth: self.stageForMonth)
                self.showProgress(progressForMonth: self.progressForMonth)
                print("caculateProgressForEachMonth: \(self.caculateProgressForEachMonth)")
                print("stage for 12 monts\(self.stageForMonth)")
            }
        }
        
    }
    
    func assignPoints(progress: Progress) {
        pointsForMonth["Apr"] = progress.Apr
        pointsForMonth["Aug"] = progress.Aug
        pointsForMonth["Dec"] = progress.Dec
        pointsForMonth["Nov"] = progress.Nov
        pointsForMonth["Feb"] = progress.Feb
        pointsForMonth["Jan"] = progress.Jan
        pointsForMonth["Jul"] = progress.Jul
        pointsForMonth["Jun"] = progress.Jun
        pointsForMonth["Mar"] = progress.Mar
        pointsForMonth["May"] = progress.May
        pointsForMonth["Oct"] = progress.Oct
        pointsForMonth["Sep"] = progress.Sep
    }

    func caculateProgressForEachMonth(progress: Progress) {
        progressForMonth["Apr"] = Double(progress.Apr)*100 / maxPoint
        //print("progress.Jan / maxPoint: \(Float(progress.Jan / maxPoint))")
        progressForMonth["Aug"] = Double(progress.Aug)*100 / maxPoint
        progressForMonth["Dec"] = Double(progress.Dec)*100 / maxPoint
        progressForMonth["Nov"] = Double(progress.Nov)*100 / maxPoint
        progressForMonth["Feb"] = Double(progress.Feb)*100 / maxPoint
        progressForMonth["Jan"] = Double(progress.Jan)*100 / maxPoint
        progressForMonth["Jul"] = Double(progress.Jul)*100 / maxPoint
        progressForMonth["Jun"] = Double(progress.Jun)*100 / maxPoint
        progressForMonth["Mar"] = Double(progress.Mar)*100 / maxPoint
        progressForMonth["May"] = Double(progress.May)*100 / maxPoint
        progressForMonth["Oct"] = Double(progress.Oct)*100 / maxPoint
        progressForMonth["Sep"] = Double(progress.Sep)*100 / maxPoint
        print("progressfor jan\(progressForMonth["Jan"])")
        print(progressForMonth["Jan"])
    }
    
    func caculateStage(pointsForMonth : [String : Double]) {
        for item in pointsForMonth {
            stageForMonth[item.key] = checkStage(item: item)
        }
    }
    
    func checkStage(item : (String , Double)) -> Int {
        let someNumber = item.1
        switch someNumber {
        case 0...20:
            return 1
        case 21...50:
            return 2
        case 51...100:
            return 3
        case 101...150:
            return 4
        case 151...:
            return 5
        default:
            return 0
        }
    }
    
    func showImages(stageForMonth: [String : Int]) {
        JanImage.image = imageArr[stageForMonth["Jan"]! - 1]
        feb.image = imageArr[stageForMonth["Feb"]! - 1]
        mar.image = imageArr[stageForMonth["Mar"]! - 1]
        apr.image = imageArr[stageForMonth["Apr"]! - 1]
        may.image = imageArr[stageForMonth["May"]! - 1]
        jun.image = imageArr[stageForMonth["Jun"]! - 1]
        jul.image = imageArr[stageForMonth["Jul"]! - 1]
        aug.image = imageArr[stageForMonth["Aug"]! - 1]
        sep.image = imageArr[stageForMonth["Sep"]! - 1]
        oct.image = imageArr[stageForMonth["Oct"]! - 1]
        nov.image = imageArr[stageForMonth["Nov"]! - 1]
        dec.image = imageArr[stageForMonth["Dec"]! - 1]
        
    }
    
    func showProgress(progressForMonth : [String : Double]) {
        m1.text = "\(progressForMonth["Jan"]!)%"
        m2.text = "\(progressForMonth["Feb"]!)%"
        m3.text = "\(progressForMonth["Mar"]!)%"
        m4.text = "\(progressForMonth["Apr"]!)%"
        m5.text = "\(progressForMonth["May"]!)%"
        m6.text = "\(progressForMonth["Jun"]!)%"
        m7.text = "\(progressForMonth["Jul"]!)%"
        m8.text = "\(progressForMonth["Aug"]!)%"
        m9.text = "\(progressForMonth["Sep"]!)%"
        m10.text = "\(progressForMonth["Oct"]!)%"
        m11.text = "\(progressForMonth["Nov"]!)%"
        m12.text = "\(progressForMonth["Dec"]!)%"
    }

}



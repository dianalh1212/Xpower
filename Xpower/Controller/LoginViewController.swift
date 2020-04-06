import UIKit
//import SwiftKeychainWrapper
import Alamofire
import LocalAuthentication

class LoginViewController: UIViewController, DataEnteredDelegate {
    
    var image : UIImage = UIImage()
    func userDidEnterInformation(info: UIImage) {
        image = info
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    @IBOutlet weak var remerberMe: UISwitch!
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
    
    var consoarClientOBj = ConsoarClient()
    var user = User()
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    var touchIDEnable : Bool?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getCurrentUserToogleTouchIDStatus()
          
        }
       
        remerberMe.addTarget(self, action: #selector(self.stateChanged), for: .valueChanged)
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            //user is already logged in just navigate him to home screen, perfome segue
             self.performSegue(withIdentifier: "goToSW", sender: nil)

            appDelegate.changeRootViewControllerToSWRevealViewController()
        }
    }
    
    func getCurrentUserToogleTouchIDStatus() {
        consoarClientOBj.getCurrentUser(username: username) { (user) in
            self.touchIDEnable = user.touchIdOn
            print("touchID enable or not?")
                if self.touchIDEnable! {
                    let context = LAContext()
                    var error: NSError?
                    // 2
                    // check if Touch ID is available
                    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                        // 3
                        let reason = "Authenticate with Touch ID"
                        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                            {(success, error) in
                                // 4
                                if success {
                                    self.showAlertController("Touch ID Authentication Succeeded")
                                    self.performSegue(withIdentifier: "goToSW", sender: nil)
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    appDelegate.changeRootViewControllerToSWRevealViewController()
                                }
                                else {
                                    self.showAlertController("Touch ID Authentication Failed")
                                }
                        })
                    }
                        // 5
                    else {
                        //self.showAlertController("Touch ID not available")
                    }
                }
            
        }
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func stateChanged(_ switchState: UISwitch) {
        
        if switchState.isOn {
            //let saveUserId: Bool = KeychainWrapper.standard.set(usernameTextField.text!, forKey: "username")
            print("isOn")
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            //let savePassword: Bool = KeychainWrapper.standard.set(passwordTextField.text!, forKey: "password")
            
//            print(saveUserId)
//            print(savePassword)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(usernameTextField.text!, forKey: "username")
        let name = UserDefaults.standard.string(forKey: "username") ?? ""
        print("userdefault save username is:\(name)")
        consoarClientOBj.loginRequest(username: usernameTextField.text!, password: passwordTextField.text!) { (response) in
            self.user.username = response.username
            
            print("loginButtonPressed: \(self.user.username)")
            DispatchQueue.main.async {
                print("login userdefault save:\(self.user.username)")
                self.performSegue(withIdentifier: "goToSW", sender: nil)
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewControllerToSWRevealViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSW"  {
            let swVC = segue.destination as! SWRevealViewController
        }
        
        if segue.identifier == "goToSignUp" {
            let signUpController = segue.destination as! SignUpViewController
            signUpController.delegate = self
        }
    }
}


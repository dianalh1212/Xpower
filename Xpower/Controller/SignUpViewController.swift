import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: UIImage)
}

class SignUpViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
     weak var delegate: DataEnteredDelegate? = nil
    
    var user = User()
    var filename : String?
    var consoarClientOBj = ConsoarClient()
    
    let schoolDic : [String : String] = ["Haverford" : "harverford.org", "Anges Irwin" : "angesIrwin.org"]
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailIDTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "bg_name.png")
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func selectSchoolButtonPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "XPower", message: "Select school", preferredStyle: .actionSheet)
        let school1 = UIAlertAction(title: "Haverford", style: .default) { action in
            self.changeSchoolLabel(schoolName : "Haverford", schoolNameEmail: self.schoolDic["Haverford"]!)
        }
        let school2 = UIAlertAction(title: "Anges Irwin", style: .default) { action in
            self.changeSchoolLabel(schoolName : "Anges Irwin", schoolNameEmail: self.schoolDic["Anges Irwin"]!)
        }
        actionSheet.addAction(school1)
        actionSheet.addAction(school2)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func changeSchoolLabel(schoolName :String, schoolNameEmail : String) {
        schoolLabel.text = "@" + schoolNameEmail
        user.schoolName = schoolName
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {        
        guard let username = usernameTextField.text, usernameTextField.text?.count != 0 else {
            createAlert(title: "you forget to input email", message: "Do you?")
            return
        }
        
        guard let email = emailIDTextField.text, emailIDTextField.text?.count != 0 else {
            createAlert(title: "you forget to input email", message: "Do you?")
            return
        }
        
        guard let password = passwordTextField.text, passwordTextField.text?.count != 0 else {
            createAlert(title: "you forget to input password", message: "Do you?")
            return
        }
        
        guard let repeatpassword = confirmPasswordTextField.text, confirmPasswordTextField.text?.count != 0 else {
            createAlert(title: "you forget to input confirm password", message: "Do you?")
            return
        }
        
        if (password != repeatpassword) {
            createAlert(title: "your password do not match", message: "Do you?")
        }

            user.username = username
            user.email = email + schoolLabel.text!
            user.password = password
        //To do
            user.avatar = false
            user.avatarImageUrl = ""
            user.touchIdOn = false
        
        consoarClientOBj.createUserAccount(user: user)//{
//            (response, error) in
//            guard (error == nil) else {
//                print("this Error")
//                return
//            }
//            guard let dataResponse = response else {
//                print("response Error")
//                return
//            }
//            print ("\(dataResponse)")
//}
        delegate?.userDidEnterInformation(info: avatarImageView!.image!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.sourceType = UIImagePickerController.SourceType.photoLibrary
        imageVC.allowsEditing = false
        self.present(imageVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("error to pick image")
            return
        }
        avatarImageView.image = image
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        saveImageToDocumentDirectory(image: image, filename :fileUrl.lastPathComponent)
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveImageToDocumentDirectory(image: UIImage, filename : String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        if let data = image.jpegData(compressionQuality:1.0), !FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
                self.filename = filename
                UserDefaults.standard.set(self.filename, forKey: "filename")
            } catch {
                print("error saving file:", error)
            }
        }
    }
}

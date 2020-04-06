import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var friendName = ""
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    @IBOutlet weak var chatView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    var consoarClientOBj = ConsoarClient()
    var messages : Messages?
    var message : String?

    var messageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(friendName)
        print(username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("wiil appear")
        getMessages()
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let date = getDate()
        consoarClientOBj.sendMessage(sender: username, receiver: friendName, message: inputTextField.text!, dateTime: date) { (response) in
            print("sendmessage")
         //  print(response)
            self.getMessages()
        }
    }
    
    func getMessages() {
        let date = "2019-06-04 17:14:51"
        consoarClientOBj.getMessage(sender: username, receiver: friendName,  dateTime: date) { (response) in
            print("dfjakfdjs")
            print(response)
            //print(self.messages?.messages.last?.message)
            DispatchQueue.main.async {
                self.message = response.messages.last?.message
                print("last message")
              //  print(self.message)
                self.messageArray.append(self.message!)
                self.chatView.reloadData()

            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = chatView.dequeueReusableCell(withIdentifier: "chatCell1")! as UITableViewCell
//        let cell2 = chatView.dequeueReusableCell(withIdentifier: "chatCell1")! as UITableViewCell
        
            cell1.textLabel!.text = messageArray[indexPath.row]
        return cell1
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: Date())
        return date
    }
    
}

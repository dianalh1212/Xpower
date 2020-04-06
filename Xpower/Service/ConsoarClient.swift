import Foundation
import Alamofire
import SwiftyJSON

class ConsoarClient: NSObject {

    func loginRequest(username : String, password: String, completion: @escaping (_ responseData: User) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/UserService.svc/userauthentication")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username, "Password" : password]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let user = try? JSONDecoder().decode(User.self, from: data) else {
                    return
            }
            print("c")
            completion(user)
            print("d")
            print("networkClient response for login in: \(user)")
        }
        print("e")
        task.resume()
    }

    func createUserAccount(user : User) {
        let urlString = "http://www.consoaring.com/UserService.svc/CreateUserAccount"
        
        let url = URL(string: urlString)!
        
        let json = "{\"Username\": \"\(user.username)\",\"Password\": \"\(user.password)\",\"Email\": \"\(user.email)\",\"SchoolName\": \"\(user.schoolName)\",\"Avatar\": \"\(user.avatar)\",\"Avatarimageurl\": \"\(user.avatarImageUrl)\",\"TouchIdOn\": \"\(user.touchIdOn)\"}"
        print("this is body:\(json)")
        let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
        var request = URLRequest(url: url)
        print("ConsoarClient.createUserAccount:\(user.username)")
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON {
            response in
            switch (response.result) {
            case .success:
                print(response)
                print(response.result)
                break
            case .failure:
                print("can not \(Error.self)")
                print()
                break
            }
        }
    }
    
    func getUserDailyPoints(username : String, completion: @escaping (_ responseData: DailyPoint) -> ()) {
        let url = String(format: "http://www.consoaring.com/PointService.svc/dailypoints")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username, "Year" : "2019"]
        print(parameterDict)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let dailyPoint = try? JSONDecoder().decode(DailyPoint.self, from: data) else {
                    return
            }
            print("c")
            completion(dailyPoint)
            print("d")
            print("networkClient response for dailyPoint: \(dailyPoint)")
        }
        print("e")
        task.resume()
    }
    
    func getUserTotalPoints(username : String, completion: @escaping (_ responseData: TotalPoint) -> ()) {
        let url = String(format: "http://www.consoaring.com/PointService.svc/totalpoints")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let totalPoint = try? JSONDecoder().decode(TotalPoint.self, from: data) else {
                    return
            }
            print("c")
            completion(totalPoint)
            print("d")
            print("networkClient response for totalPoint: \(totalPoint)")
        }
        print("e")
        task.resume()
    }
    
    func getUserProgress(username : String, completion: @escaping (_ responseData: Progress) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/PointService.svc/getuserprogress")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username, "Year" : "2019"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let progress = try? JSONDecoder().decode(Progress.self, from: data) else {
                    return
            }
            print("c")
            completion(progress)
            print("d")
            print("networkClient response for user progress: \(progress)")
        }
        print("e")
        task.resume()
    }
    
    func getPointsTable(completion: @escaping (_ responseData: [PointModel]) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/PointService.svc/pointstable")
        guard let serviceUrl = URL(string: url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let pointModel = try? JSONDecoder().decode([PointModel].self, from: data) else {
                    return
            }
            print("c")
            completion(pointModel)
            print("d")
            //print("networkClient response for pointModel: \(pointModel)")
        }
        print("e")
        task.resume()
    }

    func addDeeds(username : String, deed: String, date : String, completion: @escaping (_ responsedata: NSDictionary?) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/PointService.svc/adddeeds")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["user" : username, "deed" : deed, "date" :date]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            if let data = data {
            do {
                 let json = try JSONSerialization.jsonObject(with: data)
                     completion(json as? NSDictionary)
                }catch {
                    print(error)
                }
            }
            print("c")
        }
        print("e")
        task.resume()
    }
    
    func setFavorites(username : String, item: String, isFavorite : Bool, completion: @escaping (_ responsedata: NSDictionary?) -> ()) {
        let url = String(format: "http://www.consoaring.com/PointService.svc/setfavoritetask")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username, "Task" : item, "IsFavorite": isFavorite] as [String : Any]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(json as? NSDictionary)
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getFavorites(username : String, completion: @escaping (_ responseData: Favorite) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/PointService.svc/getfavoritetasks")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let favorite = try? JSONDecoder().decode(Favorite.self, from: data) else {
                    return
            }
            print("c")
            completion(favorite)
            print("d")
           // print("networkClient response for getFavorites: \(favorite)")
        }
        print("e")
        task.resume()
    }
    
    func getRecentDeeds(username : String, completion: @escaping (_ responseData: [DeedModel]) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/PointService.svc/getrecentdeeds")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let deeds = try? JSONDecoder().decode([DeedModel].self, from: data) else {
                    return
            }
            print("c")
            completion(deeds)
            print("d")
            //print("networkClient response for recentDeeds: \(deeds)")
        }
        print("e")
        task.resume()
    }
    
    func getSchoolPoints(schoolname : String, completion: @escaping (_ responseData: SchoolPoints) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/PointService.svc/totalschoolpoints")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["SchoolName" : schoolname]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let points = try? JSONDecoder().decode(SchoolPoints.self, from: data) else {
                    return
            }
            print("c")
            completion(points)
            print("d")
            print("networkClient response for schoolPoints: \(points)")
        }
        print("e")
        task.resume()
    }
    
    func addFriends(sender : String, receiver: String,  completion: @escaping (_ responsedata: NSDictionary?) -> ()) {
        let url = String(format: "http://www.consoaring.com/UserService.svc/addfriendrequest")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Sender" : sender, "Reciever" : receiver]
        print(parameterDict)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(json as? NSDictionary)
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getFriendRequest(username : String, completion: @escaping (_ responseData: FriendRequestLists) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/UserService.svc/getfriendrequests")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let friendRequestLists = try? JSONDecoder().decode(FriendRequestLists.self, from: data) else {
                    return
            }
            print("c")
            completion(friendRequestLists)
            print("d")
           // print("networkClient response for friendRequestLists: \(friendRequestLists)")
        }
        print("e")
        task.resume()
    }
    
    func getFriendList(username : String, completion: @escaping (_ responseData: FriendLists) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/UserService.svc/getfriendslist")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let friendLists = try? JSONDecoder().decode(FriendLists.self, from: data) else {
                    print("error decode")
                    return
            }
            print("c")
            completion(friendLists)
            print("d")
            //print("networkClient response for friendLists: \(friendLists)")
        }
        print("e")
        task.resume()
    }
    
    func responseFriendRequest(sender : String, receiver: String,  status: Int, completion: @escaping (_ responsedata: NSDictionary?) -> ()) {
        let url = String(format: "http://www.consoaring.com/UserService.svc/respondfriendrequest")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Sender" : sender, "Reciever" : receiver, "Status" : status] as [AnyHashable : Any]
        print(parameterDict)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(json as? NSDictionary)
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func sendMessage(sender : String, receiver: String,  message: String, dateTime: String, completion: @escaping (_ responsedata: NSDictionary?) -> ()) {
        let url = String(format: "http://www.consoaring.com/ChatService.svc/sendmessage")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Sender" : sender, "Reciever" : receiver, "Message" : message, "DateAndTime" : dateTime]
        
        print(parameterDict)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(json as? NSDictionary)
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getMessage(sender : String, receiver: String, dateTime: String, completion: @escaping (_ responseData: Messages) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/ChatService.svc/getmessages")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Sender" : sender, "Reciever" : receiver, "DateAndTime" : dateTime]
        print(parameterDict)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let message = try? JSONDecoder().decode(Messages.self, from: data) else {
                    print("error decode")
                    return
            }
            print("c")
            completion(message)
            print("d")
            //print("networkClient response for friendLists: \(message)")
        }
        print("e")
        task.resume()
    }
    
    func toggletouchid(username : String, touchID: Bool, completion: @escaping (_ responsedata: NSDictionary?) -> ()) {
        let url = String(format: "http://www.consoaring.com/UserService.svc/toggletouchid")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : touchID, "TouchIdOn" : touchID]
        
        print(parameterDict)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    completion(json as? NSDictionary)
                }catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getCurrentUser(username : String, completion: @escaping (_ responseData: CurrentUser) -> ()) {
        print("a")
        let url = String(format: "http://www.consoaring.com/UserService.svc/getcurrentuser")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDict = ["Username" : username]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("b")
            guard let data = responseData,
                let cuser = try? JSONDecoder().decode(CurrentUser.self, from: data) else {
                    return
            }
            print("c")
            completion(cuser)
            print("d")
            print("networkClient response for getCurrentUser: \(cuser)")
        }
        print("e")
        task.resume()
    }
}



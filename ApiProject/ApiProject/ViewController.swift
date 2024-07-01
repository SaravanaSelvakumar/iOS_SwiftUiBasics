//
//  ViewController.swift
//  ApiProject
//
//  Created by Apzzo Technologies Private Limited on 12/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
          async {
              do {
                  let userInfo = try await user()
                  DispatchQueue.main.async {
                      self.updateUI(with: userInfo)
                  }
              } catch {
                  // Handle error
                  print("Error fetching user info: \(error)")
              }
          }
      }
    
    func updateUI(with userInfo: UserInfo) {
           usernamelabel.text = userInfo.login
           bioLabel.text = userInfo.bio
           
           guard let url = URL(string: userInfo.avatarUrl) else {
               print("Invalid avatar URL")
               return
           }
           
           // Download and set user avatar image
           async {
               do {
                   let (data, _) = try await URLSession.shared.data(from: url)
                   DispatchQueue.main.async {
                       self.imageV.image = UIImage(data: data)
                   }
               } catch {
                   // Handle error
                   print("Error downloading avatar image: \(error)")
               }
           }
       }
   
    
    func user() async throws -> UserInfo {
          let endpoint = "https://api.github.com/users/SivakumarK-github"
          guard let url = URL(string: endpoint) else {
              throw Errors.invaildURl 
          }
          
          let (data, response) = try await URLSession.shared.data(from: url)
          
          guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
              throw Errors.invalidResponse
          }
          
          do {
              let decoder = JSONDecoder()
              decoder.keyDecodingStrategy = .convertFromSnakeCase
              return try decoder.decode(UserInfo.self, from: data)
          } catch {
              throw Errors.invalidData
          }
      }
   
    
    enum Errors: Error {
    case invaildURl
        case invalidResponse
              case invalidData
    }

    struct UserInfo: Codable {
        let login: String
        let avatarUrl: String
        let bio: String?
    }

}




//
//  Account.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit

class AccountVC: UIViewController{
    
    static let name  = "AccountVC"
    static let StoryBoard  = "Account"
    
    class func instantiateFromStoryboard() -> UIViewController{
        let vc = UIStoryboard(name: AccountVC.StoryBoard, bundle: nil).instantiateViewController(withIdentifier: AccountVC.name) as! AccountVC
        return vc
    }
}

//
//  Home.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController{
    
    static let name = "HomeVC"
    static let storyBoard = "Home"
    
    class func instantiateFromStoryboard() -> HomeVC {
        let vc = UIStoryboard(name: HomeVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: HomeVC.name) as! HomeVC
        return vc
    }
    
    override func viewDidLoad() {
    
    }
    
   
    
    
    
}


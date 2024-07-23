//
//  TabbarManager.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit


class TabbarManagerVC: UITabBarController {
    static let name = "TabbarManagerVC"
    static let storyBoard = "Main"
    
    class func instantiateFromStoryboard() -> TabbarManagerVC {
        let vc = UIStoryboard(name: TabbarManagerVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: TabbarManagerVC.name) as! TabbarManagerVC
        return vc
    }
    
    // MARK: - Variable Declaration
    
    let tabbar = CustomTabbar()
    let viewControllerFactories: [(title: String, image: String, tag: Int, factory: () -> UIViewController)] = [
        ("HomeVc", "home_icon", 0, { HomeVC.instantiateFromStoryboard() }),
        ("ChatVc", "cart_icon", 1, { CartVC.instantiateFromStoryboard() }),
        ("Gallery", "camera_icon", 2, { CameraVC.instantiateFromStoryboard() }),
        ("AccountVC", "account_icon", 3, { AccountVC.instantiateFromStoryboard() })
    ]
    
    // MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbar.createTabbarControllers(tabBar: self, viewControllerFactories: viewControllerFactories)
        CustomTabbar.setupTabbarAppearance(tabBar: tabBar, backgroundColor: UIColor(red: 243/255.0, green: 110/255.0, blue: 80/255.0, alpha: 1.0), barTintColor: .white, unselectedItemTintColor: .white, tintColor: .black)
    }
}


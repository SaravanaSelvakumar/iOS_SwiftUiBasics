//
//  CustomTabbar.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit

class CustomTabbar {
    
    
    func createTabbarControllers(tabBar: UITabBarController, viewControllerFactories: [(title: String, image: String, tag: Int, factory: () -> UIViewController)]) {
        
        var viewControllers: [UIViewController] = []
        
        for (title, imageName, tag, factory) in viewControllerFactories {
            let viewController = factory()
            let navigationController = CustomNavigationController(rootViewController: viewController)
            navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), tag: tag)
            viewControllers.append(navigationController)
        }
        
        tabBar.viewControllers = viewControllers
        tabBar.selectedIndex = 2 // Adjust as needed
    }
    
    //************************************************************************************************************//
    
    //example or use case of createTabbarControllers func
    
    let viewControllerFactories: [(title: String, image: String, tag: Int, factory: () -> UIViewController)] = [
        ("HomeVc", "home_icon", 0, { HomeVC.instantiateFromStoryboard() }),
        ("ChatVc", "cart_icon", 1, { CartVC.instantiateFromStoryboard() }),
        ("Gallery", "camera_icon", 2, { CameraVC.instantiateFromStoryboard() }),
        ("AccountVC", "account_icon", 3, { AccountVC.instantiateFromStoryboard() })
    ]
    
    
    /*    override func viewDidLoad() {
          super.viewDidLoad()
          CustomTabbar.createTabbarControllers(tabBar: self, viewControllerFactories: viewControllerFactories)
          CustomTabbar.setupTabbarAppearance(tabBar: tabBar, backgroundColor: UIColor(red: 243/255.0, green: 110/255.0, blue: 80/255.0, alpha: 1.0), barTintColor: .white, unselectedItemTintColor: .white, tintColor: .black)
           }            */
    
//*****************************************************************************************************************//
    
    
    static func setupTabbarAppearance(tabBar: UITabBar, backgroundColor: UIColor , barTintColor: UIColor, unselectedItemTintColor: UIColor, tintColor:UIColor) {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = backgroundColor
        tabBar.barTintColor = barTintColor
        tabBar.unselectedItemTintColor = unselectedItemTintColor
        tabBar.tintColor = tintColor
        tabBar.overrideUserInterfaceStyle = .light
        tabBar.clipsToBounds = true
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = false
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
 //************************************************************************************************************//

    // model function
    
    func exampleTabbarControllers(tabBar: UITabBarController) {
        
        let cameraViewController = CameraVC.instantiateFromStoryboard()
        let cameraVC = CustomNavigationController(rootViewController: cameraViewController)
        cameraVC.tabBarItem = UITabBarItem(title: "Gallery", image: UIImage(named: "tutorImg"), tag: 2)
        
        let homeViewController = HomeVC.instantiateFromStoryboard()
        let homeVC = CustomNavigationController(rootViewController: homeViewController)
        homeVC.tabBarItem = UITabBarItem(title: "HomeVc", image: UIImage(named: "groupChats_students"), tag: 0)
        
        let cartViewController = CartVC.instantiateFromStoryboard()
        let cartVC = CustomNavigationController(rootViewController: cartViewController)
        cartVC.tabBarItem = UITabBarItem(title: "CartVc", image: UIImage(named: "assignments_students"), tag: 1)
        
        let accountViewController = AccountVC.instantiateFromStoryboard()
        let accountVC = CustomNavigationController(rootViewController: accountViewController)
        accountVC.tabBarItem = UITabBarItem(title: "AccountVC", image: UIImage(named: "student_chat"), tag: 3)
        
        tabBar.viewControllers = [homeVC, cartVC, cameraVC, accountVC]
        tabBar.selectedIndex = 2
    }
    
    func defaultTabbarAppearance(tabBar: UITabBar) {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .red
        tabBar.overrideUserInterfaceStyle = .light
        tabBar.clipsToBounds = true
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = false
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    
}

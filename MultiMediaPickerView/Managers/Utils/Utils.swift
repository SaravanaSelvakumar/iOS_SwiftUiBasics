//
//  Utils.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit


class Utils: NSObject {
    
    class func setRootController(rootVCType: RootVCType) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        switch rootVCType {
        case .main:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: TabbarManagerVC.instantiateFromStoryboard())
        case .homeVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: HomeVC.instantiateFromStoryboard())
            
        case .cartVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: CartVC.instantiateFromStoryboard())
        case .accountVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: AccountVC.instantiateFromStoryboard())
        }
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
    
}

//
//  File.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    
    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            appearance.configureWithOpaqueBackground()
            navigationBar.barTintColor = UIColor(named: "2D2B2E")
            appearance.backgroundColor = UIColor.white
            navigationBar.standardAppearance = appearance;
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            navigationBar.isTranslucent = false
            navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            navigationBar.barTintColor = UIColor(named: "2D2B2E")
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

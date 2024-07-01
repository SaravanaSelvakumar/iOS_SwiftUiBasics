//
//  NextProductPage.swift
//  Samplepro
//
//  Created by Apzzo Technologies Private Limited on 05/04/24.
//

import Foundation
import UIKit
class NextProductPage: UIViewController{
    
   
    
    static let name = "NextProductPage"
    static let storyBoard = "ProductPage"
    class func instantiateFromStoryboard() -> NextProductPage {
        let vc = UIStoryboard(name: NextProductPage.storyBoard, bundle: nil).instantiateViewController(withIdentifier: NextProductPage.name) as! NextProductPage
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

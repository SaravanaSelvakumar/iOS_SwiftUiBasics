//
//  File.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 17/07/24.
//

import Foundation
import UIKit

class Cart: UIViewController{
    
    static let name = "Cart"
    static let storyBoard = "Storyboard"
    
    class func instantiateFromStoryboard() -> Cart{
        let vc = UIStoryboard(name: Cart.storyBoard, bundle: nil).instantiateViewController(withIdentifier: Cart.name) as! Cart
        return vc
    }
    var swipeAnimationHandler: SwipeAnimationHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeAnimationHandler = SwipeAnimationHandler(viewController: self)
        swipeAnimationHandler.setSwipeAction(for: .right) {
            print("Swipe right action triggered!")
            // Perform additional actions here
        }
        
        swipeAnimationHandler.setSwipeAction(for: .left) {
            print("Swipe left action triggered!")
            // Perform additional actions here
        }
        
        swipeAnimationHandler.setSwipeAction(for: .down) {
            print("Swipe down action triggered!")
            // Perform additional actions here
        }
    }
}

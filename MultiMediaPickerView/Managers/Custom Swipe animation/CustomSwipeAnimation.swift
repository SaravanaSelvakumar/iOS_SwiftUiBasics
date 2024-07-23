//
//  CustomSwipeAnimation.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 17/07/24.
//

import Foundation
import UIKit

class SwipeAnimationHandler: NSObject {
    
    weak var viewController: UIViewController?
    var swipeActions: [Int: (() -> Void)] = [:]
    
    let cornerSize: CGFloat = 100.0 // Define the size of the corner regions
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        setupSwipeGestures()
    }
    
    private func setupSwipeGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swipeRight.direction = .right
        viewController?.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swipeLeft.direction = .left
        viewController?.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swipeUp.direction = .up
        viewController?.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swipeDown.direction = .down
        viewController?.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        guard let viewController = viewController else { return }
        
        let location = sender.location(in: viewController.view)
        let viewBounds = viewController.view.bounds
        
        // Define the corner regions
        let topLeftCorner = CGRect(x: 0, y: 0, width: cornerSize, height: cornerSize)
        let topRightCorner = CGRect(x: viewBounds.width - cornerSize, y: 0, width: cornerSize + 20, height: cornerSize + 20)
        let bottomLeftCorner = CGRect(x: 0, y: viewBounds.height - cornerSize, width: cornerSize, height: cornerSize)
        let bottomRightCorner = CGRect(x: viewBounds.width - cornerSize, y: viewBounds.height - cornerSize, width: cornerSize, height: cornerSize)
        
        // Check if the swipe is within one of the corners and the direction is allowed
        if topLeftCorner.contains(location) {
            // Define allowed swipe directions for the top left corner if any
        } else if topRightCorner.contains(location) && sender.direction == .down {
            executeTransition(for: sender.direction)
        } else if bottomLeftCorner.contains(location) && sender.direction == .right {
            executeTransition(for: sender.direction)
        } else if bottomRightCorner.contains(location) && sender.direction == .left {
            executeTransition(for: sender.direction)
        }
    }
    
    private func executeTransition(for direction: UISwipeGestureRecognizer.Direction) {
        guard let viewController = viewController else { return }
        
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        
        switch direction {
        case .right:
            transition.subtype = CATransitionSubtype.fromLeft
            executeSwipeAction(for: direction)
        case .left:
            transition.subtype = CATransitionSubtype.fromRight
            executeSwipeAction(for: direction)
        case .up:
            transition.subtype = CATransitionSubtype.fromTop
            executeSwipeAction(for: direction)
        case .down:
            transition.subtype = CATransitionSubtype.fromBottom
            executeSwipeAction(for: direction)
        default:
            break
        }
        
        viewController.view.window!.layer.add(transition, forKey: kCATransition)
    }
    
    private func executeSwipeAction(for direction: UISwipeGestureRecognizer.Direction) {
        guard let action = swipeActions[Int(direction.rawValue)] else { return }
        action()
    }
    
    // Public method to set swipe actions from the view controller
    func setSwipeAction(for direction: UISwipeGestureRecognizer.Direction, action: @escaping () -> Void) {
        swipeActions[Int(direction.rawValue)] = action
    }
}

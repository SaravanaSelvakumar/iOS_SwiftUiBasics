//
//  Sheet.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 15/07/24.
//

import Foundation
import UIKit

class FittedSheetPresenter {
    
    private var parentViewController: UIViewController?
    private var sheetViewController: UIViewController?
    private var isSheetVisible: Bool = false
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func presentSheet(contentViewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard !isSheetVisible, let parentViewController = parentViewController else {
            return
        }
        
        let sheetViewController = UIViewController()
        sheetViewController.view.backgroundColor = .clear
        sheetViewController.modalPresentationStyle = .overFullScreen
        sheetViewController.modalTransitionStyle = .crossDissolve
        
        parentViewController.present(sheetViewController, animated: animated, completion: {
            sheetViewController.present(contentViewController, animated: animated, completion: completion)
        })
        
        self.sheetViewController = sheetViewController
        isSheetVisible = true
    }
    
    func dismissSheet(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard isSheetVisible, let sheetViewController = sheetViewController else {
            return
        }
        
        sheetViewController.dismiss(animated: animated, completion: {
            self.sheetViewController = nil
            self.isSheetVisible = false
            completion?()
        })
    }
    
    func isSheetPresented() -> Bool {
        return isSheetVisible
    }
    
}

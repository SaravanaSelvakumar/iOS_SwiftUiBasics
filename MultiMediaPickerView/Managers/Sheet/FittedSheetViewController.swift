//
//  File.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 15/07/24.
//

import Foundation
import UIKit

class FittedSheetViewController: UIViewController {
    
    var contentViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure visual properties
        self.view.backgroundColor = .clear
        
        // Configure behavioral properties
        setupTapOutsideToDismiss()
    }
    
    private func setupTapOutsideToDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutside() {
        dismiss(animated: true, completion: nil)
    }
    
    func dismissSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    // Other methods and properties as needed
}

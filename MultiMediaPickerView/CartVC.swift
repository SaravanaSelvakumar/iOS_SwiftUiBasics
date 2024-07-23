//
//  Cart.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 16/07/24.
//

import Foundation
import UIKit

class CartVC: UIViewController{
    
    static let name = "CartVC"
    static let storyBoard = "Cart"
    
    class func instantiateFromStoryboard() -> CartVC{
        let vc = UIStoryboard(name: CartVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: CartVC.name) as! CartVC
        return vc
    }
    
    var progressBar: CircularProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressBarSize: CGFloat = 30.0 // Adjust size as needed
        let frame = CGRect(x: (view.bounds.width - progressBarSize) / 2, y: (view.bounds.height - progressBarSize) / 2, width: progressBarSize, height: progressBarSize)
        
        progressBar = CircularProgressBar(frame: frame, progressColor: .green, backgroundProgressColor: .lightGray, progressBarWidth: 5.0, animationDuration: 1.0)
        
        view.addSubview(progressBar)
    }
    
    @IBAction func actionOnBtn(_ sender: UIButton) {
        let vc = Cart.instantiateFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

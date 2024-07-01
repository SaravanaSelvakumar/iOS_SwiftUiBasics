//
//  ViewController.swift
//  Samplepro
//
//  Created by Apzzo Technologies Private Limited on 05/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chooseProductBtn: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        chooseProductBtn.setCornerRadius(radius: 10, borderColor: UIColor.black, borderWidth: 1 )
        chooseProductBtn.setCornerRadius(radius: 10, borderColor: UIColor.black, borderWidth: 1)
    }
    
    
    @IBAction func actionOnContinueBtn(){
        let vc = NextProductPage.instantiateFromStoryboard()
           let navigationController = UINavigationController(rootViewController: vc)
           navigationController.modalPresentationStyle = .fullScreen
           self.present(navigationController, animated: true, completion: nil)
    }
}

extension UIView {
    
    func setCornerRadius(radius: CGFloat, borderColor: UIColor = #colorLiteral(red: 0.5019607843, green: 0.5843137255, blue: 0.7176470588, alpha: 1), borderWidth: CGFloat = 0.0) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}

class CustomNavigationController: UINavigationController {
}

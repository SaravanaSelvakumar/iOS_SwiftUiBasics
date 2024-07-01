//
//  ViewController.swift
//  ImageAdder
//
//  Created by Apzzo on 17/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    static let name = "ViewController"
    static let storyBoard = "Main"
    class func instantiateFromStoryboard() -> ViewController {
        let vc = UIStoryboard(name: ViewController.storyBoard, bundle: nil).instantiateViewController(withIdentifier: ViewController.name) as! ViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButton() {
        let vc = AddImageVC.instantiateFromStoryboard()
        UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: vc)
    }
}

class CustomNavigationController: UINavigationController {
  // MARK: - Override Method
  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      navigationBar.standardAppearance = appearance;
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    } else {
      view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      navigationBar.isTranslucent = false
    }
  }
}

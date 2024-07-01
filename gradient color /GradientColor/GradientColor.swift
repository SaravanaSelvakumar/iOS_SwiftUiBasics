//
//  GradientColor.swift
//  Tutor
//
//  Created by Apzzo Technologies Private Limited on 30/05/24.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateColor()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateColor()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateColor()
    }
    
    func updateColor() {
         if let colorLayer = self.layer as? CAGradientLayer {
             colorLayer.colors = [firstColor.cgColor, secondColor.cgColor]
             colorLayer.locations = [0.0 , 1.0]
         }
     }
 }

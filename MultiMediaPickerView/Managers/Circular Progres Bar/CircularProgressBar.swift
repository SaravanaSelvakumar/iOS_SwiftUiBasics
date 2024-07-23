//
//  File.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 17/07/24.
//

import Foundation
import UIKit

class CircularProgressBar: UIView {
    
    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var isAnimating = false
    
    var progressColor: UIColor = .green {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var backgroundProgressColor: UIColor = .lightGray {
        didSet {
            backgroundLayer.strokeColor = backgroundProgressColor.cgColor
        }
    }
    
    var progressBarWidth: CGFloat = 10.0 {
        didSet {
            progressLayer.lineWidth = progressBarWidth
            backgroundLayer.lineWidth = progressBarWidth
            updatePaths()
        }
    }
    
    var animationDuration: TimeInterval = 2.0
    
    convenience init(frame: CGRect, progressColor: UIColor = .green, backgroundProgressColor: UIColor = .lightGray, progressBarWidth: CGFloat = 10.0, animationDuration: TimeInterval = 2.0) {
        self.init(frame: frame)
        
        self.progressColor = progressColor
        self.backgroundProgressColor = backgroundProgressColor
        self.progressBarWidth = progressBarWidth
        self.animationDuration = animationDuration
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.0
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius - progressBarWidth / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // Background Layer
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = backgroundProgressColor.cgColor
        backgroundLayer.lineWidth = progressBarWidth
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeEnd = 1.0
        
        layer.addSublayer(backgroundLayer)
        
        // Progress Layer
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = progressBarWidth
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0.0
        
        layer.addSublayer(progressLayer)
        
        isHidden = true
    }
    
    private func updatePaths() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.0
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius - progressBarWidth / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = progressBarWidth
        
        progressLayer.path = circularPath.cgPath
        progressLayer.lineWidth = progressBarWidth
    }
    
    func show(animated: Bool = true) {
        isHidden = false
        if animated {
            startAnimating()
        }
    }
    
    func hide() {
        isHidden = true
        stopAnimating()
    }
    
    private func startAnimating() {
        guard !isAnimating else { return }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = animationDuration
        animation.repeatCount = .infinity
        progressLayer.add(animation, forKey: "progressAnimation")
        
        isAnimating = true
    }
    
    private func stopAnimating() {
        progressLayer.removeAnimation(forKey: "progressAnimation")
        isAnimating = false
    }
}

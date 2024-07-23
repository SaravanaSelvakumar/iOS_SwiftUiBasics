//
//  SwipeGestureHandler.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 22/07/24.
//

import UIKit

class SwipeGestureHandler {
    private var leadingConstraint: NSLayoutConstraint
    private var trailingConstraint: NSLayoutConstraint
    private var contentView: UIView
    private var leftSwipeLeading: CGFloat
    private var leftSwipeTrailing: CGFloat
    private var rightSwipeLeading: CGFloat
    private var rightSwipeTrailing: CGFloat

    init(contentView: UIView, leadingConstraint: NSLayoutConstraint, trailingConstraint: NSLayoutConstraint, leftSwipeLeading: CGFloat, leftSwipeTrailing: CGFloat, rightSwipeLeading: CGFloat, rightSwipeTrailing: CGFloat) {
        self.contentView = contentView
        self.leadingConstraint = leadingConstraint
        self.trailingConstraint = trailingConstraint
        self.leftSwipeLeading = leftSwipeLeading
        self.leftSwipeTrailing = leftSwipeTrailing
        self.rightSwipeLeading = rightSwipeLeading
        self.rightSwipeTrailing = rightSwipeTrailing
        setupSwipeGestures()
    }

    private func setupSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        contentView.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipe.direction = .right
        contentView.addGestureRecognizer(rightSwipe)
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            updateConstraints(leading: leftSwipeLeading, trailing: leftSwipeTrailing)
        case .right:
            updateConstraints(leading: rightSwipeLeading, trailing: rightSwipeTrailing)
        default:
            break
        }
    }

    private func updateConstraints(leading: CGFloat, trailing: CGFloat) {
        leadingConstraint.constant = leading
        trailingConstraint.constant = trailing
        animateConstraintChanges()
    }

    private func animateConstraintChanges() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layoutIfNeeded()
        }
    }

    func resetSwipe() {
        updateConstraints(leading: rightSwipeLeading, trailing: rightSwipeTrailing)
    }
}

//
//  UIView+Helpers.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 31/10/2023.
//

import UIKit

// MARK: UIView+Helpers

extension UIView {
    // MARK: - Shadow

    /// Applies a default card-style shadow to a view with a specified corner radius.
    /// - Parameter cornerRadius: The corner radius to apply to the view.
    ///
    func applyDefaultCardShadow(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.masksToBounds = false
    }
    // MARK: - Corner Radius

    /// A property to get or set the corner radius of the UIView.
    ///
    /// This property allows you to easily set the corner radius of a UIView
    /// using Interface Builder or programmatically. When the corner radius
    /// is greater than 0, the `masksToBounds` property of the layer is set
    /// to true, clipping the content and subviews to the rounded corners.
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

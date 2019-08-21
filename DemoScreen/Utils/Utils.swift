//
//  UIView+Extensions.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: UIView...) {
        addSubviews(subviews)
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
        }
    }

}

extension UIView {

    func shakeAnimation() {
        layer.removeAllAnimations()

        let shakeAnimation  = CAKeyframeAnimation(keyPath:"transform")
        shakeAnimation.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.03, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.03 , 0, 0, 1))]
        shakeAnimation.autoreverses = true
        shakeAnimation.duration  = 0.2
        shakeAnimation.repeatCount = .infinity

        layer.add(shakeAnimation, forKey: "transform")
    }

}

extension UIFont {

    static
        func regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.systemFont(ofSize: size)
    }

}

extension String {

    var image: UIImage? {
        return UIImage(named: self)
    }

}

extension NSObjectProtocol {

    func with(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

}

extension UIColor {

    convenience
    init(hex: UInt32, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat((hex & 0x0000FF) >> 0) / 0xFF
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}

extension UIViewController {

    func showAlert(title: String) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true, completion: nil)
    }


    func dismissPresentedVC() {
        if presentedViewController != nil {
            dismiss(animated: true)
        }
    }

}

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
        shakeAnimation.values =
            [
                NSValue(caTransform3D: CATransform3DMakeRotation(0.03, 0, 0, 1)),
                NSValue(caTransform3D: CATransform3DMakeRotation(-0.03, 0, 0, 1)),
            ]
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
    init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
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

//
//  UIExtensions.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit


public
extension UIViewController {

    func attachViewController(_ childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.frame = view.bounds
        childViewController.view.preservesSuperviewLayoutMargins = false
    }

    func detachViewController(_ childViewController: UIViewController) {

    }

}

public
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


public
extension UIColor {

    convenience
    init(hex: UInt32, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat((hex & 0x0000FF) >> 0) / 0xFF
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}

public
extension UIFont {

    static
        func regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.systemFont(ofSize: size)
    }

}

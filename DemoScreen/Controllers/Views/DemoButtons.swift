//
//  UIButton+Extensions.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

extension UIButton {
    
    static
    func roundButton(title: String, tintColor: UIColor) -> UIButton {
        return UIButton().with {
            let attributes = TextAttributes(alignment: .center, font: .regular(15), foregroundColor: .black, kern: 0.54)
            $0.setAttributedTitle(title.uppercased().attributed(attributes), for: .normal)
            $0.setBackgroundImage("round_button".image?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = tintColor
        }
    }

    static
    func restoreButton() -> UIButton {
        return UIButton().with {
            let attributes = TextAttributes(alignment: .center, font: .regular(11))
            let disabledAttributes = TextAttributes(alignment: .center, font: .regular(11), foregroundColor: UIColor.white.withAlphaComponent(0.5))
            let restoreTitle = "Restore".uppercased()
            $0.setAttributedTitle(restoreTitle.attributed(attributes), for: .normal)
            $0.setAttributedTitle(restoreTitle.attributed(disabledAttributes), for: .highlighted)
        }
    }


}

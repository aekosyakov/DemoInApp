//
//  UIButton+Extensions.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

extension UIButton {

    static
    func watchVideoButton() -> UIButton {
        return UIButton().with {
            let attributes = TextAttributes(alignment: .center, font: .regular(15), foregroundColor: .black, kern: 0.54)
            $0.setAttributedTitle("Watch Video".uppercased().attributed(attributes), for: .normal)
            $0.setBackgroundImage("yellow_button".image, for: .normal)
        }
    }

    static
    func buyPremiumButton() -> UIButton {
        return UIButton().with {
            let attributes = TextAttributes(alignment: .center, font: .regular(15), kern: 0.54)
            $0.setAttributedTitle("Premium Free".uppercased().attributed(attributes), for: .normal)
            $0.setAttributedTitle("Premium Purchased".uppercased().attributed(attributes), for: .disabled)
            $0.setBackgroundImage("red_button".image, for: .normal)
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
            $0.setAttributedTitle("Restored".attributed(disabledAttributes), for: .disabled)
        }
    }


}

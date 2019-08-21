//
//  TermsOfUseLabel.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

extension UILabel {

    static
    func wallpapersLabel() -> UILabel {
        return UILabel().with {
            $0.attributedText = titleAttributedString
            $0.numberOfLines = 2
        }
    }

    static
    func termsOfUseLabel() -> UILabel {
        return UILabel().with {
            $0.attributedText = termsOfUseAttributedString
            $0.alpha = 0.5
            $0.numberOfLines = 0
        }

    }


}

private
let titleAttributedString: NSAttributedString = {
    let titleAttributes = TextAttributes(font: .regular(25), lineHeight: 30).dictionary
    let subtitleAttribute = TextAttributes(font: .regular(20), lineHeight: 30).dictionary
    let mutableAttributedString = NSMutableAttributedString(string: "Wallpapers \n".uppercased(), attributes: titleAttributes)
    let subtitleMutableAttributedString = NSAttributedString(string: "for save premium content", attributes: subtitleAttribute)
    mutableAttributedString.append(subtitleMutableAttributedString)
    return NSAttributedString(attributedString: mutableAttributedString)
}()


private
let termsOfUse =
"""
Automatic renewal can be disabled 24 hours before the end of the current period. A subscription fee is charged to iTunes along with a subscription confirmation. Automatic renewal can be disabled after purchase in your account settings. \n\n
"""

private
let termsOfUseAttributedString: NSAttributedString = {
    let termsOfUseAttributes = TextAttributes(alignment: .justified, font: .regular(10), kern: 0.36, lineHeight: 12).dictionary
    let additionalAttributes = TextAttributes(alignment: .center, font: .regular(10), kern: 0.36, lineHeight: 12).dictionary
    let mutableAttributedString = NSMutableAttributedString(string: termsOfUse, attributes: termsOfUseAttributes)
    mutableAttributedString.append(NSAttributedString(string: "Terms of Use | Security policy", attributes: additionalAttributes))
    return NSAttributedString(attributedString: mutableAttributedString)
}()

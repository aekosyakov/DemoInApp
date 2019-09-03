//
//  WAL02UIConfig.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import Foundation
import UIKit

class WAL02UIConfig {
    
    let title: String
    
    let subtitle: String
    
    let video_button_title: String
    
    let premium_button_title: String
    
    let restore_button_title: String

    
    let title_color: UIColor
    
    let subtitle_color: UIColor
    
    let video_button_color: UIColor
    
    let premium_button_color: UIColor
    
    let restore_button_text_color: UIColor
    
    let term_of_use_text_color: UIColor
    
    private(set)
    var titleImage: UIImage?

    private(set)
    var backgroundImage: UIImage?
    
    var isPremiumPurchased = false
    
    init?(jsonDict: [String: Any]?) {
        guard
            let json = jsonDict,
            let title = json["title"] as? String,
            let subtitle = json["subtitle"] as? String,
            let video_button_title = json["video_button_title"] as? String,
            let premium_button_title = json["premium_button_title"] as? String,
            let restore_button_title = json["restore_button_title"] as? String,
            let title_color_hex = json["title_color"] as? String,
            let subtitle_color_hex = json["subtitle_color"] as? String,
            let video_button_color_hex = json["video_button_color"] as? String,
            let premium_button_color_hex = json["premium_button_color"] as? String,
            let restore_button_text_color_hex = json["restore_button_text_color"] as? String,
            let term_of_use_text_color_hex = json["term_of_use_text_color"] as? String,
            let backgroundImageName = json["background_image"] as? String
        else {
            return nil
        }
        self.title = title
        self.subtitle = subtitle
        self.video_button_title = video_button_title
        self.premium_button_title = premium_button_title
        self.restore_button_title = restore_button_title

        title_color = UIColor(hexString: title_color_hex)
        subtitle_color = UIColor(hexString: subtitle_color_hex)
        video_button_color = UIColor(hexString: video_button_color_hex)
        premium_button_color = UIColor(hexString: premium_button_color_hex)
        restore_button_text_color = UIColor(hexString: restore_button_text_color_hex)
        term_of_use_text_color = UIColor(hexString: term_of_use_text_color_hex)
        titleImage = (json["title_image"] as? String)?.image
        backgroundImage = backgroundImageName.image
    }
    
}

extension WAL02UIConfig {
    
    var attributedTitle: NSAttributedString {
        let titleAttributes = TextAttributes(font: .regular(25), lineHeight: 30).dictionary
        let subtitleAttribute = TextAttributes(font: .regular(20), lineHeight: 30).dictionary
        let mutableAttributedString = NSMutableAttributedString(string: title.uppercased().appending("\n"), attributes: titleAttributes)
        let subtitleMutableAttributedString = NSAttributedString(string: subtitle, attributes: subtitleAttribute)
        mutableAttributedString.append(subtitleMutableAttributedString)
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    var attributedTermsOfUse: NSAttributedString {
        let termsOfUseAttributes = TextAttributes(alignment: .justified, font: .regular(10), foregroundColor: term_of_use_text_color, kern: 0.36, lineHeight: 12).dictionary
        let additionalAttributes = TextAttributes(alignment: .center, font: .regular(10), foregroundColor: term_of_use_text_color, kern: 0.36, lineHeight: 12).dictionary
        let mutableAttributedString = NSMutableAttributedString(string: termsOfUse, attributes: termsOfUseAttributes)
        mutableAttributedString.append(NSAttributedString(string: "Terms of Use | Security policy", attributes: additionalAttributes))
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
}

private
let termsOfUse =
"""
Automatic renewal can be disabled 24 hours before the end of the current period. A subscription fee is charged to iTunes along with a subscription confirmation. Automatic renewal can be disabled after purchase in your account settings. \n\n
"""

//JSON Example
/*
 {
 "title": "premium",
 "subtitle": "for save premium content",
 "video_button_title": "watch video",
 "premium_button_title": "premium free",
 "restore_button_title": "restore",
 "title_color": "000000",
 "subtitle_color": "000000",
 "video_button_color": "FFDB57",
 "premium_button_color": "F7434C",
 "restore_button_text_color": "A5ABB2",
 "term_of_use_text_color": "4F4D4D",
 "background_image": "background_image_10.pdf"
 }
 */

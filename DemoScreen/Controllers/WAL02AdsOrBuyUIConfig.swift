//
//  WAL02AdsOrBuyUIConfig.swift
//

import UIKit

class WAL02AdsOrBuyUIConfig {

    let title: String

    let subtitle: String

    let videoButtonTitle: String

    let premiumButtonTitle: String

    let restoreButtonTitle: String


    let titleColor: UIColor

    let subtitleColor: UIColor

    let videoButtonTextColor: UIColor

    let premiumButtonTextColor: UIColor

    let restoreButtonTextColor: UIColor

    let termsOfUseTextColor: UIColor


    private(set)
    var titleImage: UIImage?
    
    private(set)
    var videoButtonImage: UIImage?
    
    private(set)
    var premiumButtonImage: UIImage?

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
            let video_title_color_hex = json["video_button_title_color"] as? String,
            let premium_title_color_hex = json["premium_button_title_color"] as? String,
            let video_button_image_name = json["video_button_image"] as? String,
            let premium_button_image_name = json["premium_button_image"] as? String,
            let restore_button_text_color_hex = json["restore_button_text_color"] as? String,
            let term_of_use_text_color_hex = json["term_of_use_text_color"] as? String,
            let backgroundImageName = json["background_image"] as? String
        else {
            return nil
        }
        self.title = title
        self.subtitle = subtitle
        self.videoButtonTitle = video_button_title
        self.premiumButtonTitle = premium_button_title
        self.restoreButtonTitle = restore_button_title

        titleColor = UIColor(hexString: title_color_hex)
        subtitleColor = UIColor(hexString: subtitle_color_hex)
        videoButtonTextColor = UIColor(hexString: video_title_color_hex)
        premiumButtonTextColor = UIColor(hexString: premium_title_color_hex)
        videoButtonImage = video_button_image_name.image
        premiumButtonImage = premium_button_image_name.image
        restoreButtonTextColor = UIColor(hexString: restore_button_text_color_hex)
        termsOfUseTextColor = UIColor(hexString: term_of_use_text_color_hex, alpha: 0.5)
        titleImage = (json["title_image"] as? String)?.image
        backgroundImage = backgroundImageName.image
    }

    func font(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}

extension WAL02AdsOrBuyUIConfig {

    var attributedTitle: NSAttributedString {
        let titleAttributes = TextAttributes(font: font(25), foregroundColor: titleColor, lineHeight: 30).dictionary
        let subtitleAttribute = TextAttributes(font: font(20), foregroundColor: subtitleColor, lineHeight: 30).dictionary
        let mutableAttributedString = NSMutableAttributedString(string: title.uppercased().appending("\n"), attributes: titleAttributes)
        let subtitleMutableAttributedString = NSAttributedString(string: subtitle, attributes: subtitleAttribute)
        mutableAttributedString.append(subtitleMutableAttributedString)
        return NSAttributedString(attributedString: mutableAttributedString)
    }

    var attributedTermsOfUse: NSAttributedString {
        let termsOfUseAttributes = TextAttributes(alignment: .justified, font: font(10), foregroundColor: termsOfUseTextColor, kern: 0.36, lineHeight: 12).dictionary
        let additionalAttributes = TextAttributes(alignment: .center, font: font(10), foregroundColor: termsOfUseTextColor, kern: 0.36, lineHeight: 12).dictionary
        let mutableAttributedString = NSMutableAttributedString(string: termsOfUse, attributes: termsOfUseAttributes)
        mutableAttributedString.append(NSAttributedString(string: termsOfUseTitle, attributes: additionalAttributes))
        return NSAttributedString(attributedString: mutableAttributedString)
    }

    var attributedPurchaseText: NSAttributedString {
        let attributes = TextAttributes(alignment: .center, font: font(10), foregroundColor: termsOfUseTextColor)
        return purchaseTitle.attributed(attributes)
    }

    var attributedRestore: NSAttributedString {
        let attributes = TextAttributes(alignment: .center, font: font(11), foregroundColor: restoreButtonTextColor)
        return restoreButtonTitle.uppercased().attributed(attributes)
    }

}

private
let termsOfUse = 
"""
Automatic renewal can be disabled 24 hours before the end of the current period. A subscription fee is charged to iTunes along with a subscription confirmation. Automatic renewal can be disabled after purchase in your account settings. \n\n
"""

private
let termsOfUseTitle = "Terms of Use | Security policy"

private
let purchaseTitle = "3 days free, after 3$ / month"


//JSON Example
/*
 {
 "title": "premium",
 "subtitle": "for save premium content",
 "video_button_title": "watch video",
 "premium_button_title": "premium free",
 "restore_button_title": "restore",
 "title_color": "FFFFFF",
 "subtitle_color": "FFFFFF",
 "video_button_title_color": "000000",
 "premium_button_title_color": "FFFFFF",
 "video_button_image": "button_01",
 "premium_button_image": "button_02",
 "restore_button_text_color": "FFFFFF",
 "term_of_use_text_color": "FFFFFF",
 "title_image": "gift",
 "background_image": "background_image_01"
 }
 */

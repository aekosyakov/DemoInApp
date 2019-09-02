//
//  WAL02UIConfig.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import Foundation
import UIKit

class WAL02UIConfig {
    
    let firstButtonTitle: String
    
    let secondButtonTitle: String
    
    let firstButtonColor: UIColor
    
    let secondButtonColor: UIColor
    
    private(set)
    var backgroundImage: UIImage?
    
    var isPremiumPurchased = false
    
    init?(jsonDict: [String: Any]?) {
        guard
            let json = jsonDict,
            let firstHexColor = json["first_button_color"] as? String,
            let secondHexColor = json["second_button_color"] as? String,
            let firstTitle = json["first_button_title"] as? String,
            let secondTitle = json["second_button_title"] as? String,
            let backgroundImageName = json["background_image"] as? String
        else {
            return nil
        }
        firstButtonTitle = firstTitle
        secondButtonTitle = secondTitle
        firstButtonColor = UIColor(hexString: firstHexColor)
        secondButtonColor = UIColor(hexString: secondHexColor)
        backgroundImage = backgroundImageName.image
    }
    
}

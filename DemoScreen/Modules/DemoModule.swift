//
//  DemoModule.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import Reachability
import Firebase

final
class DemoModule {
    
    var handleAction:((DemoAction?) -> Void)?

    fileprivate lazy
    var iapService = IAPService().with {
        $0.loadAvailableSKProducts()
        $0.completion = { [weak self] status in self?.transactionCompletion(status) }
    }

    private
    let reachability = Reachability()
    
    var viewController: UIViewController?

    init() {
        try? reachability?.startNotifier()
        
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
        let fetchDuration: TimeInterval = 0
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { status, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            RemoteConfig.remoteConfig().activate(completionHandler: nil)
        }
    }

    private
    func transactionCompletion(_ status: PurchaseStatus) {
        switch status {
        case .success:
            showConfetti()
        case .failed(let error):
            displayErrorIfNeeded(error)
        }
    }
    
    public
    func showPurchaseScreen(fromViewController: UIViewController) {
        let uiConfig = UIConfig()
        let remoteConfig = RemoteConfig.remoteConfig()
        if let firstButtonColorHex = remoteConfig.configValue(forKey: "first_button_color").stringValue {
            uiConfig.firstButtonColor = UIColor(hexString: firstButtonColorHex)
        }
        
        if let secondButtonColorHex = remoteConfig.configValue(forKey: "second_button_color").stringValue {
            uiConfig.firstButtonColor = UIColor(hexString: secondButtonColorHex)
        }

        uiConfig.firstButtonTitle = remoteConfig.configValue(forKey: "first_button_title").stringValue ?? appDefaults["first_button_title"] as! String
        uiConfig.secondButtonTitle = remoteConfig.configValue(forKey: "second_button_title").stringValue ?? appDefaults["second_button_title"] as! String
        uiConfig.backgroundImage = remoteConfig.configValue(forKey: "background_image").stringValue?.image
        uiConfig.isPremiumPurchased = iapService.isPremiumPurchased
    
        let demoViewController = DemoViewController(uiConfig: uiConfig)
        demoViewController.action = handleAction
        fromViewController.present(demoViewController, animated: true, completion: nil)
        viewController = demoViewController
    }

}

private
extension DemoModule {

    func displayErrorIfNeeded(_ error: Error?) {
        guard let error = error else {
            return
        }
        viewController?.showAlert(title: error.localizedDescription)
    }

    func showConfetti() {
        viewController?.view.displayEmitterCells()
    }

}


private
let appDefaults: [String: Any?] = [
    "first_button_title" : "WATCH VIDEO",
    "second_button_title" : "FREE PREMIUM",
    "first_button_color" : "FFDB57",
    "second_button_color" : "F7434C",
    "background_image" : "black.pdf"
]

private
let cantMakePaymentsAlertTitle = "Sorry, this device is not able or allowed to make payments"

private
let internetConnectionAlertTitle = "Please check your Internet connection"


private
extension Reachability.Connection {

    var isValid: Bool {
        switch self {
        case .cellular, .wifi:
            return true
        default:
            return false
        }
    }

}

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
    
    private lazy
    var tableViewController = TableViewController().with {
        $0.didPress = { [weak self] variant in self?.showPurchaseScreen(variant: variant) }
    }
    
    var viewController: UIViewController {
        return tableViewController
    }

    init() {
        try? reachability?.startNotifier()
        FirebaseApp.configure()
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { status, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            remoteConfig.activate(completionHandler: nil)
            let keys = remoteConfig.keys(withPrefix: "variant")
            self.tableViewController.variants = Array(keys)
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
    func showPurchaseScreen(variant: String) {
        let jsonDict = RemoteConfig.remoteConfig().configValue(forKey: variant).jsonValue as? [String: Any]
        guard let uiConfig = UIConfig(jsonDict: jsonDict) else {
            return
        }
        uiConfig.isPremiumPurchased = self.iapService.isPremiumPurchased
        
        let demoViewController = DemoViewController(uiConfig: uiConfig)
        demoViewController.action = self.handleAction
        self.viewController.present(demoViewController, animated: true, completion: nil)
    }

}

private
extension DemoModule {

    func displayErrorIfNeeded(_ error: Error?) {
        guard let error = error else {
            return
        }
        viewController.showAlert(title: error.localizedDescription)
    }

    func showConfetti() {
        viewController.view.displayEmitterCells()
    }

}

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

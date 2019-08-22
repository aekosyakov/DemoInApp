//
//  DemoModule.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import Reachability

public
protocol Module {

    var viewController: UIViewController { get }

}

final
class DemoModule: Module {

    fileprivate lazy
    var iapService = IAPService().with {
        $0.loadAvailableSKProducts()
        $0.completion = { [weak self] status in self?.transactionCompletion(status) }
    }

    private lazy
    var demoViewController = DemoViewController(iapService: iapService).with {
        $0.action = { [weak self] action in self?.handleAction(action) }
    }

    private
    let reachability = Reachability()

    init() {
        try? reachability?.startNotifier()
    }

    // MARK: Module

    var viewController: UIViewController {
        return demoViewController
    }

    private
    func handleAction(_ action: DemoAction?) {
        guard reachability?.connection.isValid ?? false else {
            viewController.showAlert(title: internetConnectionAlertTitle)
            return
        }
        switch action {
        case .watchVideo?:
            viewController.present(RewardedVideoController(), animated: true, completion: nil)
        case .buyPremium?:
            guard iapService.canMakeInAppPurchases else {
                viewController.showAlert(title: cantMakePaymentsAlertTitle)
                return
            }
            iapService.purchasePremium()
        case .restore?:
            guard iapService.canMakeInAppPurchases else {
                viewController.showAlert(title: cantMakePaymentsAlertTitle)
                return
            }
            iapService.restoreCompletedTransactions()
        default:
            break
        }
    }

    private
    func transactionCompletion(_ status: PurchaseStatus) {
        (viewController as? DemoViewController)?.updateUI()
        switch status {
        case .failed(let error):
            displayErrorIfNeeded(error)
        case .success:
            showConfetti()
        }
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

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

    private
    let reachability = Reachability()

    private lazy
    var demoViewController = DemoViewController(
        attributedTitle: titleAttributedString,
        backgroundImage: "gradient_background".image,
        iapService: iapService
    ).with {
        $0.action = { [weak self] action in self?.handleAction(action) }
    }

    // MARK: Module

    var viewController: UIViewController {
        return demoViewController
    }

    private
    func handleAction(_ action: DemoAction?) {
        guard reachability?.connection != nil else {
            viewController.showAlert(title: internetConnectionAlertTitle)
            return
        }
        guard iapService.canMakeInAppPurchases, DemoAction.watchVideo != action else {
            viewController.showAlert(title: cantMakePaymentsAlertTitle)
            return
        }
        switch action {
        case .watchVideo?:
            let videoController = RewardedVideoController().with {
                $0.dismissAction = { [weak self] in self?.viewController.dismiss(animated: true) }
            }
            viewController.present(videoController, animated: true, completion: nil)
        case .buyPremium?:
            showLoader()
            iapService.purchasePremium()
        case .restore?:
            showLoader()
            iapService.restoreCompletedTransactions()
        default:
            break
        }
    }

    private
    func transactionCompletion(_ status: PurchaseStatus) {
        dismissLoader()
        (viewController as? DemoViewController)?.updateUI()
        switch status {
        case .failed(let error):
            displayErrorIfNeeded(error)
        case .success:
            showConfetti()
        }
    }

}

extension DemoModule {

    func showLoader() {
        let loadingController = LoadingViewController()
        loadingController.modalPresentationStyle = .overCurrentContext
        loadingController.modalTransitionStyle = .crossDissolve
        viewController.present(loadingController, animated: true, completion: nil)
    }

    func dismissLoader() {
        viewController.dismissPresentedVC()
    }

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
let titleAttributedString: NSAttributedString = {
    let titleAttributes = TextAttributes(font: .regular(25), lineHeight: 30).dictionary
    let subtitleAttribute = TextAttributes(font: .regular(20), lineHeight: 30).dictionary
    let mutableAttributedString = NSMutableAttributedString(string: "Wallpapers \n".uppercased(), attributes: titleAttributes)
    let subtitleMutableAttributedString = NSAttributedString(string: "for save premium content", attributes: subtitleAttribute)
    mutableAttributedString.append(subtitleMutableAttributedString)
    return NSAttributedString(attributedString: mutableAttributedString)
}()

private
let cantMakePaymentsAlertTitle = "Sorry, this device is not able or allowed to make payments"

private
let internetConnectionAlertTitle = "Please check your Internet connection"



//
//  WAL02AdsOrBuy.swift
//

import UIKit
import Firebase

final
class WAL02AdsOrBuy {
    
    public
    var handleAction:((Int) -> Void)?

    init() {
        RemoteConfig.remoteConfig().activate(completionHandler: nil)
    }

    public
    func showScreen(for variant: String, fromViewController: UIViewController) {
        let jsonDict = RemoteConfig.remoteConfig().configValue(forKey: variant).jsonValue as? [String: Any]
        guard let uiConfig = WAL02AdsOrBuyUIConfig(jsonDict: jsonDict) else {
            return
        }

        let demoViewController = WAL02AdsOrBuyVC(uiConfig: uiConfig)
        demoViewController.action = handleAction
        fromViewController.present(demoViewController, animated: true, completion: nil)
    }

}

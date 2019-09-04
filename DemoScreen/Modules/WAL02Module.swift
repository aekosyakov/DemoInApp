//
//  WAL02Module.swift
//

import UIKit
import Firebase

final
class WAL02Module {
    
    public
    var handleAction:((Int) -> Void)?

    init() {
        FirebaseApp.configure()
    }

    public
    func showScreen(for variant: String, fromViewController: UIViewController) {
        let jsonDict = RemoteConfig.remoteConfig().configValue(forKey: variant).jsonValue as? [String: Any]
        guard let uiConfig = WAL02UIConfig(jsonDict: jsonDict) else {
            return
        }

        let demoViewController = WAL02ViewController(uiConfig: uiConfig)
        demoViewController.action = handleAction
        fromViewController.present(demoViewController, animated: true, completion: nil)
    }

}

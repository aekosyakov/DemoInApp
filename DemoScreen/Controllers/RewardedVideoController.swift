//
//  RewardedVideoController.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import Foundation
import Appodeal

final
class RewardedVideoController: UIViewController, AppodealRewardedVideoDelegate {

    override
    func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        Appodeal.setRewardedVideoDelegate(self)
        Appodeal.setSmartBannersEnabled(true)
    }

    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Appodeal.showAd(.rewardedVideo, rootViewController: self)
    }

    // MARK: AppodealRewardedVideoDelegate

    func rewardedVideoDidFinish(_ rewardAmount: UInt, name: String?) {
        dismiss(animated: true)
    }

}

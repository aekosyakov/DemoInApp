//
//  LoadingViewController.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

final
class LoadingViewController: UIViewController {

    private
    let activityIndicator = UIActivityIndicatorView(style: .white)

    override
    func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    override
    func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.center = view.center
    }

}

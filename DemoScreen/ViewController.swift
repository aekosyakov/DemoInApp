//
//  ViewController.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let demoModule = DemoModule()
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        demoModule.showPurchaseScreen(fromViewController: self)
    }
    
}

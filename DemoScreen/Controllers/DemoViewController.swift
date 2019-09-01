//
//  DemoViewController.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit

enum DemoAction: Int {
    case watchVideo, buyPremium, restore
}

final
class DemoViewController: UIViewController {

    // MARK: Properties

    public
    var action: ((DemoAction?) -> Void)?

    private
    let uiConfig: UIConfig

    // MARK: Subviews

    private lazy
    var backgroundImageView = UIImageView(image: uiConfig.backgroundImage)

    private
    let giftImageView = UIImageView(image: "icon_gift".image)

    private lazy
    var titleLabel = UILabel.wallpapersLabel()

    private lazy
    var watchVideoButton = UIButton.roundButton(title: uiConfig.firstButtonTitle, tintColor: uiConfig.firstButtonColor).with {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.watchVideo.rawValue
    }

    private lazy
    var buyPremiumButton = UIButton.roundButton(title: uiConfig.secondButtonTitle, tintColor: uiConfig.secondButtonColor).with {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.buyPremium.rawValue
    }


    private
    let closeButton = UIButton().with {
        $0.addTarget(self, action: #selector(close), for: .touchUpInside)
        $0.setImage("icon_close".image, for: .normal)
    }

    private
    let restoreButton = UIButton.restoreButton().with {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.restore.rawValue
    }

    private
    let purchaseLabel = UILabel().with {
        let attributes = TextAttributes(alignment: .center, font: .regular(10))
        $0.attributedText = "3 days free, after 3$ / month".attributed(attributes)
    }

    private
    let termsOfUseLabel = UILabel.termsOfUseLabel()

    private lazy
    var buttonsStackView = UIStackView(arrangedSubviews: [watchVideoButton, buyPremiumButton]).with {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 20
    }

    private lazy
    var labelsStackView = UIStackView(arrangedSubviews: [purchaseLabel, termsOfUseLabel]).with {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 15
    }

    // MARK: Initialize

    init(uiConfig: UIConfig) {
        self.uiConfig = uiConfig
        super.init(nibName: nil, bundle: nil)
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override
    func viewDidLoad() {
        super.viewDidLoad()
        [
            backgroundImageView,
            restoreButton,
            closeButton,
            giftImageView,
            titleLabel,
            buttonsStackView,
            labelsStackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view?.addSubview($0)
        }
        setupLayout()
    }

    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }

    private
    func setupLayout() {
        NSLayoutConstraint.activate(
            [
                // Background Image
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                // Restore Button
                restoreButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                restoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                restoreButton.widthAnchor.constraint(equalToConstant: 49.0),
                restoreButton.heightAnchor.constraint(equalToConstant: 13.0),

                // Close Button
                closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15.0),
                closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
                closeButton.widthAnchor.constraint(equalToConstant: 24.0),
                closeButton.heightAnchor.constraint(equalToConstant: 24.0),

                // Gift Image
                giftImageView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 164),
                giftImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                giftImageView.widthAnchor.constraint(equalToConstant: 192.0),
                giftImageView.heightAnchor.constraint(equalToConstant: 180.0),

                // Title
                titleLabel.topAnchor.constraint(equalTo: giftImageView.bottomAnchor, constant: 29),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: 240.0),
                titleLabel.heightAnchor.constraint(equalToConstant: 60.0),
                titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: buttonsStackView.topAnchor, constant: -20),

                // Buttons Stack
                buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonsStackView.widthAnchor.constraint(equalToConstant: 248.0),
                buttonsStackView.heightAnchor.constraint(equalToConstant: 120.0),
                buttonsStackView.bottomAnchor.constraint(equalTo: labelsStackView.topAnchor, constant: -15),

                // Labels Stack
                labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelsStackView.widthAnchor.constraint(equalToConstant: 313.0),
                labelsStackView.heightAnchor.constraint(equalToConstant: 99.0),
                labelsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ]
        )
    }

    @objc private
    func buttonPressed(_ sender: UIButton) {
        action?(DemoAction.init(rawValue: sender.tag))
    }

    func updateUI() {
        buyPremiumButton.isEnabled = !uiConfig.isPremiumPurchased
        restoreButton.isEnabled = !uiConfig.isPremiumPurchased

        giftImageView.shakeAnimation()
    }
    
    @objc private
    func close() {
        dismiss(animated: true)
    }

}



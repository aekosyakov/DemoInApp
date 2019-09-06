//
//  WAL02AdsOrBuyVC.swift
//

import UIKit

enum DemoAction: Int {
    case watchVideo, buyPremium, restore, termsOfUse
}

final
class WAL02AdsOrBuyVC: UIViewController {

    // MARK: Properties

    public
    var action: ((Int) -> Void)?

    private
    let uiConfig: WAL02AdsOrBuyUIConfig

    // MARK: Subviews

    private lazy
    var backgroundImageView = UIImageView(image: uiConfig.backgroundImage)

    private lazy
    var giftImageView = UIImageView(image: uiConfig.titleImage)

    private lazy
    var titleLabel = UILabel().with {
        $0.attributedText = uiConfig.attributedTitle
        $0.numberOfLines = 2
    }

    private lazy
    var videoButton = UIButton().with {
        let attributes = TextAttributes(alignment: .center, font: uiConfig.font(15), foregroundColor: uiConfig.videoButtonTextColor, kern: 0.54)
        $0.setAttributedTitle(uiConfig.videoButtonTitle.uppercased().attributed(attributes), for: .normal)
        $0.setBackgroundImage(uiConfig.videoButtonImage, for: .normal)
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.watchVideo.rawValue
    }
    
    private lazy
    var premiumButton = UIButton().with {
        let attributes = TextAttributes(alignment: .center, font: uiConfig.font(15), foregroundColor: uiConfig.premiumButtonTextColor, kern: 0.54)
        $0.setAttributedTitle(uiConfig.premiumButtonTitle.uppercased().attributed(attributes), for: .normal)
        $0.setBackgroundImage(uiConfig.premiumButtonImage, for: .normal)
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.buyPremium.rawValue
    }

    private
    let closeButton = UIButton().with {
        $0.addTarget(self, action: #selector(close), for: .touchUpInside)
        $0.setImage("close".image, for: .normal)
    }

    private lazy
    var restoreButton = UIButton().with {
        $0.setTitleColor(uiConfig.restoreButtonTextColor, for: .normal)
        $0.setAttributedTitle(uiConfig.attributedRestore, for: .normal)
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.restore.rawValue
    }

    private lazy
    var purchaseLabel = UILabel().with {
        $0.attributedText = uiConfig.attributedPurchaseText
    }

    private lazy
    var termsOfUseButton = UIButton().with {
        $0.setAttributedTitle(uiConfig.attributedTermsOfUse, for: .normal)
        $0.titleLabel?.numberOfLines  = 0
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.tag = DemoAction.termsOfUse.rawValue
    }

    private lazy
    var buttonsStackView = UIStackView(arrangedSubviews: [videoButton, premiumButton]).with {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 20
    }

    private lazy
    var labelsStackView = UIStackView(arrangedSubviews: [purchaseLabel, termsOfUseButton]).with {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 15
    }

    // MARK: Initialize

    init(uiConfig: WAL02AdsOrBuyUIConfig) {
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
        action?(sender.tag)
    }

    func updateUI() {
        premiumButton.isEnabled = !uiConfig.isPremiumPurchased
        restoreButton.isEnabled = !uiConfig.isPremiumPurchased

        giftImageView.shakeAnimation()
    }
    
    @objc private
    func close() {
        dismiss(animated: true)
    }

}


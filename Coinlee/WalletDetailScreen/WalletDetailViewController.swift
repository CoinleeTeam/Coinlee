//
//  WalletDetailViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 03/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class WalletDetailViewController: UIViewController {
    let viewModel: WalletDetailViewModelType
    let walletDetailView = WalletDetailView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Inits
    init(viewModel: WalletDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController's Lifecycle
    override func loadView() {
        super.loadView()
        view = walletDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToTapRecognizerEvent()
        subscribeToNameTextFieldText()
        subscribeToBalanceTextFieldText()
        subscribeToCurrency()
        subscribeToIcon()
        subscribeToWalletType()
    }
    
    // MARK: Subscriptions
    private func subscribeToTapRecognizerEvent() {
        walletDetailView.tapRecognizer.rx.event
            .subscribe { _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToNameTextFieldText() {
        walletDetailView.nameTextField.rx
            .text
            .orEmpty
            .scan(String(), accumulator: { _, newText in
                let maxTextCount = 35
                var acceptedText = newText
                
                if newText.count > maxTextCount {
                    acceptedText = newText.truncated(to: maxTextCount)
                }
                
                self.viewModel.walletName = acceptedText
                return acceptedText
            })
            .bind(to: walletDetailView.nameTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToBalanceTextFieldText() {
        walletDetailView.balanceTextField.rx
            .text
            .orEmpty
            .scan(String(), accumulator: { previousText, newText in
                let numberFormatter = AccountingNumberFormatter()
                let acceptedText = numberFormatter.applyFormat(previousText: previousText,
                                                               currentText: newText)
                self.viewModel.balance = acceptedText.asDouble() ?? Double()
                return acceptedText
            })
            .bind(to: walletDetailView.balanceTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToCurrency() {
        viewModel.currency
            .subscribe(onNext: { currency in
                self.walletDetailView.currencyButton.setTitle(currency.code, for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToIcon() {
        viewModel.icon
            .subscribe(onNext: { icon in
                let image = UIImage(named: icon.rawValue)?.preparingThumbnail(of: CGSize(width: 40, height: 40))
                self.walletDetailView.iconButton.setImage(image, for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToWalletType() {
        viewModel.walletType
            .subscribe(onNext: { walletType in
                let typeButtonTitle: String
                if let walletType = walletType {
                    typeButtonTitle = walletType.localizedTitle
                    self.walletDetailView.typeButton.configuration?.baseForegroundColor = .charcoal
                } else {
                    typeButtonTitle = NSLocalizedString("select_type_button", comment: "Select type button")
                }
                self.walletDetailView.typeButton.setTitle(typeButtonTitle, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}

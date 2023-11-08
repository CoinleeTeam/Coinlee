//
//  WalletDetailViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 03/11/2023.
//

import UIKit

final class WalletDetailViewController: UIViewController {
    let viewModel: WalletDetailViewModelType
    let walletDetailView = WalletDetailView()
    
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
        walletDetailView.assignTextFieldsDelegates(to: self)
    }
}

// MARK: - UITextFieldDelegate
extension WalletDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // balanceTextField
        if textField == walletDetailView.balanceTextField {
            return (textField as? TextField)?.applyAccountingNumberFormat(textField, range: range, string: string) ?? true
        }
        
        // nameTextField
        if textField == walletDetailView.nameTextField {
            guard let textFieldText = textField.text else { return false }
            let newText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
            let maxTextCount = 35
            if newText.count > maxTextCount {
                textField.text = newText.truncated(to: maxTextCount)
                return false
            }
        }
        
        return true
    }
}

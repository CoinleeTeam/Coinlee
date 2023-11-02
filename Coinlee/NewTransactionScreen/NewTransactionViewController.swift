//
//  newTransactionScreen.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit

final class NewTransactionViewController: UIViewController {
    //    let viewModel: MODEL PROTOCOL TYPE
    let newTransactionView = NewTransactionView()
    
    // MARK: - Inits
    init(viewModel: NewTransactionViewModelType) {
        //        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        //        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController's Lifecycle
    override func loadView() {
        super.loadView()
        view = newTransactionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTransactionView.assignAmountTextFieldDelegates(to: self)
        newTransactionView.assignNoteTextViewDelegates(to: self)
        newTransactionView.addKeyboardToolBar(viewController: self, action: #selector(doneTapped))
    }
    
    @objc func doneTapped() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension NewTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = CharacterConstants.dot
        formatter.decimalSeparator = CharacterConstants.comma
        
        if let text = textField.text, !text.isEmpty && (string == CharacterConstants.dot || string == formatter.decimalSeparator) {
            let newText = (text as NSString).replacingCharacters(in: range, with: CharacterConstants.comma)
            if newText.components(separatedBy: formatter.decimalSeparator).count <= 2 {
                textField.text = newText
            }
            return false
        }
        
        if let textWithoutGroupingSeparator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: "") {
            var totalTextWithoutGroupingSeparators = textWithoutGroupingSeparator + string
            
            if string.isEmpty {
                totalTextWithoutGroupingSeparators.removeLast()
                
                if totalTextWithoutGroupingSeparators.count == 0 {
                    textField.text = String()
                }
            }
            
            if let numberWithoutGroupingSeparator = formatter.number(from: totalTextWithoutGroupingSeparators),
               let formattedText = formatter.string(from: numberWithoutGroupingSeparator), formattedText.count <= 19 {
            
                if totalTextWithoutGroupingSeparators.hasSuffix("\(CharacterConstants.comma)\(String(0))") {
                    textField.text = formattedText + CharacterConstants.comma + String(0)
                } else {
                    textField.text = formattedText
                }
            }
        }
        return false
    }
}

// MARK: - UITextViewDelegate
extension NewTransactionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        newTransactionView.togglePlaceholderVisibility(isTextPresent: textView.text.isEmpty)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        newTransactionView.togglePlaceholderVisibility(isTextPresent: textView.text.isEmpty)
    }
}

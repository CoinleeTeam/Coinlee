//
//  newTransactionScreen.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit

final class NewTransactionViewController: UIViewController {
    let viewModel: NewTransactionViewViewModelType
    let newTransactionView = NewTransactionView()
    
    // MARK: - Inits
    init(viewModel: NewTransactionViewViewModelType) {
        self.viewModel = viewModel
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
        newTransactionView.assignSubviewsDelegates(to: self)
        addNotificationCenterObservers()
    }
    
    // MARK: - NotificationCenter
    private func addNotificationCenterObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotificationTriggered(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotificationTriggered(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardNotificationTriggered(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        else { return }
        
        let contentHeight = newTransactionView.saveTransactionButton.frame.origin.y + newTransactionView.saveTransactionButton.frame.height
        let scrollViewHeight = newTransactionView.scrollView.frame.height
        let bottomViewsGapHeight = newTransactionView.saveTransactionButton.frame.origin.y - newTransactionView.middleStack.frame.origin.y - newTransactionView.middleStack.frame.height
        let contentBottomInset =  contentHeight + keyboardHeight + bottomViewsGapHeight - scrollViewHeight
        
        if notification.name == UIResponder.keyboardWillShowNotification && contentBottomInset > 0 {
            newTransactionView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentBottomInset, right: 0)
            newTransactionView.scrollView.scrollIndicatorInsets = newTransactionView.scrollView.contentInset
            guard newTransactionView.noteTextView.isFirstResponder else { return }
            UIView.animate(withDuration: 0.5) {
                self.newTransactionView.scrollView.contentOffset = CGPoint(x: 0, y: contentBottomInset)
            }
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            newTransactionView.scrollView.contentInset = .zero
            UIView.animate(withDuration: 0.5) {
                self.newTransactionView.scrollView.contentOffset = .zero
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension NewTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        (textField as? CustomUITextField)?.applyAccountingNumberFormat(textField, range: range, string: string) ?? true
    }
}

// MARK: - UITextViewDelegate
extension NewTransactionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        newTransactionView.noteTextView.togglePlaceholderVisibility(isTextPresent: textView.text.isEmpty)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        newTransactionView.noteTextView.togglePlaceholderVisibility(isTextPresent: textView.text.isEmpty)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else if newText.count > 100 || newText.contains("\n") {
            return false
        }
        return true
    }
}

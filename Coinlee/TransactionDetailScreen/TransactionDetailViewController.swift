//
//  TransactionDetailViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit

final class TransactionDetailViewController: UIViewController {
    let viewModel: TransactionDetailViewModelType
    let transactionDetailView = TransactionDetailView()
    
    // MARK: - Inits
    init(viewModel: TransactionDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController's Lifecycle
    override func loadView() {
        super.loadView()
        view = transactionDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionDetailView.assignSubviewsDelegates(to: self)
        addNotificationCenterObservers()
    }
}

// MARK: - UITextFieldDelegate
extension TransactionDetailViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        (textField as? TextField)?.applyAccountingNumberFormat(textField, range: range, string: string) ?? true
//    }
}

// MARK: - UITextViewDelegate
extension TransactionDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        transactionDetailView.noteTextView.togglePlaceholderVisibility(isTextPresent: textView.text.isEmpty)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        transactionDetailView.noteTextView.togglePlaceholderVisibility(isTextPresent: textView.text.isEmpty)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if text == CharacterConstants.newLine {
            textView.resignFirstResponder()
            return false
        } else if newText.count > 100 || newText.contains(CharacterConstants.newLine) {
            return false
        }
        return true
    }
}

// MARK: - NotificationCenter
extension TransactionDetailViewController {
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
        
        let contentHeight = transactionDetailView.saveButton.frame.origin.y + transactionDetailView.saveButton.frame.height
        let scrollViewHeight = transactionDetailView.scrollView.frame.height
        let bottomViewsGapHeight = transactionDetailView.saveButton.frame.origin.y - transactionDetailView.middleStack.frame.origin.y - transactionDetailView.middleStack.frame.height
        let contentBottomInset =  contentHeight + keyboardHeight + bottomViewsGapHeight - scrollViewHeight
        
        if notification.name == UIResponder.keyboardWillShowNotification && contentBottomInset > 0 {
            transactionDetailView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentBottomInset, right: 0)
            transactionDetailView.scrollView.scrollIndicatorInsets = transactionDetailView.scrollView.contentInset
            guard transactionDetailView.noteTextView.isFirstResponder else { return }
            UIView.animate(withDuration: 0.5) {
                self.transactionDetailView.scrollView.contentOffset = CGPoint(x: 0, y: contentBottomInset)
            }
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            transactionDetailView.scrollView.contentInset = .zero
            UIView.animate(withDuration: 0.5) {
                self.transactionDetailView.scrollView.contentOffset = .zero
            }
        }
    }
}

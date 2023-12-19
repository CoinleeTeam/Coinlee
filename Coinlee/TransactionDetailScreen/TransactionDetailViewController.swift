//
//  TransactionDetailViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class TransactionDetailViewController: UIViewController {
    let viewModel: TransactionDetailViewModelType
    let transactionDetailView = TransactionDetailView()
    
    private let disposeBag = DisposeBag()
    
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
        addRxObservers()
        transactionDetailView.incomeButton.isUserInteractionEnabled = true
        subscribeToTransactionTypeButtonsTap()
        subscribeToAmountTextFieldText()
        subscribeToNoteTextViewEvents()
        subscribeToWallet()
        subscribeToTransactionCategory()
    }
    
    // MARK: Subscriptions
    private func subscribeToWallet() {
        viewModel.wallet
            .subscribe(onNext: { wallet in
                let image = UIImage(named: wallet.icon.rawValue)?.preparingThumbnail(of: CGSize(width: 40, height: 40))
                self.transactionDetailView.walletButton.setImage(image, for: .normal)
                self.transactionDetailView.walletButton.setTitle(wallet.name, for: .normal)
                self.transactionDetailView.amountTextField.currencyLabel?.text = CharacterConstants.verticalBar + CharacterConstants.whitespace + wallet.currency.code
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToTransactionCategory() {
        viewModel.transactionCategory
            .subscribe(onNext: { transactionCategory in
                let categoryButtonTitle: String
                if let transactionCategory = transactionCategory {
                    categoryButtonTitle = transactionCategory.localizedName
                    self.transactionDetailView.categoryButton.configuration?.baseForegroundColor = .charcoal
                } else {
                    categoryButtonTitle = NSLocalizedString("select_type_button", comment: "Select type button")
                }
                self.transactionDetailView.categoryButton.setTitle(categoryButtonTitle, for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToAmountTextFieldText() {
        transactionDetailView.amountTextField.rx
            .text
            .orEmpty
            .scan(String(), accumulator: { previousText, newText in
                let numberFormatter = AccountingNumberFormatter()
                let acceptedText = numberFormatter.applyFormat(previousText: previousText,
                                                               currentText: newText)
                self.viewModel.amount = acceptedText.asDouble() ?? Double()
                return acceptedText
            })
            .bind(to: transactionDetailView.amountTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToTransactionTypeButtonsTap() {
        transactionDetailView.incomeButton.rx
            .tap
            .subscribe(onNext: { _ in
                self.transactionDetailView.animateLayerMotion(x: 6,
                                                              color: UIColor.paleLimeGreen.cgColor)
                self.viewModel.transactionType = .income
            })
            .disposed(by: disposeBag)
        
        transactionDetailView.expenseButton.rx
            .tap
            .subscribe(onNext: { _ in
                self.transactionDetailView.animateLayerMotion(x: 96.5,
                                                              color: UIColor.salmonPink.cgColor)
                self.viewModel.transactionType = .expense
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToNoteTextViewEvents() {
        transactionDetailView.noteTextView.rx
            .didBeginEditing
            .subscribe(onNext: { _ in
                let currentText = self.transactionDetailView.noteTextView.text
                self.transactionDetailView.noteTextView.togglePlaceholderVisibilityIfPossible(textViewText: currentText)
            })
            .disposed(by: disposeBag)
        
        transactionDetailView.noteTextView.rx
            .didEndEditing
            .subscribe(onNext: { _ in
                let currentText = self.transactionDetailView.noteTextView.text
                self.transactionDetailView.noteTextView.togglePlaceholderVisibilityIfPossible(textViewText: currentText)
            })
            .disposed(by: disposeBag)
        
        transactionDetailView.noteTextView.rx
            .text
            .orEmpty
            .scan(String(), accumulator: { previousText, newText in
                var acceptedText = newText
                if newText.contains(CharacterConstants.newLine) {
                    self.transactionDetailView.noteTextView.resignFirstResponder()
                    self.transactionDetailView.noteTextView.togglePlaceholderVisibilityIfPossible(textViewText: previousText)
                    acceptedText = previousText
                } else if newText.count > 100 {
                    acceptedText = previousText
                }
                self.viewModel.note = acceptedText
                return acceptedText
            })
            .bind(to: transactionDetailView.noteTextView.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: NotificationCenter Subscriptions
extension TransactionDetailViewController {
    private func addRxObservers() {
         NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
             .subscribe(onNext: { notification in
                 self.toggleScrollViewContentOffset(notification: notification)
             })
             .disposed(by: disposeBag)

         NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
             .subscribe(onNext: { notification in
                 self.toggleScrollViewContentOffset(notification: notification)
             })
             .disposed(by: disposeBag)
     }
    
    private func toggleScrollViewContentOffset(notification: Notification) {
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

//
//  TransactionDetailView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit
import SnapKit

final class TransactionDetailView: ScrollableView {
    // MARK: TransactionTypeButtonsStack
    private let transactionTypeButtonsStack = UIStackView()
    private let transactionTypeButtonsContainerView = ContainerView()
    private let containerViewLayer = CALayer()
    let incomeButton = UIButton()
    let expenseButton = UIButton()
    
    // MARK: MiddleStack
    let middleStack = UIStackView()
    let amountTextField = TextField()
    let categoryButton = ConfigurableButton()
    private let dateAndWalletStack = UIStackView()
    let dateButton = ConfigurableButton()
    let walletButton = ConfigurableButton()
    let noteTextView = NoteTextView()
    
    // MARK: Save Button
    let saveButton = ConfigurableButton()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        setUpTransactionTypeButtons()
        configureTransactionTypeButtonsStack()
        setUpAmountTextField()
        setUpButtons()
        configureMiddleStack()
        addConstraints()
        amountTextField.addCurrencyLabelToRightView()
        // REMOVE
        dateButton.setTitle("29 Maj 23", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Subviews' setup
    private func setUpTransactionTypeButtons() {
        // Income Transaction Type Button
        incomeButton.setTitle(NSLocalizedString("income_transaction_type", comment: "Income transaction"), for: .normal)
        incomeButton.setTitleColor(.charcoal, for: .normal)
        incomeButton.titleLabel?.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 14)
        incomeButton.layer.cornerRadius = 10
        
        // Expense Transaction Type Button
        expenseButton.setTitle(NSLocalizedString("expense_transaction_type", comment: "Expense transaction"), for: .normal)
        expenseButton.setTitleColor(.charcoal, for: .normal)
        expenseButton.titleLabel?.font = incomeButton.titleLabel?.font
        expenseButton.layer.cornerRadius = incomeButton.layer.cornerRadius
        
        // transactionTypeButtonsContainerView
        transactionTypeButtonsContainerView.layer.addSublayer(containerViewLayer)
        transactionTypeButtonsContainerView.shadowType = .bottom
        transactionTypeButtonsContainerView.backgroundColor = .white
        
        // containerBackgroundLayer
        containerViewLayer.backgroundColor = UIColor.salmonPink.cgColor
        containerViewLayer.cornerRadius = 10
        containerViewLayer.frame = CGRect(x: 96.5, y: 6, width: 90.5, height: 38)
    }
    
    private func setUpAmountTextField() {
        amountTextField.addLeftIcon(icon: UIImage(named: LinearIcon.dollar.rawValue))
        amountTextField.placeholder = NSLocalizedString("amount_placeholder", comment: "Amount placeholder")
        amountTextField.keyboardType = .decimalPad
        amountTextField.shadowType = .bottom
        amountTextField.backgroundColor = .white
    }
    
    private func setUpButtons() {
        // categorySelectionButton
        categoryButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                                 titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                                 leftImagePadding: 16,
                                                 rightImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                                 rightImagePosition: .fixed,
                                                 rightImagePadding: 8,
                                                 contentEdgesInsets: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))
        categoryButton.rightImageView?.tintColor = .charcoal
        categoryButton.shadowType = .bottom
        categoryButton.backgroundColor = .white

        // dateSelectionButton
        dateButton.setTitleColor(.charcoal, for: .normal)
        dateButton.titleLabel?.font = incomeButton.titleLabel?.font
        dateButton.backgroundColor = .white
        
        dateButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                             titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                             leftImage: UIImage(named: LinearIcon.calendar.rawValue),
                                             leftImageTintColor: .goldenrod,
                                             leftImagePadding: 8)
        dateButton.shadowType = .bottom
        dateButton.backgroundColor = .white
 
        // walletSelectionButton
        walletButton.titleLabel?.font = incomeButton.titleLabel?.font
        walletButton.addConfiguration(baseForegroundColor: .charcoal,
                                               titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                               leftImagePadding: 4,
                                               rightImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                               rightImagePosition: .fixed,
                                               rightImagePadding: 8,
                                               contentEdgesInsets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0))
        walletButton.shadowType = .bottom
        walletButton.backgroundColor = .white

        // saveTransactionButton
        saveButton.setTitle(NSLocalizedString("save_transaction_button", comment: "Save transaction"), for: .normal)
        saveButton.addConfiguration(baseForegroundColor: .charcoal,
                                               titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                               contentEdgesInsets: UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24))
        saveButton.shadowType = .bottom
        saveButton.backgroundColor = .goldenrod
    }
    
    private func configureTransactionTypeButtonsStack() {
        transactionTypeButtonsStack.addArrangedSubview(incomeButton)
        transactionTypeButtonsStack.addArrangedSubview(expenseButton)
        
        transactionTypeButtonsStack.axis = .horizontal
        transactionTypeButtonsStack.distribution = .fillEqually
        transactionTypeButtonsStack.spacing = 0
    }
    
    private func configureMiddleStack() {
        // dateAndWalletSelectionButtonsStack
        dateAndWalletStack.addArrangedSubview(dateButton)
        dateAndWalletStack.addArrangedSubview(walletButton)
        
        dateAndWalletStack.axis = .horizontal
        dateAndWalletStack.alignment = .fill
        dateAndWalletStack.spacing = 8
        
        // middleStack
        middleStack.addArrangedSubview(amountTextField)
        middleStack.addArrangedSubview(categoryButton)
        middleStack.addArrangedSubview(dateAndWalletStack)
        middleStack.addArrangedSubview(noteTextView)
        
        middleStack.axis = .vertical
        middleStack.spacing = 12
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        scrollView.addSubview(transactionTypeButtonsContainerView)
        scrollView.addSubview(middleStack)
        scrollView.addSubview(saveButton)
        transactionTypeButtonsContainerView.addSubview(transactionTypeButtonsStack)
        
        transactionTypeButtonsStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        transactionTypeButtonsContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(193)
            make.height.equalTo(50)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        dateButton.snp.makeConstraints { make in
            make.width.equalTo(140)
        }
        
        dateAndWalletStack.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        noteTextView.snp.makeConstraints { make in
            make.height.equalTo(133)
        }
        
        middleStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(transactionTypeButtonsContainerView.snp.bottom).offset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(middleStack.snp.bottom).offset(30)
        }
    }
    
    // MARK: - Animations
    func animateLayerMotion(x: CGFloat, color: CGColor) {
        UIView.animate(withDuration: 0.5) {
            self.containerViewLayer.frame = CGRect(x: x, y: 6, width: 90.5, height: 38)
            self.containerViewLayer.backgroundColor = color
        }
    }
}



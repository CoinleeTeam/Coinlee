//
//  NewTransactionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit

final class NewTransactionView: ScrollableView {
    // MARK: TransactionTypeButtonsStack
    let incomeTransactionTypeButton = UIButton()
    let expenseTransactionTypeButton = UIButton()
    private let transactionTypeButtonsStack = UIStackView()
    let transactionTypeButtonsContainerView = ContainerView()
    private let containerBackgroundLayer = CALayer()
    
    // MARK: MiddleStack
    let middleStack = UIStackView()
    let amountTextField = CustomUITextField()
    let categorySelectionButton = ConfigurableButton()
    let dateSelectionButton = ConfigurableButton()
    let walletSelectionButton = ConfigurableButton()
    // MARK: DateAndWalletSelectionButtonsStack
    private let dateAndWalletSelectionButtonsStack = UIStackView()
    let noteTextView = NoteTextView()
    
    // MARK: SaveTransactionButton
    let saveTransactionButton = ConfigurableButton()
    
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
        
        // ---------REMOVE---------
        amountTextField.addCurrencyLabel(currencyCode: CurrencyCode.pln.rawValue)
        categorySelectionButton.setTitle(NSLocalizedString("select_category_button", comment: "Select category"), for: .normal)
        dateSelectionButton.setTitle("29 Maj 23", for: .normal)
        walletSelectionButton.setTitle("Wallet binance usdt", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates
    func assignSubviewsDelegates<T>(to delegate: T) where T: UITextFieldDelegate & UITextViewDelegate {
        amountTextField.delegate = delegate
        noteTextView.delegate = delegate
    }
    
    // MARK: - Subviews' setup
    private func setUpTransactionTypeButtons() {
        // Income Transaction Type Button
        incomeTransactionTypeButton.setTitle(NSLocalizedString("income_transaction_type", comment: "Income transaction"), for: .normal)
        incomeTransactionTypeButton.setTitleColor(.charcoal, for: .normal)
        incomeTransactionTypeButton.titleLabel?.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 14)
        incomeTransactionTypeButton.layer.cornerRadius = 10
        incomeTransactionTypeButton.addTarget(self, action: #selector(transactionTypeButtonTapped(_:)), for: .touchUpInside)
        
        // Expense Transaction Type Button
        expenseTransactionTypeButton.setTitle(NSLocalizedString("expense_transaction_type", comment: "Expense transaction"), for: .normal)
        expenseTransactionTypeButton.setTitleColor(.charcoal, for: .normal)
        expenseTransactionTypeButton.titleLabel?.font = incomeTransactionTypeButton.titleLabel?.font
        expenseTransactionTypeButton.layer.cornerRadius = incomeTransactionTypeButton.layer.cornerRadius
        expenseTransactionTypeButton.addTarget(self, action: #selector(transactionTypeButtonTapped(_:)), for: .touchUpInside)
        
        // transactionTypeButtonsContainerView
        transactionTypeButtonsContainerView.layer.addSublayer(containerBackgroundLayer)
        transactionTypeButtonsContainerView.shadowType = .bottom
        transactionTypeButtonsContainerView.backgroundColor = .white
        
        // containerBackgroundLayer
        containerBackgroundLayer.backgroundColor = UIColor.salmonPink.cgColor
        containerBackgroundLayer.cornerRadius = 10
        containerBackgroundLayer.frame = CGRect(x: 96.5, y: 6, width: 90.5, height: 38)
    }
    
    private func setUpAmountTextField() {
        amountTextField.addLeftIcon(icon: UIImage(named: Icon.Linear.dollar.rawValue) ?? UIImage())
        amountTextField.placeholder = NSLocalizedString("amount_placeholder", comment: "Amount placeholder")
        amountTextField.keyboardType = .decimalPad
        amountTextField.shadowType = .bottom
        amountTextField.backgroundColor = .white
    }
    
    private func setUpButtons() {
        // categorySelectionButton
        categorySelectionButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                                 titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                                 leftImagePadding: 16,
                                                 rightImage: UIImage(named: Icon.Linear.angleRight.rawValue),
                                                 isFixedRightImagePosition: true,
                                                 rightImagePadding: 8,
                                                 contentLeadingInset: 14)
        categorySelectionButton.shadowType = .bottom
        categorySelectionButton.backgroundColor = .white

        // dateSelectionButton
        dateSelectionButton.setTitleColor(.charcoal, for: .normal)
        dateSelectionButton.titleLabel?.font = incomeTransactionTypeButton.titleLabel?.font
        dateSelectionButton.backgroundColor = .white
        
        dateSelectionButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                             titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                             leftImage: UIImage(named: Icon.Linear.calendar.rawValue),
                                             leftImageTintColor: .goldenrod,
                                             leftImagePadding: 8)
        dateSelectionButton.shadowType = .bottom
        dateSelectionButton.backgroundColor = .white
 
        // walletSelectionButton
        walletSelectionButton.titleLabel?.font = incomeTransactionTypeButton.titleLabel?.font
        walletSelectionButton.addConfiguration(baseForegroundColor: .charcoal,
                                               titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                               leftImage: UIImage(named: Icon.Linear.walletTemplate.rawValue),
                                               leftImageTintColor: .goldenrod,
                                               leftImagePadding: 8,
                                               rightImage: UIImage(named: Icon.Linear.angleRight.rawValue),
                                               isFixedRightImagePosition: true,
                                               rightImagePadding: 8,
                                               contentLeadingInset: 14)
        walletSelectionButton.shadowType = .bottom
        walletSelectionButton.backgroundColor = .white

        // saveTransactionButton
        saveTransactionButton.setTitle(NSLocalizedString("save_transaction_button", comment: "Save transaction"), for: .normal)
        saveTransactionButton.addConfiguration(baseForegroundColor: .charcoal,
                                               titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16))
        saveTransactionButton.shadowType = .bottom
        saveTransactionButton.backgroundColor = .goldenrod
    }
    
    private func configureTransactionTypeButtonsStack() {
        transactionTypeButtonsStack.addArrangedSubview(incomeTransactionTypeButton)
        transactionTypeButtonsStack.addArrangedSubview(expenseTransactionTypeButton)
        
        transactionTypeButtonsStack.axis = .horizontal
        transactionTypeButtonsStack.distribution = .fillEqually
        transactionTypeButtonsStack.spacing = 0
    }
    
    private func configureMiddleStack() {
        // dateAndWalletSelectionButtonsStack
        dateAndWalletSelectionButtonsStack.addArrangedSubview(dateSelectionButton)
        dateAndWalletSelectionButtonsStack.addArrangedSubview(walletSelectionButton)
        
        dateAndWalletSelectionButtonsStack.axis = .horizontal
        dateAndWalletSelectionButtonsStack.alignment = .fill
        dateAndWalletSelectionButtonsStack.spacing = 8
        
        // middleStack
        middleStack.addArrangedSubview(amountTextField)
        middleStack.addArrangedSubview(categorySelectionButton)
        middleStack.addArrangedSubview(dateAndWalletSelectionButtonsStack)
        middleStack.addArrangedSubview(noteTextView)
        
        middleStack.axis = .vertical
        middleStack.spacing = 12
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        scrollView.addSubview(transactionTypeButtonsContainerView)
        scrollView.addSubview(middleStack)
        scrollView.addSubview(saveTransactionButton)
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
        
        categorySelectionButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        dateSelectionButton.snp.makeConstraints { make in
            make.width.equalTo(140)
        }
        
        dateAndWalletSelectionButtonsStack.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        noteTextView.snp.makeConstraints { make in
            make.height.equalTo(133)
        }
        
        middleStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(transactionTypeButtonsContainerView.snp.bottom).offset(20)
        }
        
        saveTransactionButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(193)
            make.centerX.equalToSuperview()
            make.top.equalTo(middleStack.snp.bottom).offset(30)
        }
    }
    
    // MARK: - Animations
    private func animateLayerMotion(x: CGFloat, color: CGColor) {
        UIView.animate(withDuration: 0.5) {
            self.containerBackgroundLayer.frame = CGRect(x: x, y: 6, width: 90.5, height: 38)
            self.containerBackgroundLayer.backgroundColor = color
        }
    }
    
    @objc func transactionTypeButtonTapped(_ sender: UIButton) {
        if sender == incomeTransactionTypeButton {
            animateLayerMotion(x: 6, color: UIColor.paleLimeGreen.cgColor)
        } else if sender == expenseTransactionTypeButton {
            animateLayerMotion(x: 96.5, color: UIColor.salmonPink.cgColor)
        }
    }
}



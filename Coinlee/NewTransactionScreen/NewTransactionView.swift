//
//  NewTransactionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 28/10/2023.
//

import UIKit

final class NewTransactionView: UIView {
    // MARK: TransactionTypeButtonsStack
    let incomeTransactionTypeButton = UIButton()
    let expenseTransactionTypeButton = UIButton()
    private let transactionTypeButtonsStack = UIStackView()
    private let transactionTypeButtonsContainerView = UIView()
    
    // MARK: MiddleStack
    let amountTextField = CustomUITextField()
    private let keyboardBar = UIToolbar()
    let categorySelectionButton = ConfigurableButton()
    let dateSelectionButton = ConfigurableButton()
    let walletSelectionButton = ConfigurableButton()
    // MARK: DateAndWalletSelectionButtonsStack
    private let dateAndWalletSelectionButtonsStack = UIStackView()
    private let noteTextViewPlaceholder = UILabel()
    let noteTextView = UITextView()
    private let middleStack = UIStackView()
    
    // MARK: SaveTransactionButton
    let saveTransactionButton = ConfigurableButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        transactionTypeButtonsContainerView.createBasicContainerWithBottomShadow()
        amountTextField.createBasicContainerWithBottomShadow()
        categorySelectionButton.createBasicContainerWithBottomShadow()
        dateSelectionButton.createBasicContainerWithBottomShadow()
        walletSelectionButton.createBasicContainerWithBottomShadow()
        noteTextView.createBasicContainerWithBottomShadow()
        saveTransactionButton.createBasicContainerWithBottomShadow(viewBackgroundColor: .goldenrod)
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        
        setUpTransactionTypeButtons()
        configureTransactionTypeButtonsStack()
        setUpAmountTextField()
        setUpSelectCategoryButton()
        setUpDateSelectionButton()
        setUpWalletSelectionButton()
        configureDateAndWalletSelectionButtonsStack()
        setUpNoteTextView()
        configureMiddleStack()
        setUpSaveTransactionButton()
        addConstraints()
        setSubviewFramesSizes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates
    func assignAmountTextFieldDelegates<T>(to delegate: T) where T: UITextFieldDelegate {
        amountTextField.delegate = delegate
    }
    
    func assignNoteTextViewDelegates<T>(to delegate: T) where T: UITextViewDelegate {
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
    }
    
    private func setUpAmountTextField() {
        amountTextField.addLeftIcon(icon: UIImage(named: Icon.Linear.dollar.rawValue) ?? UIImage())
        amountTextField.placeholder = NSLocalizedString("amount_placeholder", comment: "Amount placeholder")
        amountTextField.keyboardType = .decimalPad
        
        // REMOVE
        amountTextField.addCurrencyLabel(currencyCode: CurrencyCode.pln.rawValue)
        // REMOVE
    }
    
    private func setUpSelectCategoryButton() {
        // REMOVE
        categorySelectionButton.setTitle(NSLocalizedString("select_category_button", comment: "Select category"), for: .normal)
        // REMOVE
        
        categorySelectionButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                                 titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                                 rightImage: UIImage(named: Icon.Linear.angleRight.rawValue),
                                                 rightImagePadding: 160)
    }
    
    private func setUpDateSelectionButton() {
        // REMOVE
        dateSelectionButton.setTitle("29 Maj 23", for: .normal)
        // REMOVE
        
        dateSelectionButton.setTitleColor(.charcoal, for: .normal)
        dateSelectionButton.titleLabel?.font = incomeTransactionTypeButton.titleLabel?.font
        dateSelectionButton.layer.backgroundColor = UIColor.white.cgColor
        
        dateSelectionButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                             titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                             leftImage: UIImage(named: Icon.Linear.calendar.rawValue),
                                             leftImageTintColor: .goldenrod,
                                             leftImagePadding: 8)
    }
    
    private func setUpWalletSelectionButton() {
        // REMOVE
        walletSelectionButton.setTitle("Wallet", for: .normal)
        // REMOVE
        
        walletSelectionButton.titleLabel?.font = incomeTransactionTypeButton.titleLabel?.font
        
        walletSelectionButton.addConfiguration(baseForegroundColor: .charcoal,
                                               titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                               leftImage: UIImage(named: Icon.Linear.walletTemplate.rawValue),
                                               leftImageTintColor: .goldenrod,
                                               rightImage: UIImage(named: Icon.Linear.angleRight.rawValue))
    }
    
    private func setUpSaveTransactionButton() {
        saveTransactionButton.setTitle(NSLocalizedString("save_transaction_button", comment: "Save transaction"), for: .normal)
        saveTransactionButton.setTitleColor(.charcoal, for: .normal)
        saveTransactionButton.titleLabel?.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        saveTransactionButton.addConfiguration()
    }
    
    private func setUpNoteTextView() {
        noteTextViewPlaceholder.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        noteTextViewPlaceholder.textColor = .battleshipGrey
        noteTextViewPlaceholder.text = NSLocalizedString("note_text_view_placeholder", comment: "Note Text View Placeholder")
        
        noteTextView.layer.cornerRadius = 15
        noteTextView.textColor = .charcoal
        noteTextView.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        noteTextView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 0, right: 10)
        noteTextView.showsVerticalScrollIndicator = false
        noteTextView.layer.masksToBounds = false
        noteTextView.textContainer.maximumNumberOfLines = 6
    }
    
    private func configureTransactionTypeButtonsStack() {
        transactionTypeButtonsStack.addArrangedSubview(incomeTransactionTypeButton)
        transactionTypeButtonsStack.addArrangedSubview(expenseTransactionTypeButton)
        
        transactionTypeButtonsStack.axis = .horizontal
        transactionTypeButtonsStack.distribution = .fillEqually
        transactionTypeButtonsStack.spacing = 0
    }
    
    private func configureDateAndWalletSelectionButtonsStack() {
        dateAndWalletSelectionButtonsStack.addArrangedSubview(dateSelectionButton)
        dateAndWalletSelectionButtonsStack.addArrangedSubview(walletSelectionButton)
        
        dateAndWalletSelectionButtonsStack.axis = .horizontal
        dateAndWalletSelectionButtonsStack.alignment = .fill
        dateAndWalletSelectionButtonsStack.spacing = 8
    }
    
    private func configureMiddleStack() {
        middleStack.addArrangedSubview(amountTextField)
        middleStack.addArrangedSubview(categorySelectionButton)
        middleStack.addArrangedSubview(dateAndWalletSelectionButtonsStack)
        middleStack.addArrangedSubview(noteTextView)
        
        middleStack.axis = .vertical
        middleStack.spacing = 12
    }
    
    func addKeyboardToolBar(viewController: UIViewController, action: Selector) {
        let doneButton = UIBarButtonItem()
        doneButton.title = "Done"
        doneButton.style = .plain
        doneButton.target = viewController
        doneButton.action = action
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardBar.items = [space, doneButton]
        keyboardBar.sizeToFit()
        amountTextField.inputAccessoryView = keyboardBar
        noteTextView.inputAccessoryView = keyboardBar
    }
    
    private func setSubviewFramesSizes() {
        guard let screenWidth = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.width else { return }
        
        transactionTypeButtonsContainerView.frame = CGRect(x: 0, y: 0, width: screenWidth - 200, height: 45)
        amountTextField.frame = CGRect(x: 0, y: 0, width: screenWidth - 48, height: 45)
        categorySelectionButton.frame = CGRect(x: 0, y: 0, width: screenWidth - 48, height: 45)
        dateSelectionButton.frame = CGRect(x: 0, y: 0, width: 140, height: 45)
        
        walletSelectionButton.frame = CGRect(x: 0, y: 0,
                                             width: (screenWidth - dateAndWalletSelectionButtonsStack.spacing - dateSelectionButton.frame.width - 48),
                                             height: 45)
        
        noteTextView.frame = CGRect(x: 0, y: 0, width: screenWidth - 48, height: 135)
        saveTransactionButton.frame = CGRect(x: 0, y: 0, width: screenWidth - 200, height: 50)
    }
    
    func togglePlaceholderVisibility(isTextPresent: Bool) {
        if isTextPresent {
            noteTextViewPlaceholder.isHidden = !noteTextViewPlaceholder.isHidden
        }
    }
    
    @objc func transactionTypeButtonTapped(_ sender: UIButton) {
        if sender == incomeTransactionTypeButton {
            incomeTransactionTypeButton.backgroundColor = .paleLimeGreen
            expenseTransactionTypeButton.backgroundColor = .white
        } else if sender == expenseTransactionTypeButton {
            expenseTransactionTypeButton.backgroundColor = .salmonPink
            incomeTransactionTypeButton.backgroundColor = .white
        }
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        addSubview(transactionTypeButtonsContainerView)
        addSubview(middleStack)
        addSubview(saveTransactionButton)
        
        transactionTypeButtonsContainerView.addSubview(transactionTypeButtonsStack)
        noteTextView.addSubview(noteTextViewPlaceholder)
        
        transactionTypeButtonsStack.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview().inset(6)
        }
        
        transactionTypeButtonsContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.trailing.equalToSuperview().inset(100)
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
        
        noteTextViewPlaceholder.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(12)
        }
        
        noteTextView.snp.makeConstraints { make in
            make.height.equalTo(135)
        }
        
        middleStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(transactionTypeButtonsContainerView.snp.bottom).offset(20)
        }
        
        saveTransactionButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(100)
            make.top.equalTo(middleStack.snp.bottom).offset(20)
        }
    }
}



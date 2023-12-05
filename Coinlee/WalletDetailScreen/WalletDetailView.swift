//
//  WalletDetailView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 03/11/2023.
//

import UIKit
import SnapKit

final class WalletDetailView: UIView {
    private let tapRecognizer = UITapGestureRecognizer()
    
    // MARK: Top stacks
    private let nameAndIconLabelsStack = UIStackView()
    let nameLabel = UILabel()
    let iconLabel = UILabel()
    private let nameAndIconStack = UIStackView()
    let nameTextField = TextField()
    let iconButton = ConfigurableButton()
    
    // MARK: Middle stacks
    private let balanceAndCurrencyLabelsStack = UIStackView()
    let balanceLabel = UILabel()
    let currencyLabel = UILabel()
    private let balanceAndCurrencyStack = UIStackView()
    let balanceTextField = TextField()
    let currencyButton = ConfigurableButton()
    
    // MARK: Bottom Views
    let typeLabel = UILabel()
    let typeButton = ConfigurableButton()
    let saveButton = ConfigurableButton()
        
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        
        setUpHeaderLabels()
        setUpTextFields()
        setUpButtons()
        configureTopStacks()
        configureMiddleStacks()
        setUpTapRecognizer()
        addConstraints()
        
        // ---------REMOVE---------
        currencyButton.setTitle("EUR", for: .normal)
        typeButton.setTitle(NSLocalizedString("select_type_button", comment: "Select type button"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TapGestureRecognizer
    private func setUpTapRecognizer() {
        addGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(self, action: #selector(didTapView))
    }
    
    @objc private func didTapView() {
        endEditing(true)
    }
    
    // MARK: - Delegates
    func assignTextFieldsDelegates<T>(to delegate: T) where T: UITextFieldDelegate {
        balanceTextField.delegate = delegate
        nameTextField.delegate = delegate
    }
    
    // MARK: - Subviews' setup
    private func setUpHeaderLabels() {
        // nameLabel
        nameLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 15)
        nameLabel.textColor = .charcoal
        nameLabel.text = NSLocalizedString("name_label", comment: "Name label")
        
        // iconLabel
        iconLabel.font = nameLabel.font
        iconLabel.textColor = nameLabel.textColor
        iconLabel.text = NSLocalizedString("icon_label", comment: "Icon label")
        
        // balanceLabel
        balanceLabel.font = nameLabel.font
        balanceLabel.textColor = nameLabel.textColor
        balanceLabel.text = NSLocalizedString("balance_label", comment: "Balance label")
        
        // currencyLabel
        currencyLabel.font = nameLabel.font
        currencyLabel.textColor = nameLabel.textColor
        currencyLabel.text = NSLocalizedString("currency_label", comment: "Currency label")
        
        // typeLabel
        typeLabel.font = nameLabel.font
        typeLabel.textColor = nameLabel.textColor
        typeLabel.text = NSLocalizedString("type_label", comment: "Type label")
    }
    
    private func setUpTextFields() {
        // nameTextField
        nameTextField.placeholder = NSLocalizedString("wallet_name_text_field_placeholder", comment: "Wallet name placeholder")
        nameTextField.shadowType = .bottom
        nameTextField.backgroundColor = .white
        
        // balanceTextField
        balanceTextField.placeholder = String(0)
        balanceTextField.addLeftIcon(icon: UIImage(named: LinearIcon.dollar.rawValue))
        balanceTextField.keyboardType = .decimalPad
        balanceTextField.shadowType = .bottom
        balanceTextField.backgroundColor = .white
    }
    
    private func setUpButtons() {
        // iconSelectionButton
        iconButton.addConfiguration(baseForegroundColor: .charcoal,
                                             titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                             leftImage: UIImage(named: WalletIcon.wallet.rawValue)?.preparingThumbnail(of: CGSize(width: 40, height: 40)),
                                             leftImagePadding: 8,
                                             rightImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                             rightImagePosition: .fixed,
                                             rightImagePadding: 8,
                                             contentEdgesInsets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        iconButton.shadowType = .bottom
        iconButton.backgroundColor = .white
        
        //currencySelectionButton
        currencyButton.addConfiguration(baseForegroundColor: .charcoal,
                                                 titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                                 leftImagePadding: 8,
                                                 rightImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                                 rightImagePosition: .fixed,
                                                 rightImagePadding: 8,
                                                 contentEdgesInsets: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))
        currencyButton.shadowType = .bottom
        currencyButton.backgroundColor = .white
        
        // typeSelectionButton
        typeButton.addConfiguration(baseForegroundColor: .battleshipGrey,
                                             titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                             leftImagePadding: 16,
                                             rightImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                             rightImagePosition: .fixed,
                                             rightImagePadding: 8,
                                             contentEdgesInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        typeButton.shadowType = .bottom
        typeButton.backgroundColor = .white
        
        // saveWalletButton
        saveButton.setTitle(NSLocalizedString("add_new_wallet_button", comment: "Add wallet button"), for: .normal)
        saveButton.addConfiguration(baseForegroundColor: .charcoal,
                                          titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                          contentEdgesInsets: UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24))
        saveButton.shadowType = .bottom
        saveButton.backgroundColor = .goldenrod
    }
    
    private func configureTopStacks() {
        // nameLabelAndIconLabelStack
        nameAndIconLabelsStack.addArrangedSubview(nameLabel)
        nameAndIconLabelsStack.addArrangedSubview(iconLabel)
        nameAndIconLabelsStack.axis = .horizontal
        nameAndIconLabelsStack.alignment = .fill
        nameAndIconLabelsStack.spacing = 8
        
        // nameTextFieldAndIconSelectionButtonStack
        nameAndIconStack.addArrangedSubview(nameTextField)
        nameAndIconStack.addArrangedSubview(iconButton)
        nameAndIconStack.axis = .horizontal
        nameAndIconStack.alignment = .fill
        nameAndIconStack.spacing = 12
    }
    
    private func configureMiddleStacks() {
        // balanceLabelAndCurrencyLabelStack
        balanceAndCurrencyLabelsStack.addArrangedSubview(balanceLabel)
        balanceAndCurrencyLabelsStack.addArrangedSubview(currencyLabel)
        balanceAndCurrencyLabelsStack.axis = .horizontal
        balanceAndCurrencyLabelsStack.alignment = .fill
        balanceAndCurrencyLabelsStack.spacing = 8
        
        // balanceTextFieldAndCurrencySelectionButtonStack
        balanceAndCurrencyStack.addArrangedSubview(balanceTextField)
        balanceAndCurrencyStack.addArrangedSubview(currencyButton)
        balanceAndCurrencyStack.axis = .horizontal
        balanceAndCurrencyStack.alignment = .fill
        balanceAndCurrencyStack.spacing = 12
    }
    
    // MARK: Constraints
    private func addConstraints() {
        // Top stacks' constraints
        addSubview(nameAndIconStack)
        addSubview(nameAndIconLabelsStack)
        
        iconLabel.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        
        iconButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        nameAndIconLabelsStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(-8)
            make.height.equalTo(45)
        }
        
        nameAndIconStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(nameAndIconLabelsStack.snp.bottom).inset(9)
            make.height.equalTo(45)
        }
        
        // Middle stacks' constraints
        addSubview(balanceAndCurrencyLabelsStack)
        addSubview(balanceAndCurrencyStack)
        
        currencyLabel.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        
        currencyButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        balanceAndCurrencyLabelsStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(nameAndIconStack.snp.bottom)
            make.height.equalTo(45)
        }
        
        balanceAndCurrencyStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(balanceAndCurrencyLabelsStack.snp.bottom).inset(9)
            make.height.equalTo(45)
        }
        
        // Bottom elements' constraints
        addSubview(typeLabel)
        addSubview(typeButton)
        addSubview(saveButton)
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceAndCurrencyStack.snp.bottom)
            make.leading.equalToSuperview().inset(40)
            make.height.equalTo(45)
        }
        
        typeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(typeLabel.snp.bottom).inset(9)
            make.height.equalTo(45)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(typeButton.snp.bottom).offset(28)
        }
    }
}

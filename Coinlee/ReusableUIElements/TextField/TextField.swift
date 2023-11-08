//
//  CustomUITextField.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/10/2023.
//

import UIKit

final class TextField: UITextField {
    private let viewPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private var textPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    var clearDelegate: ClearTextFieldDelegate?
    var maximumNumberOfSymbols = 0
    
    override var bounds: CGRect {
        didSet {
            if shadowType == .bottom {
                createBasicContainerWithBottomShadow()
            } else if shadowType == .rounded {
                createBasicContainerWithRoundShadow()
            }
        }
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    
    override func placeholderRect (forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    
    override func editingRect (forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += viewPadding.left
        return leftViewRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= viewPadding.right
        return rightViewRect
    }
    
    // MARK: - TextField's setup
    private func setupTextField() {
        borderStyle = .none
        layer.cornerRadius = 15
        backgroundColor = .snowWhite
        font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        textColor = .charcoal
        attributedPlaceholder = customizedPlaceholder()
    }
    
    private func customizedPlaceholder() -> NSMutableAttributedString {
        var attributedPlaceholder = NSMutableAttributedString()
        attributedPlaceholder = NSMutableAttributedString(string: "Placeholder",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.battleshipGrey,
                                                                       NSAttributedString.Key.font: UIFont(name: Fonts.Inter.medium.rawValue, size: 16) as Any])
        return attributedPlaceholder
    }
    
    func addLeftIcon(icon: UIImage?) {
        guard let icon = icon else { return }
        textPadding.left = 48
        
        let leftIcon = UIImageView(image: icon)
        leftIcon.tintColor = .goldenrod
        leftViewMode = .always
        leftView = leftIcon
    }
    
    func addClearIcon() {
        textPadding.right = 48
        
        let rightIcon = UIImageView(image: UIImage(named: Icon.Linear.clear.rawValue))
        rightIcon.tintColor = .goldenrod
        rightViewMode = .always
        rightView = rightIcon
        
        rightView?.isHidden = true
        addTapGestureRecognizer(to: rightIcon)
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func addCurrencyLabel(currency: Currency) {
        textPadding.right = 48
        
        let currencyLabel = UILabel()
        currencyLabel.text = "| \(currency.code.rawValue)"
        currencyLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        currencyLabel.textColor = .battleshipGrey
        
        rightViewMode = .always
        rightView = currencyLabel
    }
    
    // MARK: - Textfield's clear button UI and logic
    private func addTapGestureRecognizer(to view: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clearButtonTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    func applyAccountingNumberFormat(_ textField: UITextField, range: NSRange, string: String) -> Bool {
        guard let textFieldText = textField.text else { return false }
        let formatter = AccountingNumberFormatter()
        let newText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        let newTextWithoutGroupingSeparators = newText.replacingOccurrences(of: formatter.groupingSeparator, with: String())
    
        if !textFieldText.isEmpty &&
            string == formatter.decimalSeparator &&
            newText.components(separatedBy: formatter.decimalSeparator).count < 3 {
            return true
        }
    
        if let numberWithoutGroupingSeparator = formatter.number(from: newTextWithoutGroupingSeparators),
           let formattedText = formatter.string(from: numberWithoutGroupingSeparator), formattedText.count <= 19 {
            if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.exactZero(separator: formatter.decimalSeparator)) {
                textField.text = formattedText + formatter.decimalSeparator + String(0)
    
            } else if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.twoOrThreeZeros(separator: formatter.decimalSeparator)) {
                textField.text = formattedText + formatter.decimalSeparator + String(0) + String(0)
    
            } else if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.zeroAtEnd(separator: formatter.decimalSeparator)) {
                textField.text = formattedText + String(0)
    
            } else  {
                textField.text = formattedText
            }
        }
        return newText.isEmpty ? true : false
    }
    
    @objc private func clearButtonTapped() {
        text = String()
        textDidChange()
        clearDelegate?.clearTextField(self)
    }
    
    @objc private func textDidChange() {
        guard let safeText = text else { return }
        if safeText.isEmpty {
            rightView?.isHidden = true
        } else {
            rightView?.isHidden = false
        }
    }
}

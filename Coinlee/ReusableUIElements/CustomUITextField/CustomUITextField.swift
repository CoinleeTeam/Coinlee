//
//  CustomUITextField.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/10/2023.
//

import UIKit

final class CustomUITextField: UITextField {
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
    
    // MARK: - Overwritten methods
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
    
    func addLeftIcon(icon: UIImage) {
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
    
    func addCurrencyLabel(currencyCode: String) {
        textPadding.right = 48
        
        let currencyLabel = UILabel()
        currencyLabel.text = "| \(currencyCode)"
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

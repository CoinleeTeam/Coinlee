//
//  CustomUITextField.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/10/2023.
//

import UIKit

final class CustomUITextField: UITextField {
    private var viewPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private var textPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    var clearDelegate: ClearTextFieldDelegate?
    var maximumNumberOfSymbols = 0
    
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
        font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        textColor = .charcoal
        attributedPlaceholder = customizedPlaceholder()
    }
    
    private func customizedPlaceholder() -> NSMutableAttributedString {
        var attributedPlaceholder = NSMutableAttributedString()
        attributedPlaceholder = NSMutableAttributedString(
            string: "Placeholder",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.battleshipGrey,
                NSAttributedString.Key.font: UIFont(name: Fonts.Inter.medium.rawValue, size: 16) as Any
            ]
        )
        
        return attributedPlaceholder
    }
    
    func addLeftIcon(leftIcon: UIImage) {
        textPadding.left = 48
        
        let leftIcon = UIImageView(image: leftIcon)
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
    
    // MARK: - Textfield's clear button UI and logic
    private func addTapGestureRecognizer(to view: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clearButtonTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
        view.isUserInteractionEnabled = true
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

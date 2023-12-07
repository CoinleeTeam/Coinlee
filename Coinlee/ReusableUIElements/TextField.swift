//
//  CustomUITextField.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/10/2023.
//

import UIKit
import RxCocoa
import RxSwift

final class TextField: UITextField {
    private let viewPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private var textPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    var maximumNumberOfSymbols = 0
    
    var currencyLabel: UILabel?
    var clearIconImageView: UIImageView?
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    private let disposeBag = DisposeBag()
    
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
        textPadding.left = 48
        
        let leftIcon = UIImageView(image: icon)
        leftIcon.tintColor = .goldenrod
        leftViewMode = .always
        leftView = leftIcon
    }
    
    func addClearIcon() {
        let clearIconImageView = UIImageView(image: UIImage(named: LinearIcon.clear.rawValue))
        self.clearIconImageView = clearIconImageView
        textPadding.right = 48
        
        clearIconImageView.tintColor = .goldenrod
        rightViewMode = .always
        rightView = clearIconImageView
        
        rightView?.isHidden = true
        setUpTapGestureRecognizer(for: clearIconImageView)
        subscribeToTextChange()
    }
    
    func addCurrencyLabelToRightView(currency: Currency) {
        let currencyLabel = UILabel()
        self.currencyLabel = currencyLabel
        textPadding.right = 48
        
        currencyLabel.text = CharacterConstants.verticalBar + CharacterConstants.whitespace + currency.code
        currencyLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        currencyLabel.textColor = .battleshipGrey
        
        rightViewMode = .always
        rightView = currencyLabel
    }
    
    private func setUpTapGestureRecognizer(for view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer()
        self.tapGestureRecognizer = tapGestureRecognizer
        view.addGestureRecognizer(tapGestureRecognizer)
        view.isUserInteractionEnabled = true
        subscribeToClearButtonTap()
    }
    
    // MARK: Subscriptions
    private func subscribeToClearButtonTap() {
        tapGestureRecognizer?.rx.event
            .subscribe { _ in
                self.text = String()
                self.toggleRightViewIsHidden()
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToTextChange() {
        rx.text
            .orEmpty
            .changed
            .subscribe(onNext: { _ in
                self.toggleRightViewIsHidden()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Utility Methods
    private func toggleRightViewIsHidden() {
        let text = text ?? String()
        if text.isEmpty {
            rightView?.isHidden = true
        } else {
            rightView?.isHidden = false
        }
    }
    
    func applyAccountingNumberFormat(oldText: String, newText: String) -> String {
        let formatter = AccountingNumberFormatter()
        let newTextWithoutGroupingSeparators = newText.replacingOccurrences(of: formatter.groupingSeparator, with: String())
        guard let newTextLast = newText.last else { return newText }
        
        if !oldText.isEmpty &&
            String(newTextLast) == formatter.decimalSeparator &&
            newText.components(separatedBy: formatter.decimalSeparator).count < 3 &&
            oldText.components(separatedBy: formatter.decimalSeparator).count < 2 {
            return newText
        }
        
        if let numberWithoutGroupingSeparator = formatter.number(from: newTextWithoutGroupingSeparators),
           let formattedText = formatter.string(from: numberWithoutGroupingSeparator), formattedText.count <= 19 {
            if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.exactZero(separator: formatter.decimalSeparator)) {
                return formattedText + formatter.decimalSeparator + String(0)
                
            } else if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.twoOrThreeZeros(separator: formatter.decimalSeparator)) {
                return formattedText + formatter.decimalSeparator + String(0) + String(0)
                
            } else if newTextWithoutGroupingSeparators.isValidWith(regex: RegexPattern.zeroAtEnd(separator: formatter.decimalSeparator)) {
                return formattedText + String(0)
                
            } else  {
                return formattedText
            }
        }
        return newText.isEmpty ? newText : oldText
    }
}

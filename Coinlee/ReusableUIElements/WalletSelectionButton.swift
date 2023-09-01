//
//  WalletSelectionButton.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 27/08/2023.
//

import UIKit

class WalletSelectionButton: UIButton {
    let rightImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
        setUpRightImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConfiguration() {
        super.updateConfiguration()
        guard let configuration = configuration else { return }
        
        if state == .highlighted {
            let highlitedAlpha = 0.3
            var newConfiguration = configuration
            
            newConfiguration.attributedTitle?.foregroundColor = .white.withAlphaComponent(highlitedAlpha)
            newConfiguration.image = newConfiguration.image?.withAlpha(highlitedAlpha)
            rightImageView.alpha = highlitedAlpha
            self.configuration = newConfiguration
            
        } else if state == .normal {
            UIView.animate(withDuration: 0.25) {
                self.rightImageView.alpha = 1
            }
            setConfigurationWithAnimation(configuration)
        }
    }
    
    
    private func setUpButton() {
        titleLabel?.font = UIFont(name: Fonts.Inter.semiBold.rawValue, size: 15)
        setTitleColor(.white, for: .normal)
        contentHorizontalAlignment = .left
        
        configuration = defaultConfiguration()
    }
    
    private func setUpRightImageView() {
        addSubview(rightImageView)
        rightImageView.image = UIImage(named: Icons.Linear.angleRight.rawValue)
        rightImageView.tintColor = .white
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(snp.trailing).offset(-24)
        }
    }
    
    private func defaultConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incomingContainer in
            var outgoingContainer = incomingContainer
            outgoingContainer.font = UIFont(name: Fonts.Inter.semiBold.rawValue, size: 15)
            return outgoingContainer
        }
        configuration.imagePadding = 6
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 28)
        configuration.baseForegroundColor = .white
        return configuration
    }
}

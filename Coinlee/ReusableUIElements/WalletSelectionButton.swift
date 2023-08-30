//
//  WalletSelectionButton.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 27/08/2023.
//

import UIKit

class WalletSelectionButton: UIButton {
    let rightImageView = UIImageView()
    
    convenience init() {
        self.init(type: .system)
        setUpButton()
        setUpRightImageView()
        addConstraints()
        
        subviews.compactMap({ $0 as? UIButton }).forEach {
            $0.configurationUpdateHandler = { button in
                guard let config = button.configuration else { return }
                button.setConfiguration(config, duration: 2)
            }
        }
    }
    
    private func setUpButton() {
        titleLabel?.font = UIFont(name: Fonts.Inter.semiBold.rawValue, size: 15)
        setTitleColor(.white, for: .normal)
        contentHorizontalAlignment = .left
        
        
        configuration = .plain()
        addAction(actionLOL(), for: .touchUpInside)
    }
    
    private func setUpRightImageView() {
        titleLabel!.addSubview(rightImageView)
        rightImageView.image = UIImage(named: Icons.Linear.expandAngle.rawValue)
        rightImageView.tintColor = .white
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel!.snp.trailing).offset(4)
        }
    }
    
    // MARK: Constraints
    private func addConstraints() {
//        snp.makeConstraints { make in
//            make.width.equalTo(112)
//        }
        
        imageView?.snp.makeConstraints({ make in
            make.height.width.equalTo(40)
        })
    }
    
    func actionLOL() -> UIAction {
        return UIAction { action in
            if var config = self.configuration {
                config.background.backgroundColor = .red
                config.baseForegroundColor = .white
                self.configuration = config
            }
        }
    }
}


extension UIButton {
    func setConfiguration(_ configuration: UIButton.Configuration, duration: Double = 0.25, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.configuration? = configuration
        } completion: { completion?($0) }
    }
}

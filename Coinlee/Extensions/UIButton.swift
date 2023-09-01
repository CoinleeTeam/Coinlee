//
//  UIButton.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 01/09/2023.
//

import UIKit

extension UIButton {
    func setConfigurationWithAnimation(_ configuration: UIButton.Configuration,
                          duration: Double = 0.25,
                          completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve) {
            self.configuration? = configuration
        } completion: { completion?($0) }
    }
}

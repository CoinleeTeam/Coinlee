//
//  UIView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 29/10/2023.
//

import UIKit

extension UIView {
    /// Wraps a view inside a white rounded container with a bottom shadow.
    func createBasicContainerWithBottomShadow(viewBackgroundColor: UIColor = .white) {
        backgroundColor = viewBackgroundColor
        layer.cornerRadius = 15
        
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 5), transform: nil)
    }
    
    /// Wraps a view inside a white rounded container with a round shadow.
    func createBasicContainerWithRoundShadow(viewBackgroundColor: UIColor = .white) {
        backgroundColor = viewBackgroundColor
        layer.cornerRadius = 15
        
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 10), transform: nil)
    }
    
}

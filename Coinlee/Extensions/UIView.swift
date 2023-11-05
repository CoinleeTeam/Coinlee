//
//  UIView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 29/10/2023.
//

import UIKit

extension UIView {
    enum ShadowType {
        case bottom, rounded
        case none
    }
    
    var shadowType: ShadowType {
        get {
            switch layer.shadowRadius {
            case 5: return .bottom
            case 10: return .rounded
            default: return .none
            }
        }
        set(shadowType) {
            switch shadowType {
            case .bottom: layer.shadowRadius = 5
            case .rounded: layer.shadowRadius = 10
            case .none:
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowPath = nil
            }
        }
    }
    
    /// Wraps a view inside a white rounded container with a bottom shadow.
    func createBasicContainerWithBottomShadow() {
        layer.cornerRadius = 15
        
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 5), transform: nil)
    }
    
    /// Wraps a view inside a white rounded container with a round shadow.
    func createBasicContainerWithRoundShadow() {
        layer.cornerRadius = 15
        
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 10), transform: nil)
    }
    
}

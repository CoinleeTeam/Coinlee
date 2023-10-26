//
//  BasicContainer.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/10/2023.
//

import UIKit

final class BasicContainerView: UIView {

    enum ShadowType {
        case bottom
        case rounded
    }
    
    var shadowType: ShadowType = .bottom {
        didSet {
            addLayer()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            addLayer()
        }
    }
    
    private func addLayer() {
        backgroundColor = .white
        layer.cornerRadius = 15
        
        switch shadowType {
        case .bottom:
            layer.shadowRadius = 5
            layer.shadowOpacity = 0.2
            layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 5), transform: nil)
        case .rounded:
            layer.shadowRadius = 10
            layer.shadowOpacity = 0.2
            layer.shadowPath = CGPath(rect: CGRect(x: -4, y: 2, width: frame.width + 8, height: frame.height + 6), transform: nil)
        }
    }
}

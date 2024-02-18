//
//  BottomCornerRoundedView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import UIKit

final class BottomCornerRoundedView: UIView {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Path drawing
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        let cornerRadius: CGFloat = 40.0
        
        // Move to the starting point at the top-left corner
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        
        // Add a line to the top-right corner
        bezierPath.addLine(to: CGPoint(x: rect.width, y: 0))
        
        // Add a line to the bottom-right corner, excluding the rounded part
        bezierPath.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
        
        // Add an arc for the bottom-right corner (rounded)
        bezierPath.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: 0,
                    endAngle: CGFloat(Double.pi / 2),
                    clockwise: true)
        
        // Add a line to the bottom-left corner, excluding the rounded part
        bezierPath.addLine(to: CGPoint(x: cornerRadius, y: rect.height))
        
        // Add an arc for the bottom-left corner (rounded)
        bezierPath.addArc(withCenter: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat(Double.pi / 2),
                    endAngle: CGFloat(Double.pi),
                    clockwise: true)
        
        // Close the path by adding a line to the top-left corner
        bezierPath.close()
        
        // Path fill
        UIColor.charcoal.setFill()
        bezierPath.fill()
    }
}

//
//  CornerRoundedCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 19/08/2023.
//

import UIKit

class CornerRoundedCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            contentView.layer.backgroundColor = isSelected ? UIColor.silverChalice.cgColor : UIColor.white.cgColor
        }
    }
    
    override var bounds: CGRect {
        didSet {
            setUpLayerForContentView()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.backgroundColor = UIColor.white.cgColor
        backgroundColor = .paleFrost
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layers' setup
    private func setUpLayerForContentView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 5), transform: nil)
    }
}

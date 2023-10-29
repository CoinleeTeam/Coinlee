//
//  BorderFreeCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import UIKit
import SnapKit

final class BorderFreeCell: UICollectionViewCell {
    static let reuseIdentifier = "BorderFreeCell"
    
    let titleLabel = UILabel()
    let selectionMarkImageView = UIImageView()
    let bottomLineLayer = CALayer()
    
    var viewModel: BorderFreeCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = NSLocalizedString(viewModel.title, comment: String())
            selectionMarkImageView.isHidden = !viewModel.isSelected
        }
    }
        
    override var bounds: CGRect {
        didSet {
            bottomLineLayer.frame = CGRect(x: 0, y: 28, width: bounds.width, height: 1)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Subviews' setup
    private func setUp() {
        // titleLabel
        addSubview(titleLabel)
        titleLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        titleLabel.textColor = .charcoal
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        // selectionMarkImageView
        addSubview(selectionMarkImageView)
        selectionMarkImageView.image = UIImage(named: Icon.Linear.checkMark.rawValue)
        selectionMarkImageView.contentMode = .scaleAspectFit
        selectionMarkImageView.tintColor = .goldenrod
        selectionMarkImageView.isHidden = true
        
        // bottomLineLayer
        layer.addSublayer(bottomLineLayer)
        bottomLineLayer.backgroundColor = UIColor.silverChalice.cgColor
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(2)
        }
        
        selectionMarkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
        }
    }
}

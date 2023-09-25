//
//  CornerRoundedCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 19/08/2023.
//

import UIKit

class CornerRoundedCell: UICollectionViewCell {
    let vStack = UIStackView()
    let hStack = UIStackView()
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.backgroundColor = UIColor.white.cgColor
        iconImageView.contentMode = .scaleAspectFit
        setUpCell()
        setUpStackViews()
        setUpTitleLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Cell setup
    private func setUpCell() {
        backgroundColor = .paleFrost
    }
    
    // MARK: Layers' setup
    private func setUpLayerForContentView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: frame.width - 10, height: frame.height - 5), transform: nil)
    }
    
    // MARK: Subviews' setup
    private func setUpStackViews() {
        // vStack
        vStack.addArrangedSubview(titleLabel)
        vStack.axis = .vertical
        vStack.spacing = 1
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        
        // hStack
        contentView.addSubview(hStack)
        hStack.addArrangedSubview(iconImageView)
        hStack.addArrangedSubview(vStack)
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.distribution = .fill
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        titleLabel.textColor = .charcoal
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.trailing.equalToSuperview()
            make.width.equalTo(frame.width)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(55)
        }
        
        hStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}

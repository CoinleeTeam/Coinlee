//
//  IconTitleCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import UIKit
import SnapKit

class IconTitleCell: CornerRoundedCell {
    let vStack = UIStackView()
    let hStack = UIStackView()
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView.contentMode = .scaleAspectFit
        setUpStackViews()
        setUpTitleLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
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

//
//  TransactionCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import UIKit
import SnapKit

final class TransactionCell: IconTitleCell {
    static let reuseIdentifier = "TransactionCell"
    
    let desctiptionLabel = UILabel()
    let sumLabel = UILabel()
    
    var viewModel: TransactionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.transaction.category.title
            iconImageView.image = UIImage(named: viewModel.transaction.category.iconName)
            desctiptionLabel.text = viewModel.transaction.description
            sumLabel.text = viewModel.balanceText
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabels()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpLabels() {
        // desctiptionLabel
        desctiptionLabel.font = UIFont(name: Fonts.Inter.regular.rawValue, size: 12)
        desctiptionLabel.textAlignment = .left
        desctiptionLabel.numberOfLines = 1
        desctiptionLabel.textColor = .battleshipGrey
        vStack.addArrangedSubview(desctiptionLabel)
        
        // sumLabel
        sumLabel.font = UIFont(name: Fonts.Inter.regular.rawValue, size: 16)
        sumLabel.textAlignment = .right
        sumLabel.numberOfLines = 1
        sumLabel.textColor = .charcoal
        contentView.addSubview(sumLabel)
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        sumLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
        }
    }
}

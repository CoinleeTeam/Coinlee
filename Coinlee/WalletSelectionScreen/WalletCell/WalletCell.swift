//
//  WalletCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit

final class WalletCell: IconTitleCell {
    static let reuseIdentifier = "WalletCell"
    
    let selectionMarkImageView = UIImageView()
    let balanceLabel = UILabel()
    
    var viewModel: WalletCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.wallet.name
            balanceLabel.text = viewModel.balanceText
            iconImageView.image = UIImage(named: viewModel.wallet.icon.rawValue)
            selectionMarkImageView.isHidden = !viewModel.wallet.isActive
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSelectionMarkImageView()
        setUpBalanceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpSelectionMarkImageView() {
        hStack.addArrangedSubview(selectionMarkImageView)
        selectionMarkImageView.image = UIImage(named: LinearIcon.checkMark.rawValue)
        selectionMarkImageView.contentMode = .scaleAspectFit
        selectionMarkImageView.tintColor = .goldenrod
    }
    
    private func setUpBalanceLabel() {
        vStack.addArrangedSubview(balanceLabel)
        balanceLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 15)
        balanceLabel.textColor = .dimGrey
        balanceLabel.textAlignment = .left
        balanceLabel.numberOfLines = 0
    }
}

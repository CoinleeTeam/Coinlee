//
//  WalletCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit

final class WalletCell: CornerRoundedCell {
    static let reuseIdentifier = "WalletCell"
    
    let selectionMarkImageView = UIImageView()
    let balanceLabel = UILabel()
    
    override var viewModel: CornerRoundedCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel as? WalletCellViewModelType else { return }
            balanceLabel.text = viewModel.formattedBalance()
            selectionMarkImageView.isHidden = !viewModel.wallet.isActive
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setUpSelectionMarkImageView()
        setUpBalanceLabel()
    }
    
    // MARK: Subviews setup
    private func setUpSelectionMarkImageView() {
        hStack.addArrangedSubview(selectionMarkImageView)
        selectionMarkImageView.image = UIImage(named: Icons.Linear.checkMark.rawValue)
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

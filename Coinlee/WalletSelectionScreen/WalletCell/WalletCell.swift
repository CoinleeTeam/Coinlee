//
//  WalletCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit
import RxSwift

final class WalletCell: IconTitleCell {
    static let reuseIdentifier = "WalletCell"
    
    let selectionMarkImageView = UIImageView()
    let balanceLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: WalletCellViewModelType? {
        didSet {
            subscribeToWallet()
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
    
    // MARK: - Subscriptions
    private func subscribeToWallet() {
        viewModel?.wallet
            .subscribe(onNext: { wallet in
                self.titleLabel.text = wallet.name
                self.balanceLabel.text = self.viewModel?.balanceText(forWallet: wallet)
                self.iconImageView.image = UIImage(named: wallet.icon.rawValue)
                self.selectionMarkImageView.isHidden = !wallet.isActive
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Subviews' setup
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

//
//  WalletCellHeaderView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import UIKit
import SnapKit

final class WalletCellHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "WalletCellHeaderView"
    
    let walletTypeLabel = UILabel()
    var viewModel: WalletCellHeaderViewViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            walletTypeLabel.text = viewModel.walletType.rawValue
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpWalletTypeLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Subviews setup
    private func setUpWalletTypeLabel() {
        addSubview(walletTypeLabel)
        walletTypeLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        walletTypeLabel.numberOfLines = 1
        walletTypeLabel.textColor = .charcoal
        walletTypeLabel.textAlignment = .left
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        walletTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(8)
        }
    }
}

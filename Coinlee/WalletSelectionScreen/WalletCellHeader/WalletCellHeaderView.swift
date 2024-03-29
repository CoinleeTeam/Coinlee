//
//  WalletCellHeaderView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 16/08/2023.
//

import UIKit
import SnapKit
import RxSwift

final class WalletCellHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "WalletCellHeaderView"
    
    let walletTypeLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: WalletCellHeaderViewModelType? {
        didSet {
            subscribeToWalletType()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
            setUpWalletTypeLabel()
            addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subscriptions
    private func subscribeToWalletType() {
        viewModel?.walletType
            .subscribe(onNext: { walletType in
                self.walletTypeLabel.text = walletType.localizedTitle
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Subviews' setup
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
            make.bottom.top.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
}

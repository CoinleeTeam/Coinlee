//
//  WalletSelectionView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit
import SnapKit

final class WalletSelectionView: UIView {
    let walletsTableView = UITableView(frame: .zero, style: .grouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        setUpWalletsTableView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignWalletsTableViewDelegates<T>(to delegate: T) where T: UITableViewDataSource & UITableViewDelegate {
        walletsTableView.dataSource = delegate
        walletsTableView.delegate = delegate
    }
    
    // MARK: Subviews setup
    private func setUpWalletsTableView() {
        addSubview(walletsTableView)
        walletsTableView.backgroundColor = .paleFrost
        walletsTableView.separatorStyle = .none
        walletsTableView.sectionHeaderTopPadding = 4
        walletsTableView.showsVerticalScrollIndicator = false
        walletsTableView.register(WalletCellHeaderView.self, forHeaderFooterViewReuseIdentifier: WalletCellHeaderView.reuseIdentifier)
        walletsTableView.register(WalletCell.self, forCellReuseIdentifier: WalletCell.reuseIdentifier)
        
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        walletsTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

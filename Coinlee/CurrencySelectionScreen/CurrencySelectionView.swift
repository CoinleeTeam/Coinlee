//
//  CurrencySelectionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit
import SnapKit

class CurrencySelectionView: UIView {
    let currenciesTableView = UITableView(frame: CGRect(), style: .insetGrouped)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCurrenciesTableView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignCurrenciesTableViewDelegates<T>(to delegate: T) where T: UITableViewDataSource & UITableViewDelegate {
        currenciesTableView.dataSource = delegate
        currenciesTableView.delegate = delegate
    }
    
    private func setUpCurrenciesTableView() {
        backgroundColor = .paleFrost
        currenciesTableView.showsVerticalScrollIndicator = false
        currenciesTableView.backgroundColor = .paleFrost
        currenciesTableView.separatorStyle = .none
        currenciesTableView.rowHeight = 60
        currenciesTableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
    }
    
    private func addConstraints() {
        addSubview(currenciesTableView)
        currenciesTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(8)
        }
    }

    
}

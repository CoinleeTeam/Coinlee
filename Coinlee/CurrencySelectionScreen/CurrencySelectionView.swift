//
//  CurrencySelectionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit
import SnapKit

class CurrencySelectionView: UIView {
    let searchTextField = UISearchTextField()
    let currenciesTableView = UITableView(frame: CGRect(), style: .insetGrouped)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCurrenciesTableView()
        addConstraints()
        setUpSearchTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignCurrenciesTableViewDelegates<T>(to delegate: T) where T: UITableViewDataSource & UITableViewDelegate {
        currenciesTableView.dataSource = delegate
        currenciesTableView.delegate = delegate
    }
    
    func assignSearchTextFieldDelegate<T>(to delegate: T) where T: UITextFieldDelegate {
        searchTextField.delegate = delegate
    }
    
    private func setUpCurrenciesTableView() {
        backgroundColor = .paleFrost
        currenciesTableView.showsVerticalScrollIndicator = false
        currenciesTableView.backgroundColor = .paleFrost
        currenciesTableView.separatorStyle = .none
        currenciesTableView.rowHeight = 60
        currenciesTableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
    }
    
    private func setUpSearchTextField() {
        searchTextField.backgroundColor = .paleFrost
        searchTextField.layer.borderColor = UIColor.paleFrost.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.placeholder = NSLocalizedString("Search", comment: "")
        searchTextField.clearButtonMode = .whileEditing
    }
    
    private func addConstraints() {
        addSubview(currenciesTableView)
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        currenciesTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(-32)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(8)
        }
    }
}

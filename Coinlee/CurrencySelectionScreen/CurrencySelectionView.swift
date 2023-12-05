//
//  CurrencySelectionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit
import SnapKit

final class CurrencySelectionView: UIView {
    let searchTextField = TextField()
    let currenciesTableView = UITableView(frame: CGRect(), style: .insetGrouped)
    let noResultsView = NoResultsView()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCurrenciesTableView()
        addConstraints()
        setUpSearchTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates
    func assignCurrenciesTableViewDelegates<T>(to delegate: T) where T: UITableViewDataSource & UITableViewDelegate {
        currenciesTableView.dataSource = delegate
        currenciesTableView.delegate = delegate
    }
    
    func assignSearchTextFieldDelegates<T>(to delegate: T) where T: UITextFieldDelegate & ClearTextFieldDelegate {
        searchTextField.delegate = delegate
        searchTextField.clearDelegate = delegate
    }
    
    // MARK: - Subviews' setup
    private func setUpCurrenciesTableView() {
        backgroundColor = .paleFrost
        currenciesTableView.showsVerticalScrollIndicator = false
        currenciesTableView.backgroundColor = .paleFrost
        currenciesTableView.separatorStyle = .none
        currenciesTableView.rowHeight = 60
        currenciesTableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
    }
    
    private func setUpSearchTextField() {
        searchTextField.layer.borderColor = UIColor.paleFrost.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.shadowType = .rounded
        searchTextField.backgroundColor = .snowWhite
        searchTextField.placeholder = NSLocalizedString("search_placeholder", comment: "")
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.maximumNumberOfSymbols = 10
        searchTextField.autocorrectionType = .no
        
        searchTextField.addLeftIcon(icon: UIImage(named: LinearIcon.magnifyingGlass.rawValue) ?? UIImage())
        searchTextField.addClearIcon()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        addSubview(currenciesTableView)
        addSubview(noResultsView)
        addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(46)
        }
        
        currenciesTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(-32)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(8)
        }
        
        noResultsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(searchTextField.snp.bottom).offset(120)
        }
    }
}

//
//  CurrencySelectionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit
import SnapKit

final class CurrencySelectionView: UIView {
    let containerView = BasicContainerView()
    let searchTextField = CustomUITextField()
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
        containerView.shadowType = .rounded
        containerView.backgroundColor = .snowWhite
        
        searchTextField.layer.borderColor = UIColor.paleFrost.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.placeholder = NSLocalizedString("search_placeholder", comment: "")
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.maximumNumberOfSymbols = 10
        
        searchTextField.addLeftIcon(leftIcon: UIImage(named: Icons.LinearIcons.magnifier.rawValue) ?? UIImage())
        searchTextField.addClearIcon()
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        containerView.addSubview(searchTextField)
        addSubview(currenciesTableView)
        addSubview(noResultsView)
        addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(46)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        currenciesTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom).offset(-32)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(8)
        }
        
        noResultsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(searchTextField.snp.bottom).offset(120)
        }
    }
}

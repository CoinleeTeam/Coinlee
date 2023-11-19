//
//  CategorySelectionView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 16/08/2023.
//

import UIKit

final class CategorySelectionView: UIView {
    let categoriesTableView = UITableView(frame: CGRect(), style: .insetGrouped)

    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCategoriesTableView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate
    func assignCategoriesTableViewDelegates<T>(to delegate: T) where T: UITableViewDataSource & UITableViewDelegate {
        categoriesTableView.dataSource = delegate
        categoriesTableView.delegate = delegate
    }
    
    // MARK: Subview setup
    private func setUpCategoriesTableView() {
        backgroundColor = .paleFrost
        categoriesTableView.showsVerticalScrollIndicator = false
        categoriesTableView.backgroundColor = .paleFrost
        categoriesTableView.separatorStyle = .none
        categoriesTableView.rowHeight = 55
        categoriesTableView.sectionHeaderHeight = 70
        categoriesTableView.sectionHeaderTopPadding = -10
        categoriesTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        categoriesTableView.register(CategoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CategoryTableViewHeader.reuseIdentifier)
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        addSubview(categoriesTableView)
        categoriesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

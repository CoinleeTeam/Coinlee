//
//  CategorySelectionViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import UIKit
import SnapKit

final class CategorySelectionViewController: UIViewController {
    var viewModel: CategoryTableViewViewModelType
    let categorySelectionView = CategorySelectionView()
    
    // MARK: - Inits
    init(viewModel: CategoryTableViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController's lifecycle
    override func loadView() {
        super.loadView()
        view = categorySelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categorySelectionView.assignCategoriesTableViewDelegates(to: self)
    }
    
    // MARK: - Methods
    @objc private func headerTapped(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view else { return }
        viewModel.toggleSectionCollapse(forSection: section.tag)
        if viewModel.collapsedSections.contains(section.tag) {
            (section.superview as? CategoryTableViewHeader)?.isExpanded = false
            categorySelectionView.categoriesTableView.deleteRows(at: viewModel.indexPaths(atSection: section.tag), with: .fade)
        } else {
            (section.superview as? CategoryTableViewHeader)?.isExpanded = true
            categorySelectionView.categoriesTableView.insertRows(at: viewModel.indexPaths(atSection: section.tag), with: .fade)
            categorySelectionView.categoriesTableView.reloadRows(at: viewModel.indexPaths(atSection: section.tag), with: .fade)
        }
        
    }
}

// MARK: - UITableViewDataSource
extension CategorySelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.collapsedSections.contains(section) {
            return 0
        } else {
            return viewModel.numberOfRows(forSection: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = categorySelectionView.categoriesTableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = categorySelectionView.categoriesTableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryTableViewHeader.reuseIdentifier) as? CategoryTableViewHeader else { return nil }
                
        headerView.viewModel = viewModel.headerViewModel(forSection: section)
        
        headerView.tapGestureRecognizer.addTarget(self, action: #selector(headerTapped(_:)))
        headerView.headerContentView.tag = section
        
        if viewModel.categoriesTransactionType == .income {
            headerView.isExpanded = true
        }
        
        return headerView
    }
}

// MARK: - UITableViewDelegate
extension CategorySelectionViewController: UITableViewDelegate {
}




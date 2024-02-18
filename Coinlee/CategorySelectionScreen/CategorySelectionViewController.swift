//
//  CategorySelectionViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/08/2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CategorySelectionViewController: UIViewController {
    var viewModel: CategorySelectionViewModelType
    let categorySelectionView = CategorySelectionView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Inits
    init(viewModel: CategorySelectionViewModelType) {
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
    
    // MARK: - Subscriptions
    private func subscribeToHeaderTapped(header: CategoryGroupHeader) {
        header.tapGestureRecognizer.rx
            .event
            .subscribe { _ in
                self.viewModel.toggleSectionCollapse(forSection: (header.tag))
                if self.viewModel.collapsedSections.contains(header.tag) {
                    header.isExpanded.accept(false)
                    let indexPaths = self.viewModel.indexPaths(atSection: header.tag)
                    self.categorySelectionView.categoriesTableView.deleteRows(at: indexPaths, with: .fade)
                } else {
                    header.isExpanded.accept(true)
                    let indexPaths = self.viewModel.indexPaths(atSection: header.tag)
                    self.categorySelectionView.categoriesTableView.insertRows(at: indexPaths, with: .fade)
                }
            }
            .disposed(by: disposeBag)
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
        let cell = categorySelectionView.categoriesTableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath)
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        (cell as? CategoryCell)?.viewModel = cellViewModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategorySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = categorySelectionView.categoriesTableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryGroupHeader.reuseIdentifier) as? CategoryGroupHeader else { return nil }
        header.viewModel = viewModel.headerViewModel(forSection: section)
        header.tag = section
        subscribeToHeaderTapped(header: header)
        
        if viewModel.transactionType == .income {
            header.isExpanded.accept(true)
        }
        
        return header
    }
}

//
//  TransactionsViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import UIKit

final class TransactionsViewController: UIViewController {
    let viewModel: TransactionsViewModelType
    let transactionsView = TransactionsView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    init(viewModel: TransactionsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        view = transactionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionsView.assignTransactionsCollectionViewDelegates(to: self)
    }
}

// MARK: - CollectionViewDataSource
extension TransactionsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.numberOfTransactions(inSection: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = transactionsView.transactionsCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TransactionCellHeaderView.reuseIdentifier, for: indexPath) as? TransactionCellHeaderView else { return UICollectionReusableView() }
            headerView.viewModel = viewModel.transactionCellHeaderViewViewModel(forSection: indexPath.section)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = transactionsView.transactionsCollectionView.dequeueReusableCell(withReuseIdentifier: IncomeExpenseStaticCell.reuseIdentifier, for: indexPath) as? IncomeExpenseStaticCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.incomeExpenseStaticCellViewModel()
            return cell
        } else {
            guard let cell = transactionsView.transactionsCollectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.reuseIdentifier, for: indexPath) as? TransactionCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.transactionCellViewModel(at: indexPath)
            return cell
        }
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension TransactionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        } else {
            return CGSize(width: collectionView.frame.width, height: 43)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width - 32, height: 50)
        } else {
            return CGSize(width: view.frame.width - 32, height: 63)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 16, left: 0, bottom: 20, right: 0)
        } else {
            return UIEdgeInsets(top: 12, left: 0, bottom: 20, right: 0)
        }
    }
}

// MARK: - CollectionViewDelegate
extension TransactionsViewController: UICollectionViewDelegate {
}

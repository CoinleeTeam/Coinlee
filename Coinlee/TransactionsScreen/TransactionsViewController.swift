//
//  TransactionsViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class TransactionsViewController: UIViewController {
    let viewModel: TransactionsViewModelType
    let transactionsView = TransactionsView()
    
    private let disposeBag = DisposeBag()
    
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
        transactionsView.transactionsCollectionView.delegate = self
        subscribeToBalanceAmount()
        bindTransactionsToCollectionView()
    }
    
    // MARK: - Subscriptions
    private func subscribeToBalanceAmount() {
        viewModel.balanceText
            .bind(to: transactionsView.balanceAmountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindTransactionsToCollectionView() {
        viewModel.transactions
            .bind(to: transactionsView.transactionsCollectionView.rx.items(dataSource: collectionViewDataSource()))
            .disposed(by: disposeBag)
        
    }
}

// MARK: - CollectionViewDataSource
extension TransactionsViewController {
    private func collectionViewDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionOfTransactions> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfTransactions>(configureCell: { dataSource, collectionView, indexPath, item in
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncomeExpenseStaticCell.reuseIdentifier, for: indexPath)
                (cell as? IncomeExpenseStaticCell)?.viewModel = self.viewModel.incomeExpenseStaticCellViewModel()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.reuseIdentifier, for: indexPath)
                (cell as? TransactionCell)?.viewModel = self.viewModel.transactionCellViewModel(at: indexPath)
                return cell
            }
        },
        configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TransactionCellHeaderView.reuseIdentifier, for: indexPath)
            (headerView as? TransactionCellHeaderView)?.viewModel = self.viewModel.transactionCellHeaderViewViewModel(forSection: indexPath.section)
            return headerView
        })
        return dataSource
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

//
//  WalletSelectionViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class WalletSelectionViewController: UIViewController {
    let viewModel: WalletSelectionViewModelType
    let walletSelectionView = WalletSelectionView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: WalletSelectionViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        view = walletSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindWalletsToCollectionView()
    }
    
    // MARK: - Subscriptions
    private func bindWalletsToCollectionView() {
        viewModel.wallets
            .bind(to: walletSelectionView.walletsCollectionView.rx.items(dataSource: collectionViewDataSource()))
            .disposed(by: disposeBag)
        
    }
}

// MARK: - UICollectionViewDataSource
extension WalletSelectionViewController {
    private func collectionViewDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionOfWallets> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfWallets>(configureCell: { _, collectionView, indexPath, wallet in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalletCell.reuseIdentifier, for: indexPath)
                (cell as? WalletCell)?.viewModel = self.viewModel.walletCellViewModel(wallet: wallet)
                return cell
        },
        configureSupplementaryView: { _, collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WalletCellHeaderView.reuseIdentifier, for: indexPath)
            (headerView as? WalletCellHeaderView)?.viewModel = self.viewModel.walletCellHeaderViewViewModel(forSection: indexPath.section)
            return headerView
        })
        return dataSource
    }
}

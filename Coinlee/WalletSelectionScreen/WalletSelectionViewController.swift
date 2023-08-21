//
//  WalletSelectionViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit

final class WalletSelectionViewController: UIViewController {
    let viewModel: WalletSelectionViewViewModelType
    let walletSelectionView = WalletSelectionView()
    
    init(viewModel: WalletSelectionViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = walletSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletSelectionView.assignWalletsCollectionViewDelegates(to: self)
    }
}

// MARK: UICollectionViewDataSource
extension WalletSelectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfWallets(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WalletCellHeaderView.reuseIdentifier, for: indexPath) as? WalletCellHeaderView else { return UICollectionReusableView() }
        headerView.viewModel = viewModel.walletCellHeaderViewViewModel(forSection: indexPath.section)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalletCell.reuseIdentifier, for: indexPath) as? WalletCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.walletCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: UITableViewDelegate
extension WalletSelectionViewController: UICollectionViewDelegate {
}

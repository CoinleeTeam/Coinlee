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
        walletSelectionView.assignWalletsTableViewDelegates(to: self)
    }
}

// MARK: UICollectionViewDataSource
extension WalletSelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfWallets(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WalletCellHeaderView.reuseIdentifier) as? WalletCellHeaderView else { return nil }
        headerView.viewModel = viewModel.walletCellHeaderViewViewModel(forSection: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WalletCell.reuseIdentifier, for: indexPath) as? WalletCell else { return UITableViewCell() }
        cell.viewModel = viewModel.walletCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: UITableViewDelegate
extension WalletSelectionViewController: UITableViewDelegate {
}

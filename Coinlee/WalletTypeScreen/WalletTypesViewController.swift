//
//  WalletTypesViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import UIKit

final class WalletTypesViewController: UIViewController {
    let walletTypesView = WalletTypesView()
    let viewModel: WalletTypesViewViewModelType
    
    // MARK: - Init
    init(viewModel: WalletTypesViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        view = walletTypesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTypesView.assignWalletTypesCollectionViewDelegates(to: self)
    }
}

// MARK: - UICollectionViewDataSource
extension WalletTypesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BorderFreeCell.reuseIdentifier, for: indexPath) as? BorderFreeCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.walletTypeCellViewModel(forIndexPath: indexPath)
        return cell
    }
}

// MARK: UITableViewDelegate
extension WalletTypesViewController: UICollectionViewDelegate {
}

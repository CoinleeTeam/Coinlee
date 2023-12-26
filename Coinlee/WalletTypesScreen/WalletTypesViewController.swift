//
//  WalletTypesViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class WalletTypesViewController: UIViewController {
    let walletTypesView = WalletTypesView()
    let viewModel: WalletTypesViewModelType
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: WalletTypesViewModelType) {
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
        bindWalletTypesToWalletTypesCollectionView()
    }
}

// MARK: - UICollectionViewDataSource
extension WalletTypesViewController {
    private func bindWalletTypesToWalletTypesCollectionView() {
        viewModel.walletTypes.bind(to: walletTypesView.walletTypesCollectionView.rx.items(cellIdentifier: BorderFreeCell.reuseIdentifier,
                                                                                          cellType: BorderFreeCell.self)) { row, walletType, cell in
            cell.viewModel = self.viewModel.walletTypeCellViewModel(withWalletType: walletType, atIndexPath: IndexPath(row: row, section: 0))
        }
        .disposed(by: disposeBag)
    }
}

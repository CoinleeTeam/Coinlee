//
//  TransactionsViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import UIKit

final class TransactionsViewController: UIViewController {
    let viewModel: TransactionsViewViewModelType
    let transactionsView = TransactionsView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: TransactionsViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = transactionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionsView.assignTransactionsCollectionViewDelegates(to: self)
    }
}

// MARK: UICollectionViewDataSource
extension TransactionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegate
extension TransactionsViewController: UICollectionViewDelegate {
}

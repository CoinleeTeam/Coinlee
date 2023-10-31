//
//  IconSelectionViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import UIKit

final class IconSelectionViewController: UIViewController {
    let viewModel: IconSelectionViewViewModelType
    let iconSelectionView = IconSelectionView()
    
    // MARK: - Init
    init(viewModel: IconSelectionViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        view = iconSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconSelectionView.assignIconsCollectionViewDelegates(to: self)
    }
}

// MARK: - CollectionViewDataSource
extension IconSelectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.reuseIdentifier, for: indexPath) as? IconCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.iconCellViewModel(forIndexPath: indexPath)
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension IconSelectionViewController: UICollectionViewDelegate {
}

//
//  IconSelectionViewController.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class IconSelectionViewController: UIViewController {
    let viewModel: IconSelectionViewModelType
    let iconSelectionView = IconSelectionView()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: IconSelectionViewModel) {
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
        bindIconsToIconsCollectionView()
    }
}

// MARK: - UICollectionViewDataSource
extension IconSelectionViewController {
    private func bindIconsToIconsCollectionView() {
        viewModel.icons
            .bind(to: iconSelectionView.iconsCollectionView.rx.items(cellIdentifier: IconCell.reuseIdentifier,
                                                                     cellType: IconCell.self)) { row, icon, cell in
            cell.viewModel = self.viewModel.iconCellViewModel(icon: icon)
        }
        .disposed(by: disposeBag)
    }
}

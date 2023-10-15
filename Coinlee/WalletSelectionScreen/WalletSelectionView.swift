//
//  WalletSelectionView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit
import SnapKit

final class WalletSelectionView: UIView {
    let walletsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        setUpWalletsCollectionView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView DataSource & Delegate
    func assignWalletsCollectionViewDelegates<T>(to delegate: T) where T: UICollectionViewDataSource & UICollectionViewDelegate {
        walletsCollectionView.dataSource = delegate
        walletsCollectionView.delegate = delegate
    }
    
    // MARK: - Subviews' setup
    private func setUpWalletsCollectionView() {
        addSubview(walletsCollectionView)
        walletsCollectionView.backgroundColor = .paleFrost
        walletsCollectionView.setCollectionViewLayout(walletsCollectionViewLayout(), animated: false)
        walletsCollectionView.showsVerticalScrollIndicator = false
        walletsCollectionView.alwaysBounceVertical = true
        walletsCollectionView.register(WalletCellHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WalletCellHeaderView.reuseIdentifier)
        walletsCollectionView.register(WalletCell.self, forCellWithReuseIdentifier: WalletCell.reuseIdentifier)
        
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        walletsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: WalletsCollectionViewLayout
    private func walletsCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            layout.estimatedItemSize = CGSize(width: windowScene.screen.bounds.width - 32, height: 60)
            layout.headerReferenceSize = CGSize(width: windowScene.screen.bounds.width, height: 44)
        }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        return layout
    }
}

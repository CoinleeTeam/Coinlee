//
//  WalletTypesView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 22/10/2023.
//

import UIKit
import SnapKit

final class WalletTypesView: UIView {
    let walletTypesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        setUpWalletTypesCollectionView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpWalletTypesCollectionView() {
        addSubview(walletTypesCollectionView)
        walletTypesCollectionView.backgroundColor = .paleFrost
        walletTypesCollectionView.setCollectionViewLayout(walletTypesCollectionViewLayout(), animated: false)
        walletTypesCollectionView.showsVerticalScrollIndicator = false
        walletTypesCollectionView.alwaysBounceVertical = true
        walletTypesCollectionView.register(BorderFreeCell.self, forCellWithReuseIdentifier: BorderFreeCell.reuseIdentifier)
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        walletTypesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: WalletTypesCollectionViewLayout
    private func walletTypesCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            layout.itemSize = CGSize(width: windowScene.screen.bounds.width - 32, height: 22)
        }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        return layout
    }
}

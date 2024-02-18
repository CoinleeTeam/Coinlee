//
//  IconSelectionView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import UIKit
import SnapKit

final class IconSelectionView: UIView {
    let iconsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleFrost
        setUpIconsCollectionView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpIconsCollectionView() {
        addSubview(iconsCollectionView)
        iconsCollectionView.backgroundColor = .paleFrost
        iconsCollectionView.setCollectionViewLayout(iconsCollectionViewLayout(), animated: false)
        iconsCollectionView.showsVerticalScrollIndicator = false
        iconsCollectionView.alwaysBounceVertical = true
        iconsCollectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.reuseIdentifier)
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        iconsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: WalletTypesCollectionViewLayout
    private func iconsCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSideInset: CGFloat = 24
        let numberOfItemsInRow: CGFloat  = 4
        let interItemSpacing: CGFloat = 16
        
        if let userScreenWidth = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.width {
            let totalSpacing = (numberOfItemsInRow - 1) * interItemSpacing
            let collectionViewWidth = userScreenWidth - (sectionSideInset * 2)
            let itemWidth = (collectionViewWidth - totalSpacing) / numberOfItemsInRow
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        } else {
            layout.itemSize = CGSize(width: 63, height: 63)
        }
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSideInset, bottom: 16, right: sectionSideInset)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        return layout
    }
}

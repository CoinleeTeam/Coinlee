//
//  NoResultsView.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 14/10/2023.
//

import UIKit

final class NoResultsView: UIView {
    let magnifierImageView = UIImageView()
    let noResultLabel = UILabel()
    let tryAgainLabel = UILabel()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpMagnifierImageView()
        setUpNoResultLabel()
        setUpTryAgainLabel()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpMagnifierImageView() {
        magnifierImageView.image = UIImage(named: LinearIcon.magnifyingGlass.rawValue)
        magnifierImageView.tintColor = .goldenrod
    }
    
    private func setUpNoResultLabel() {
        noResultLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        noResultLabel.textColor = .charcoal
        noResultLabel.numberOfLines = 0
        noResultLabel.textAlignment = .center
    }
    
    private func setUpTryAgainLabel() {
        tryAgainLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        tryAgainLabel.textColor = .battleshipGrey
        tryAgainLabel.numberOfLines = 1
        tryAgainLabel.textAlignment = .center
    }
    
    // MARK: - Constraints
    private func setUpConstraints() {
        addSubview(magnifierImageView)
        addSubview(noResultLabel)
        addSubview(tryAgainLabel)
        
        magnifierImageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.centerX.top.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(magnifierImageView.snp.bottom).offset(16)
        }
        
        tryAgainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(noResultLabel.snp.bottom)
        }
    }
}

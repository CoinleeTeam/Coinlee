//
//  IconCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 31/10/2023.
//

import UIKit
import SnapKit

final class IconCell: CornerRoundedCell {
    static let reuseIdentifier = "IconCell"
    
    let imageView = UIImageView()
    
    var viewModel: IconCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            imageView.image = UIImage(named: viewModel.icon.rawValue)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpCell() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

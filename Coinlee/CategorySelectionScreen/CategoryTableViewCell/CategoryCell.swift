//
//  CategoryTableViewCell.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import UIKit
import RxSwift

final class CategoryCell: UITableViewCell {
    static let reuseIdentifier = "CategoryTableViewCell"
    
    var circleImageView = UIImageView()
    var categoryIconImageView = UIImageView()
    var categoryNameLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    weak var viewModel: CategoryCellViewModelType? {
        didSet {
            subscribeToCategory()
        }
    }
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .paleFrost
        setUpSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Subscriptions
    private func subscribeToCategory() {
        viewModel?.category
            .subscribe { category in
                self.categoryNameLabel.text = category.localizedName
                self.categoryIconImageView.image = UIImage(named: category.rawValue)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Subviews' setup
    private func setUpSubviews() {
        // circleImageView
        circleImageView.image = UIImage(systemName: "circle.fill")
        circleImageView.tintColor = UIColor.charcoal
        
        //categoryNameLabel
        categoryNameLabel.textColor = .charcoal
        categoryNameLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 14)
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        contentView.addSubview(circleImageView)
        contentView.addSubview(categoryIconImageView)
        contentView.addSubview(categoryNameLabel)
        
        circleImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(10)
        }
        
        categoryIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(circleImageView.snp.trailing).offset(16)
            make.height.width.equalTo(55)
        }
        
        categoryNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(categoryIconImageView.snp.trailing).offset(8)
            make.height.equalTo(50)
        }
    }
}

//
//  TransactionCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import UIKit
import SnapKit
import RxSwift

final class TransactionCell: IconTitleCell {
    static let reuseIdentifier = "TransactionCell"
    
    let desctiptionLabel = UILabel()
    let sumLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: TransactionCellViewModelType? {
        didSet {
            subscribeToTransaction()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabels()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subscriptions
    private func subscribeToTransaction() {
        viewModel?.transaction
            .subscribe(onNext: { transaction in
                self.titleLabel.text = transaction.category.localizedName
                self.iconImageView.image = UIImage(named: transaction.category.rawValue)
                self.desctiptionLabel.text = transaction.description
                self.sumLabel.text = self.viewModel?.transactionSumText(forTransaction: transaction)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Subviews' setup
    private func setUpLabels() {
        // desctiptionLabel
        desctiptionLabel.font = UIFont(name: Fonts.Inter.regular.rawValue, size: 12)
        desctiptionLabel.textAlignment = .left
        desctiptionLabel.numberOfLines = 1
        desctiptionLabel.textColor = .battleshipGrey
        vStack.addArrangedSubview(desctiptionLabel)
        
        // sumLabel
        sumLabel.font = UIFont(name: Fonts.Inter.regular.rawValue, size: 16)
        sumLabel.textAlignment = .right
        sumLabel.numberOfLines = 1
        sumLabel.textColor = .charcoal
        contentView.addSubview(sumLabel)
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        sumLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
        }
    }
}

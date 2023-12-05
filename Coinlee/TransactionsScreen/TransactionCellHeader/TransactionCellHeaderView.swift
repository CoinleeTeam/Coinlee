//
//  TransactionCellHeaderView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import UIKit
import SnapKit
import RxSwift

final class TransactionCellHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "TransactionCellHeaderView"
    
    private let hStack = UIStackView()
    private let vStack = UIStackView()
    
    let monthDayLabel = UILabel()
    let weekDayLabel = UILabel()
    let monthAndYearLabel = UILabel()
    let balanceLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: TransactionCellHeaderViewModelType? {
        didSet {
            subscribeToDate()
            subscribeToBalance()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabels()
        setUpStacks()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subscriptions
    private func subscribeToDate() {
        guard let viewModel = viewModel else { return }
        viewModel.date
            .subscribe { _ in
                self.monthDayLabel.text = viewModel.monthDay
                self.weekDayLabel.text = viewModel.weekDay
                self.monthAndYearLabel.text = viewModel.monthAndYear
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToBalance() {
        guard let viewModel = viewModel else { return }
        viewModel.balance
            .subscribe { balance in
                let currency = viewModel.currency.code
                self.balanceLabel.text = balance.accountingFormatted() + CharacterConstants.whitespace + currency
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Subviews' setup
    private func setUpLabels() {
        [monthDayLabel, weekDayLabel, monthAndYearLabel, balanceLabel].forEach { label in
            label.textAlignment = .center
            label.numberOfLines = 1
        }
        
        // monthDayLabel
        monthDayLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 34)
        monthDayLabel.textColor = .charcoal
        hStack.addArrangedSubview(monthDayLabel)
        
        // weekDayLabel
        weekDayLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 16)
        weekDayLabel.textColor = .charcoal
        vStack.addArrangedSubview(weekDayLabel)
        
        // monthAndYearLabel
        monthAndYearLabel.font = UIFont(name: Fonts.Inter.regular.rawValue, size: 12)
        monthAndYearLabel.textColor = .battleshipGrey
        vStack.addArrangedSubview(monthAndYearLabel)
        
        // balanceLabel
        addSubview(balanceLabel)
        balanceLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 17)
        balanceLabel.textColor = .charcoal
        balanceLabel.textAlignment = .right
    }
    
    private func setUpStacks() {
        // hStack
        addSubview(hStack)
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.distribution = .fill
        
        // vStack
        hStack.addArrangedSubview(vStack)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.alignment = .leading
        vStack.distribution = .fill
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weekDayLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}

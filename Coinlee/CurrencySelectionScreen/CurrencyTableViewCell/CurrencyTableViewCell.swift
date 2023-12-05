//
//  CurrencyTableViewCell.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CurrencyTableViewCell"
    
    private let vStack = UIStackView()
    let flagImageView = UIImageView()
    let currencyNameLabel = UILabel()
    let currencyCodeLabel = UILabel()
    
    weak var viewModel: CurrencyTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            currencyNameLabel.text = viewModel.currency.localizedName
            currencyCodeLabel.text = viewModel.currency.code
            flagImageView.image = UIImage(named: viewModel.currency.rawValue)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .paleFrost
        setUp()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        // vStack
        vStack.addArrangedSubview(currencyNameLabel)
        vStack.addArrangedSubview(currencyCodeLabel)
        vStack.axis = .vertical
        vStack.spacing = -6
        
        // currencyNameLabel
        currencyNameLabel.textColor = .charcoal
        currencyNameLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 17)
        
        // currencyCodeLabel
        currencyCodeLabel.textColor = .battleshipGrey
        currencyCodeLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 17)
    }
    
    private func setUpConstraints() {
        contentView.addSubview(flagImageView)
        contentView.addSubview(vStack)
        
        flagImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(40)
            make.width.equalTo(56)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
            make.height.equalTo(50)
        }
    }
}

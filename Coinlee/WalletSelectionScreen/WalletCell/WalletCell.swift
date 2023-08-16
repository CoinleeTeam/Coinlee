//
//  WalletCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 15/08/2023.
//

import UIKit

final class WalletCell: UITableViewCell {
    static let reuseIdentifier = "WalletCell"
    
    private let walletView = UIView()
    private let vStack = UIStackView()
    private let hStack = UIStackView()
    
    let walletIconImageView = UIImageView()
    let selectionMarkImageView = UIImageView()
    let nameLabel = UILabel()
    let balanceLabel = UILabel()
    
    var viewModel: WalletCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            walletIconImageView.image = UIImage(named: viewModel.wallet.icon.rawValue)
            nameLabel.text = viewModel.wallet.name
            balanceLabel.text = "\(viewModel.wallet.balance) PLN"
            if viewModel.wallet.isActive {
                selectionMarkImageView.isHidden = false
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpWalletView()
        setUpStackViews()
        setUpWalletIconImageView()
        setUpSelectionMarkImageView()
        setUpNameLabel()
        setUpBalanceLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        walletView.layer.backgroundColor = selected ? UIColor.silverChalice.cgColor : UIColor.white.cgColor
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setUpLayerForWalletView()
    }
    
    // MARK: Cell setup
    private func setUpCell() {
        backgroundColor = .paleFrost
        selectionStyle = .none
    }
    
    // MARK: Subviews setup
    private func setUpWalletView() {
        contentView.addSubview(walletView)
    }
    
    private func setUpLayerForWalletView() {
        walletView.layer.cornerRadius = 15
        walletView.layer.shadowOpacity = 0.2
        walletView.layer.shadowRadius = 5
        walletView.layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: walletView.frame.width - 10, height: walletView.frame.height - 5), transform: nil)
    }
    
    private func setUpStackViews() {
        // vStack
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(balanceLabel)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        
        // hStack
        walletView.addSubview(hStack)
        hStack.addArrangedSubview(walletIconImageView)
        hStack.addArrangedSubview(vStack)
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
    }
    
    private func setUpWalletIconImageView() {
        walletIconImageView.contentMode = .scaleAspectFit
    }
    
    private func setUpSelectionMarkImageView() {
        walletView.addSubview(selectionMarkImageView)
        selectionMarkImageView.image = UIImage(named: Icons.Linear.checkMark.rawValue)
        selectionMarkImageView.contentMode = .scaleAspectFit
        selectionMarkImageView.tintColor = .goldenrod
        selectionMarkImageView.isHidden = true
    }
    
    private func setUpNameLabel() {
        nameLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        nameLabel.textColor = .charcoal
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 1
    }
    
    private func setUpBalanceLabel() {
        balanceLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 15)
        balanceLabel.textColor = .dimGrey
        balanceLabel.textAlignment = .left
        balanceLabel.numberOfLines = 1
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        walletView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(6)
            make.bottom.trailing.equalToSuperview().offset(-6)
        }
        
        walletIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(55)
        }
        
        hStack.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        selectionMarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

//
//  TransactionsView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 26/08/2023.
//

import UIKit
import SnapKit

final class TransactionsView: UIView {
    // MARK: TopView
    private let topView = BottomCornerRoundedView()
    let walletButton = ConfigurableButton()
    let searchButton = ConfigurableButton()
    // MARK: TopViewStack
    private let topViewStack = UIStackView()
    // MARK: BalanceStack
    private let balanceStack = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    // MARK: CurrentMonthStack
    private let currentMonthView = UIView()
    private let currentMonthViewStack = UIStackView()
    let previousMonthButton = ConfigurableButton()
    let currentMonthButton = ConfigurableButton()
    let nextMonthButton = ConfigurableButton()
    
    // MARK: TransactionsCollectionView
    let transactionsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTopView()
        setUpTopButtons()
        setUpTopViewStack()
        setUpBalanceStack()
        setUpCurrentMonthView()
        setUpTransactionsCollectionView()
        addConstraints()
        
        // -------- REMOVE --------
        walletButton.setTitle("Wallet", for: .normal)
        walletButton.setImage(UIImage(named: WalletIcon.moneyBag.rawValue)?.preparingThumbnail(of: CGSize(width: 40, height: 40)),
                              for: .normal)
        currentMonthButton.setTitle("September 2023", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpTopView() {
        backgroundColor = .paleFrost
        addSubview(topView)
    }
    
    private func setUpTopButtons() {
        // WalletButton
        topView.addSubview(walletButton)
        walletButton.addConfiguration(baseForegroundColor: .white,
                                      titleFont: UIFont(name: Fonts.Inter.semiBold.rawValue, size: 15),
                                      leftImagePadding: 6,
                                      rightImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                      rightImagePadding: 4,
                                      contentEdgesInsets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        
        // SearchButton
        topView.addSubview(searchButton)
        searchButton.addConfiguration(leftImage: UIImage(named: LinearIcon.magnifyingGlass.rawValue),
                                      leftImageTintColor: .white,
                                      contentEdgesInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    private func setUpTopViewStack() {
        topView.addSubview(topViewStack)
        topViewStack.axis = .vertical
        topViewStack.spacing = 12
        topViewStack.alignment = .fill
        topViewStack.distribution = .equalSpacing
    }
    
    private func setUpBalanceStack() {
        // BalanceStackView
        topViewStack.addArrangedSubview(balanceStack)
        balanceStack.axis = .vertical
        balanceStack.spacing = 0
        balanceStack.alignment = .center
        balanceStack.distribution = .equalSpacing
        
        // BalanceLabel
        balanceStack.addArrangedSubview(balanceLabel)
        balanceLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 20)
        balanceLabel.textColor = .silver
        balanceLabel.textAlignment = .center
        balanceLabel.numberOfLines = 1
        balanceLabel.text =  NSLocalizedString("top_view_balance_label", comment: String()).uppercased()
        
        // BalanceAmountLabel
        balanceStack.addArrangedSubview(balanceAmountLabel)
        balanceAmountLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 38)
        balanceAmountLabel.textColor = .white
        balanceAmountLabel.textAlignment = .center
        balanceAmountLabel.numberOfLines = 1
    }
    
    private func setUpCurrentMonthView() {
        // CurrentMonthView
        topViewStack.addArrangedSubview(currentMonthView)
        currentMonthView.backgroundColor = .white
        currentMonthView.layer.cornerRadius = 20
        
        // CurrentMonthViewStack
        currentMonthView.addSubview(currentMonthViewStack)
        currentMonthViewStack.axis = .horizontal
        currentMonthViewStack.spacing = 12
        currentMonthViewStack.alignment = .center
        currentMonthViewStack.distribution = .equalCentering
        
        // PreviousMonthButton
        currentMonthViewStack.addArrangedSubview(previousMonthButton)
        previousMonthButton.addConfiguration(leftImage: UIImage(named: LinearIcon.angleLeft.rawValue),
                                             leftImageTintColor: .charcoal,
                                             contentEdgesInsets: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        
        // CurrentMonthButton
        currentMonthViewStack.addArrangedSubview(currentMonthButton)
        currentMonthButton.addConfiguration(baseForegroundColor: .charcoal,
                                            titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                            leftImage: UIImage(named: LinearIcon.calendar.rawValue),
                                            leftImageTintColor: .goldenrod,
                                            leftImagePadding: 8,
                                            contentEdgesInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
        // NextMonthButton
        currentMonthViewStack.addArrangedSubview(nextMonthButton)
        nextMonthButton.addConfiguration(leftImage: UIImage(named: LinearIcon.angleRight.rawValue),
                                         leftImageTintColor: .charcoal,
                                         contentEdgesInsets: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
    
    private func setUpTransactionsCollectionView() {
        addSubview(transactionsCollectionView)
        transactionsCollectionView.backgroundColor = .paleFrost
        transactionsCollectionView.setCollectionViewLayout(transactionsCollectionViewLayout(), animated: false)
        transactionsCollectionView.showsVerticalScrollIndicator = false
        transactionsCollectionView.alwaysBounceVertical = true
        transactionsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(UICollectionReusableView.self)")
        transactionsCollectionView.register(TransactionCellHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TransactionCellHeaderView.reuseIdentifier)
        transactionsCollectionView.register(IncomeExpenseStaticCell.self, forCellWithReuseIdentifier: IncomeExpenseStaticCell.reuseIdentifier)
        transactionsCollectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.reuseIdentifier)
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        walletButton.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(8)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(walletButton.snp.centerY)
            make.trailing.equalToSuperview().inset(12)
            make.leading.greaterThanOrEqualTo(walletButton.snp.trailing).offset(12)
        }
        
        topViewStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(48)
            make.top.equalTo(walletButton.snp.bottom)
            make.bottom.equalToSuperview().inset(12)
        }
        
        currentMonthView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(topViewStack)
        }
        
        currentMonthViewStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        transactionsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: TransactionsCollectionViewLayout
    private func transactionsCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        return layout
    }
}

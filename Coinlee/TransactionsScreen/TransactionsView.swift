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
    
    // MARK: MiddleStackView
    private let middleStack = UIStackView()
    let incomeLabel = UILabel()
    let expenseLabel = UILabel()
    let incomeSublabel = UILabel()
    let expenseSublabel = UILabel()
    
    // MARK: TransactionsCollectionView
    let transactionsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTopView()
        setUpTopButtons()
        setUpTopViewStack()
        setUpBalanceStack()
        setUpCurrentMonthView()
        setUpMiddleStackView()
        addConstraints()
        
        // -------- REMOVE --------
        walletButton.setTitle("Wallet", for: .normal)
        walletButton.setImage(UIImage(named: Icons.Wallet.moneyBag.rawValue)?.preparingThumbnail(of: CGSize(width: 40, height: 40)), for: .normal)
        balanceLabel.text = "BALANCE"
        balanceAmountLabel.text = "3.500 PLN"
        currentMonthButton.setTitle("September 2023", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignTransactionsCollectionViewDelegates<T>(to delegate: T) where T: UICollectionViewDataSource & UICollectionViewDelegate {
        transactionsCollectionView.dataSource = delegate
        transactionsCollectionView.delegate = delegate
    }
    
    // MARK: Subviews' setup
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
                                      rightImage: UIImage(named: Icons.Linear.angleRight.rawValue),
                                      rightImagePadding: 4,
                                      contentEdgesInset: 4)
        
        // SearchButton
        topView.addSubview(searchButton)
        searchButton.addConfiguration(leftImage: UIImage(named: Icons.Linear.magnifyingGlass.rawValue),
                                      leftImageTintColor: .white,
                                      contentEdgesInset: 8)
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
        previousMonthButton.addConfiguration(leftImage: UIImage(named: Icons.Linear.angleLeft.rawValue),
                                             leftImageTintColor: .charcoal,
                                             contentEdgesInset: 2)
        
        // CurrentMonthButton
        currentMonthViewStack.addArrangedSubview(currentMonthButton)
        currentMonthButton.addConfiguration(baseForegroundColor: .charcoal,
                                            titleFont: UIFont(name: Fonts.Inter.medium.rawValue, size: 16),
                                            leftImage: UIImage(named: Icons.Linear.calendar.rawValue),
                                            leftImageTintColor: .goldenrod,
                                            leftImagePadding: 8,
                                            contentEdgesInset: 8)
        
        // NextMonthButton
        currentMonthViewStack.addArrangedSubview(nextMonthButton)
        nextMonthButton.addConfiguration(leftImage: UIImage(named: Icons.Linear.angleRight.rawValue),
                                         leftImageTintColor: .charcoal,
                                         contentEdgesInset: 2)
    }
    
    private func setUpMiddleStackView() {
        addSubview(middleStack)
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
            make.top.equalTo(safeAreaLayoutGuide).offset(14)
            make.trailing.equalToSuperview().inset(12)
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
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    // MARK: TransactionsCollectionViewLayout
    private func transactionsCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            layout.estimatedItemSize = CGSize(width: windowScene.screen.bounds.width - 32, height: 60)
            layout.headerReferenceSize = CGSize(width: windowScene.screen.bounds.width, height: 44)
        }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        return layout
    }
}

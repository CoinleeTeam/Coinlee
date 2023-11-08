//
//  IncomeExpenseStaticCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 14/09/2023.
//

import UIKit
import SnapKit

final class IncomeExpenseStaticCell: UICollectionViewCell {
    static let reuseIdentifier = "IncomeExpenseStaticCell"
    
    private let hStack = UIStackView()
    private let lhsVStack = UIStackView()
    private let rhsVStack = UIStackView()
    
    let incomeLabel = UILabel()
    let expenseLabel = UILabel()
    let incomeSublabel = UILabel()
    let expenseSublabel = UILabel()
    
    var viewModel: IncomeExpenseStaticCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            incomeLabel.text = viewModel.incomeAmount.accountingFormatted()
            expenseLabel.text = CharacterConstants.minusSign + viewModel.expenseAmount.accountingFormatted()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawCenterLine()
        setUpLabels()
        setUpStackViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View setup
    private func drawCenterLine() {
        let centerLineLayer = CALayer()
        centerLineLayer.frame = CGRect(x: frame.width / 2, y: -2, width: 1, height: 57)
        centerLineLayer.backgroundColor = UIColor.charcoal.cgColor.copy(alpha: 0.67)
        layer.addSublayer(centerLineLayer)
    }
    
    private func setUpLabels() {
        [incomeSublabel, expenseSublabel].forEach { label in
            label.font = UIFont(name: Fonts.Inter.regular.rawValue, size: 13)
            label.textColor = .battleshipGrey
            label.textAlignment = .center
            label.numberOfLines = 0
        }
        
        [incomeLabel, expenseLabel].forEach { label in
            label.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 20)
            label.textAlignment = .center
            label.numberOfLines = 0
        }
        
        incomeLabel.textColor = .oliveGreen
        incomeSublabel.text = NSLocalizedString("income_label", comment: String())
        expenseLabel.textColor = .coralRed
        expenseSublabel.text = NSLocalizedString("expense_label", comment: String())
    }
    
    private func setUpStackViews() {
        // hStack
        hStack.axis = .horizontal
        hStack.spacing = 0
        hStack.alignment = .center
        hStack.distribution = .fill
        
        // lhsVStack and rhsVStack
        [lhsVStack, rhsVStack].forEach { stack in
            stack.axis = .vertical
            stack.spacing = 7
            stack.alignment = .center
            stack.distribution = .fill
        }
        
        // add subviews
        addSubview(hStack)
        hStack.addArrangedSubview(lhsVStack)
        hStack.addArrangedSubview(rhsVStack)
        lhsVStack.addArrangedSubview(incomeLabel)
        lhsVStack.addArrangedSubview(incomeSublabel)
        rhsVStack.addArrangedSubview(expenseLabel)
        rhsVStack.addArrangedSubview(expenseSublabel)
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

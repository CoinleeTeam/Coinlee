//
//  CornerRoundedCell.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 19/08/2023.
//

import UIKit

class CornerRoundedCell: UITableViewCell {
    let innerContentView = UIView()
    let vStack = UIStackView()
    let hStack = UIStackView()
    
    let iconImageView = UIImageView()
    let headerLabel = UILabel()
    
    var viewModel: CornerRoundedCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            iconImageView.image = UIImage(named: viewModel.iconImageName)
            headerLabel.text = viewModel.headerTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpInnerContentView()
        setUpStackViews()
        setUpIconImageView()
        setUpHeaderLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        innerContentView.layer.backgroundColor = selected ? UIColor.silverChalice.cgColor : UIColor.white.cgColor
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setUpLayerForInnerContentView()
    }
    
    // MARK: Cell setup
    private func setUpCell() {
        backgroundColor = .paleFrost
        selectionStyle = .none
    }
    
    // MARK: Subviews setup
    private func setUpInnerContentView() {
        contentView.addSubview(innerContentView)
    }
    
    private func setUpLayerForInnerContentView() {
        innerContentView.layer.cornerRadius = 15
        innerContentView.layer.shadowOpacity = 0.2
        innerContentView.layer.shadowRadius = 5
        innerContentView.layer.shadowPath = CGPath(rect: CGRect(x: 5, y: 10, width: innerContentView.frame.width - 10, height: innerContentView.frame.height - 5), transform: nil)
    }
    
    private func setUpStackViews() {
        // vStack
        vStack.addArrangedSubview(headerLabel)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        
        // hStack
        innerContentView.addSubview(hStack)
        hStack.addArrangedSubview(iconImageView)
        hStack.addArrangedSubview(vStack)
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.distribution = .fill
    }
    
    private func setUpIconImageView() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func setUpHeaderLabel() {
        headerLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        headerLabel.textColor = .charcoal
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 0
    }
    
    // MARK: Subviews' constraints
    private func addConstraints() {
        innerContentView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(6)
            make.bottom.trailing.equalToSuperview().offset(-6)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(55)
        }
        
        hStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.trailing.equalToSuperview().offset(-24)

        }
    }
}

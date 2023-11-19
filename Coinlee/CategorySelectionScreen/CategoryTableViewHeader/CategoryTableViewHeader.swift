//
//  CategoryTableViewHeader.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import UIKit

final class CategoryTableViewHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "CategoryTableViewHeader"
    let headerContentView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let expansionAngleBracket = UIImageView()
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    var isExpanded = false {
        didSet {
            rotateExpansionAngleBracket()
        }
    }
    
    weak var viewModel: CategoryTableViewHeaderViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            iconImageView.image = UIImage(named: viewModel.categoryName)
            titleLabel.text = NSLocalizedString(viewModel.categoryName, comment: "Category group name")
        }
    }
    
    // MARK: - Inits
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHeader()
        addConstraints()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subview setup
    private func configureHeader() {
        backgroundView?.backgroundColor = .paleFrost
        titleLabel.textColor = .charcoal
        titleLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        expansionAngleBracket.image = UIImage(named: Icon.Linear.expandAngle.rawValue)
        expansionAngleBracket.tintColor = .goldenrod
        applyRotation(to: expansionAngleBracket, angle: -90)
    }
    
    private func addGestureRecognizer() {
        headerContentView.addGestureRecognizer(tapGestureRecognizer)
        headerContentView.isUserInteractionEnabled = true
    }
    
    private func rotateExpansionAngleBracket() {
        if isExpanded == false {
            applyRotation(to: expansionAngleBracket, angle: -90)
        } else {
            applyRotation(to: expansionAngleBracket, angle: 0)
        }
    }
    
    func applyRotation(to view: UIView, angle: CGFloat) {
        let rotationInRadians = (angle * .pi) / 180.0
        UIView.animate(withDuration: 0.25) {
            view.transform = CGAffineTransform(rotationAngle: rotationInRadians)
        }
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        headerContentView.addSubview(iconImageView)
        headerContentView.addSubview(titleLabel)
        headerContentView.addSubview(expansionAngleBracket)
        
        addSubview(headerContentView)
        
        headerContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.width.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        expansionAngleBracket.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.height.width.equalTo(24)
        }
    }
}


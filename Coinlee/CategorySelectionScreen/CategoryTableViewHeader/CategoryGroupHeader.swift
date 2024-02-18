//
//  CategoryTableViewHeader.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 15/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

final class CategoryGroupHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "CategoryTableViewHeader"
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let expansionAngleBracket = UIImageView()
    var tapGestureRecognizer = UITapGestureRecognizer()
    var isExpanded: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let disposeBag = DisposeBag()
    
    weak var viewModel: CategoryGroupHeaderViewModelType? {
        didSet {
            subscribeToCategoryGroup()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tapGestureRecognizer = UITapGestureRecognizer()
        addGestureRecognizer()
    }
    
    // MARK: - Inits
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHeader()
        addConstraints()
        addGestureRecognizer()
        subscribeToIsExpanded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subscriptions
    private func subscribeToCategoryGroup() {
        viewModel?.categoryGroup
            .subscribe(onNext: { categoryGroup in
                self.iconImageView.image = UIImage(named: categoryGroup.rawValue)
                self.titleLabel.text = categoryGroup.localizedName
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToIsExpanded() {
        isExpanded
            .subscribe { _ in
                self.rotateExpansionAngleBracket()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Subview setup
    private func configureHeader() {
        backgroundView?.backgroundColor = .paleFrost
        titleLabel.textColor = .charcoal
        titleLabel.font = UIFont(name: Fonts.Inter.medium.rawValue, size: 18)
        expansionAngleBracket.image = UIImage(named: LinearIcon.expandAngle.rawValue)
        expansionAngleBracket.tintColor = .goldenrod
        applyRotation(to: expansionAngleBracket, angle: -90)
    }
    
    private func addGestureRecognizer() {
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func rotateExpansionAngleBracket() {
        if isExpanded.value == false {
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
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(expansionAngleBracket)
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
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

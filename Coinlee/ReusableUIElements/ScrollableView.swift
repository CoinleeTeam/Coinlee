//
//  ScrollableView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 04/11/2023.
//

import UIKit
import SnapKit

class ScrollableView: UIView {
    let scrollView = ScrollView()
    private let tapRecognizer = UITapGestureRecognizer()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScrollView()
        setUpTapRecognizer()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews' setup
    private func setUpScrollView() {
        scrollView.delaysContentTouches = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setUpTapRecognizer() {
        scrollView.addGestureRecognizer(tapRecognizer)
        tapRecognizer.addTarget(self, action: #selector(didTapScrollView))
    }
    
    @objc private func didTapScrollView() {
        endEditing(true)
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.frameLayoutGuide.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(scrollView)
        }
    }
}

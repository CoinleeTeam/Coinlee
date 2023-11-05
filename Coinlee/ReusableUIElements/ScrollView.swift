//
//  ScrollView.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 04/11/2023.
//

import UIKit

final class ScrollView: UIScrollView {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        super.touchesShouldCancel(in: view)
        return true
    }
}

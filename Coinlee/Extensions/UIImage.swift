//
//  UIImage.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 01/09/2023.
//

import UIKit

extension UIImage {
    /// Returns an image with a specified alpha (transparency) value.
    func withAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }

        draw(at: .zero, blendMode: .normal, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

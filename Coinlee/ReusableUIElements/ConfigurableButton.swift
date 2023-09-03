//
//  ConfigurableButton.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 27/08/2023.
//

import UIKit

class ConfigurableButton: UIButton {
    var rightImageView: UIImageView?
    
    private func setUpRightImageView(imagePadding: CGFloat) {
        guard let rightImageView = rightImageView,
              let titleLabel = titleLabel
        else { return }
            titleLabel.addSubview(rightImageView)
        if rightImageView.constraints.isEmpty {
            rightImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(titleLabel.snp.trailing).offset(imagePadding)
            }
        }
    }
    
    /// Configures button with provided arguments
    func addConfiguration(baseForegroundColor: UIColor? = nil,
                          titleFont: UIFont? = nil,
                          leftImage: UIImage? = nil,
                          leftImageTintColor: UIColor? = nil,
                          leftImagePadding: CGFloat = 0,
                          rightImage: UIImage? = nil,
                          rightImagePadding: CGFloat = 0,
                          contentEdgesInset: CGFloat = 0) {
        
        // Update Handler: called each time when configuration is about to be updated
        configurationUpdateHandler = { [weak self] button in
            guard let self = self,
                  var newConfiguration = button.configuration
            else { return }
            
            if state == .highlighted {
                let highlitedElementsAlphaValue = 0.6
                var highlitedImage = newConfiguration.image?.withAlpha(highlitedElementsAlphaValue)
                
                // change left image's and title's alpha
                if let leftImageTintColor = leftImageTintColor {
                    highlitedImage = highlitedImage?.withTintColor(leftImageTintColor)
                }
                newConfiguration.image = highlitedImage
                newConfiguration.attributedTitle?.foregroundColor = baseForegroundColor?.withAlphaComponent(highlitedElementsAlphaValue)
                
                // apply changes
                self.rightImageView?.alpha = highlitedElementsAlphaValue
                self.layer.backgroundColor = self.layer.backgroundColor?.copy(alpha: 0.8)
                self.configuration = newConfiguration
                
            } else if state == .normal {
                UIView.transition(with: self,
                                  duration: 0.25,
                                  options: .transitionCrossDissolve) {
                    self.configuration = newConfiguration
                    self.layer.backgroundColor = self.layer.backgroundColor?.copy(alpha: 1)
                    self.rightImageView?.alpha = 1
                }
            }
        }
        
        var defaultConfiguration = UIButton.Configuration.plain()
        var contentTrailingInset = contentEdgesInset
        
        // rightImageView settings
        if rightImage == nil {
            rightImageView = nil
        } else {
            rightImageView = UIImageView(image: rightImage)
            rightImageView?.tintColor = baseForegroundColor
            setUpRightImageView(imagePadding: rightImagePadding)
            contentTrailingInset += rightImagePadding + rightImageView!.frame.width
        }
        
        // content settings
        defaultConfiguration.contentInsets = NSDirectionalEdgeInsets(top: contentEdgesInset,
                                                                     leading: contentEdgesInset,
                                                                     bottom: contentEdgesInset,
                                                                     trailing: contentTrailingInset)
        defaultConfiguration.baseForegroundColor = baseForegroundColor
        
        // title settings
        defaultConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incomingContainer in
            var outgoingContainer = incomingContainer
            outgoingContainer.font = titleFont
            return outgoingContainer
        }
        
        // leftImageView settings
        setImage(leftImage, for: .normal)
        defaultConfiguration.imagePadding = leftImagePadding
        defaultConfiguration.imageColorTransformer = UIConfigurationColorTransformer { incomingColor in
            return leftImageTintColor ?? incomingColor
        }
        
        // apply changes
        configuration = defaultConfiguration
    }
}

//
//  ConfigurableButton.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 27/08/2023.
//

import UIKit

final class ConfigurableButton: UIButton {
    enum RightImagePosition {
        case fixed
        case dynamic
    }
    
    var rightImageView: UIImageView?
    
    override var bounds: CGRect {
        didSet {
            if shadowType == .bottom {
                createBasicContainerWithBottomShadow()
            } else if shadowType == .rounded {
                createBasicContainerWithRoundShadow()
            }
        }
    }
    
    // MARK: - Button setup
    /// Configures button with provided arguments
    func addConfiguration(baseForegroundColor: UIColor? = nil,
                          titleFont: UIFont? = nil,
                          leftImage: UIImage? = nil,
                          leftImageTintColor: UIColor? = nil,
                          leftImagePadding: CGFloat = 0,
                          rightImage: UIImage? = nil,
                          rightImagePosition: RightImagePosition = .dynamic,
                          rightImagePadding: CGFloat = 0,
                          contentEdgesInsets: UIEdgeInsets = .zero) {
        
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
                self.configuration = newConfiguration
                
            } else if state == .normal {
                UIView.transition(with: self,
                                  duration: 0.25,
                                  options: .transitionCrossDissolve) {
                    self.configuration = newConfiguration
                    self.rightImageView?.alpha = 1
                }
            }
        }
        
        var defaultConfiguration = UIButton.Configuration.plain()
        var contentTrailingInset = contentEdgesInsets.right + rightImagePadding
        
        // rightImageView settings
        if rightImage == nil {
            rightImageView = nil
        } else {
            rightImageView = UIImageView(image: rightImage)
            guard let rightImageView = rightImageView, let titleLabel = titleLabel else { return }
            let rightImageSuperview = rightImagePosition == .fixed ? self : titleLabel
            rightImageView.tintColor = baseForegroundColor
            rightImageSuperview.addSubview(rightImageView)
            
            rightImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                if rightImagePosition == .fixed {
                    make.trailing.equalToSuperview().inset(rightImagePadding)
                } else if rightImagePosition == .dynamic {
                    make.leading.equalTo(titleLabel.snp.trailing).offset(rightImagePadding)
                }
            }
            
            contentTrailingInset += rightImageView.frame.width
        }
        
        // content settings
        contentHorizontalAlignment = rightImagePosition == .fixed ? .leading : .center
        defaultConfiguration.contentInsets = NSDirectionalEdgeInsets(top: contentEdgesInsets.top,
                                                                     leading: contentEdgesInsets.left,
                                                                     bottom: contentEdgesInsets.bottom,
                                                                     trailing: contentTrailingInset)
        defaultConfiguration.baseForegroundColor = baseForegroundColor
        
        // title settings
        defaultConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incomingContainer in
            var outgoingContainer = incomingContainer
            outgoingContainer.font = titleFont
            return outgoingContainer
        }
        defaultConfiguration.titleLineBreakMode = .byTruncatingTail
        
        // leftImageView settings
        setImage(leftImage, for: .normal)
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFit
        defaultConfiguration.imagePadding = leftImagePadding
        defaultConfiguration.imageColorTransformer = UIConfigurationColorTransformer { incomingColor in
            return leftImageTintColor ?? incomingColor
        }
        
        // apply changes
        configuration = defaultConfiguration
    }
}

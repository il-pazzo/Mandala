//
//  ImageSelector.swift
//  Mandala
//
//  Created by Glenn Cole on 6/2/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class ImageSelector: UIControl {
    
    private let selectorStackView: UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.axis          = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment     = .center
        stackView.spacing       = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var imageButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            imageButtons.forEach { selectorStackView.addArrangedSubview( $0 ) }
        }
    }
    
    var images: [UIImage] = [] {
        didSet {
            imageButtons = images.map { image in
                let imageButton = UIButton()
                
                imageButton.setImage( image, for: .normal )
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget( self,
                                       action: #selector(imageButtonTapped(_:)),
                                       for: .touchUpInside )
                
                return imageButton
            }
            
            selectedIndex = 0
        }
    }
    
    var selectedIndex = 0
    
    
    // MARK: - Code begins here
    
    // support instantiation programatically
    override init( frame: CGRect) {
        super.init( frame: frame )

        configureViewHierarchy()
    }

    // support instantiation from storyboard
    required init?( coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )

        configureViewHierarchy()
    }
    
    private func configureViewHierarchy() {
        
        addSubview( selectorStackView )
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor     .constraint(equalTo: leadingAnchor ),
            selectorStackView.trailingAnchor    .constraint(equalTo: trailingAnchor ),
            selectorStackView.topAnchor         .constraint(equalTo: topAnchor ),
            selectorStackView.bottomAnchor      .constraint(equalTo: bottomAnchor )
        ])
    }
    
    @objc private func imageButtonTapped( _ sender: UIButton ) {

        guard let buttonIndex = imageButtons.firstIndex( of: sender ) else {
            preconditionFailure( "The buttons and images do not match" )
        }
        
        selectedIndex = buttonIndex
        sendActions( for: .valueChanged )
    }
}

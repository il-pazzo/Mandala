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
    
    private let highlightView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = view.tintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var highlightViewXConstraint: NSLayoutConstraint! {
        didSet {
            oldValue?.isActive = false
            highlightViewXConstraint.isActive = true
        }
    }

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
    
    var selectedIndex = 0 {
        didSet {
            if selectedIndex < 0 {
                selectedIndex = 0
            }
            if selectedIndex >= imageButtons.count {
                selectedIndex = imageButtons.count - 1
            }
            
            let imageButton = imageButtons[ selectedIndex ]
            highlightViewXConstraint =
                highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor )
        }
    }
    
    
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
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2.0
    }
    
    private func configureViewHierarchy() {
        
        addSubview( selectorStackView )
        insertSubview( highlightView, belowSubview: selectorStackView )
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor     .constraint(equalTo: leadingAnchor ),
            selectorStackView.trailingAnchor    .constraint(equalTo: trailingAnchor ),
            selectorStackView.topAnchor         .constraint(equalTo: topAnchor ),
            selectorStackView.bottomAnchor      .constraint(equalTo: bottomAnchor ),
            
            highlightView.heightAnchor          .constraint(equalTo: highlightView.widthAnchor ),
            highlightView.heightAnchor          .constraint(equalTo: heightAnchor, multiplier: 0.9 ),
            highlightView.centerYAnchor         .constraint(equalTo: selectorStackView.centerYAnchor )
        ])
    }
    
    @objc private func imageButtonTapped( _ sender: UIButton ) {

        guard let buttonIndex = imageButtons.firstIndex( of: sender ) else {
            preconditionFailure( "The buttons and images do not match" )
        }
        
        let selectionAnimator = UIViewPropertyAnimator( duration: 0.3,
                                                        dampingRatio: 0.7,
                                                        animations: {
                                                            self.selectedIndex = buttonIndex
                                                            self.layoutIfNeeded()
                                                        })
        selectionAnimator.startAnimation()
        
        sendActions( for: .valueChanged )
    }
}

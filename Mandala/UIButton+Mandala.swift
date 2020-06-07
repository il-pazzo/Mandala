//
//  UIButton+Mandala.swift
//  Mandala
//
//  Created by Glenn Cole on 5/30/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

extension UIButton {
    
    func clearMood() {
        
        setTitle( nil, for: .normal )
        backgroundColor = nil
    }
    
    func setMood( _ mood: Mood ) {
        
        setTitle( "I'm \(mood.name)", for: .normal )
        
        let selectionAnimator = UIViewPropertyAnimator( duration: 0.3,
                                                        dampingRatio: 0.7 ) {
            self.backgroundColor = mood.color
        }
        selectionAnimator.startAnimation()
    }
}

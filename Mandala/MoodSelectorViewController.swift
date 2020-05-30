//
//  MoodSelectorViewController.swift
//  Mandala
//
//  Created by Glenn Cole on 5/30/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class MoodSelectorViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addMoodButton: UIButton!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodButtons = moods.map { mood in
                
                let moodButton = UIButton()
                moodButton.setImage( mood.image, for: .normal )
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.adjustsImageWhenHighlighted = false
                moodButton.addTarget( self,
                                      action: #selector(moodSelectionChanged(_:)),
                                      for: .touchUpInside )
                
                return moodButton
            }
        }
    }
    
    var moodButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            moodButtons.forEach { stackView.addArrangedSubview( $0 ) }
        }
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.clearMood()
                return
            }
            
            addMoodButton?.setMood( currentMood )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        moods = [
            .happy,
            .sad,
            .angry,
            .goofy,
            .crying,
            .confused,
            .sleepy,
            .meh,
        ]
        
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }

    @objc func moodSelectionChanged( _ sender: UIButton ) {
        
        guard let selectedIndex = moodButtons.firstIndex( of: sender ) else {
            preconditionFailure( "Unable to find the tapped button in the mood buttons array" )
        }
        
        currentMood = moods[ selectedIndex ]
    }
}


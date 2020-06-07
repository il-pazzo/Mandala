//
//  MoodSelectorViewController.swift
//  Mandala
//
//  Created by Glenn Cole on 5/30/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class MoodSelectorViewController: UIViewController {
    
    @IBOutlet var addMoodButton: UIButton!
    @IBOutlet var moodSelector: ImageSelector!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodSelector.images = moods.map( { $0.image })
            moodSelector.highlightColours = moods.map( { $0.color })
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
    
    var moodsConfigurable: MoodsConfigurable!
    
    
    // MARK: - Code begins here

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure( "View controller expected to conform to MoodsConfigurable" )
            }
            self.moodsConfigurable = moodsConfigurable
            
            segue.destination.additionalSafeAreaInsets =
                UIEdgeInsets( top: 0, left: 0, bottom: 160, right: 0 )
            
        default:
            preconditionFailure( "Unexpected segue identifier" )
        }
    }

    @IBAction private func moodSelectionChanged( _ sender: ImageSelector ) {
        
        let selectedIndex = sender.selectedIndex
        
        currentMood = moods[ selectedIndex ]
    }
    
    @IBAction func addMoodTapped( _ sender: UIButton ) {
        
        guard let currentMood = currentMood else {
            return
        }
        
        let newMoodEntry = MoodEntry( mood: currentMood, timestamp: Date())
        moodsConfigurable.add( newMoodEntry )
    }
}


//
//  MoodListViewController.swift
//  Mandala
//
//  Created by Glenn Cole on 5/30/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class MoodListViewController: UITableViewController {
    
    var moodEntries: [MoodEntry] = []
}


//MARK: - TableViewDataSource methods

extension MoodListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let moodEntry = moodEntries[ indexPath.row ]
        
        let cell = tableView.dequeueReusableCell( withIdentifier: "UITableViewCell",
                                                  for: indexPath )
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        
        let dateString = DateFormatter.localizedString( from: moodEntry.timestamp,
                                                        dateStyle: .medium,
                                                        timeStyle: .short )
        
        cell.detailTextLabel?.text = "on \(dateString)"
        
        return cell
    }
}


// MARK: - MoodsConfigurable protocol

extension MoodListViewController: MoodsConfigurable {
    
    func add(_ moodEntry: MoodEntry) {
        
        moodEntries.insert( moodEntry, at: 0 )
        tableView.insertRows( at: [IndexPath( row: 0, section: 0)],
                              with: .automatic )
    }
}

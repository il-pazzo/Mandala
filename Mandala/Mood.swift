//
//  Mood.swift
//  Mandala
//
//  Created by Glenn Cole on 5/30/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var color: UIColor
}

extension Mood {
    
    static let angry        = Mood(name: "angry"        ,image: UIImage.angry       ,color: UIColor.angry )
    static let confused     = Mood(name: "confused"     ,image: UIImage.confused    ,color: UIColor.confused )
    static let crying       = Mood(name: "crying"       ,image: UIImage.crying      ,color: UIColor.crying )
    static let goofy        = Mood(name: "goofy"        ,image: UIImage.goofy       ,color: UIColor.goofy )
    static let happy        = Mood(name: "happy"        ,image: UIImage.happy       ,color: UIColor.happy )
    static let meh          = Mood(name: "meh"          ,image: UIImage.meh         ,color: UIColor.meh )
    static let sad          = Mood(name: "sad"          ,image: UIImage.sad         ,color: UIColor.sad )
    static let sleepy       = Mood(name: "sleepy"       ,image: UIImage.sleepy      ,color: UIColor.sleepy )
}

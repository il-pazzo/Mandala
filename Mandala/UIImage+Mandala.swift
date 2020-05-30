//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Glenn Cole on 5/30/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    
    convenience init( resource: ImageResource ) {
        self.init( named: resource.rawValue )!
    }
    
    static let angry        = UIImage( resource: .angry )
    static let confused     = UIImage( resource: .confused )
    static let crying       = UIImage( resource: .crying )
    static let goofy        = UIImage( resource: .goofy )
    static let happy        = UIImage( resource: .happy )
    static let meh          = UIImage( resource: .meh )
    static let sad          = UIImage( resource: .sad )
    static let sleepy       = UIImage( resource: .sleepy )
}

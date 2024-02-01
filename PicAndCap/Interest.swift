//
//  Interest.swift
//  PicAndCap
//
//  Created by Lee Sangoroh on 01/02/2024.
//

import UIKit

class Interest: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}


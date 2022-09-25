//
//  PlaceTourist.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import Foundation

class PlaceTourist: Place {
    var discount_tourist: String = ""
    
    override init() {
        super.init()
        type = .TouristPlace
    }
    
    init(name: String, description: String, discount_tourist: String, image_int: Data?) {
        super.init(type: .TouristPlace, name: name, description: description, image_int: image_int)
        self.discount_tourist = discount_tourist
    }
}

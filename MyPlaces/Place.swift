//
//  Place.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import Foundation
import MapKit

enum PlacesTypes {
    case GenericPlace
    case TouristPlace
}

class Place {
    var id: String = ""
    var type: PlacesTypes = .GenericPlace
    var name: String = ""
    var description: String = ""
    var location: CLLocationCoordinate2D!
    var image: Data? = nil
    
    init() {
    
    }
    
    init(name: String, description: String, image_int: Data?) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.image = image_int
    }
    
    init(type: PlacesTypes, name: String, description: String, image_int: Data?) {
        self.id = UUID().uuidString
        self.type = type
        self.name = name
        self.description = description
        self.image = image_int
    }

}

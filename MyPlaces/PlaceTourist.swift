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
    
    //******************************************
       // Serialization
       
        enum CodingKeysTourist: String, CodingKey {
            case discount_tourist
        }
       
       
        override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy:CodingKeysTourist.self)
            try container.encode(discount_tourist, forKey:.discount_tourist)
            try super.encode(to: encoder)
        }
       
       override func decode(from decoder: Decoder) throws
       {
           try super.decode(from:decoder)
           
           let container = try decoder.container(keyedBy: CodingKeysTourist.self)
           discount_tourist = try container.decode(String.self, forKey: .discount_tourist)
       }
       
       required convenience init(from decoder: Decoder) throws {
           self.init()
           try decode(from:decoder)
       }
}

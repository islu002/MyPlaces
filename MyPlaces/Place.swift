//
//  Place.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import Foundation
import MapKit

enum PlacesTypes : Codable {
    case GenericPlace
    case TouristPlace
}

class Place : Codable {
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
    
    //******************************************
      // Serialization
      
        enum CodingKeys: String, CodingKey {
            case id
            case description
            case name
            case type
            case latitude
            case longitude
        }
      
      func decode(from decoder: Decoder) throws
      {
          
          let container = try decoder.container(keyedBy: CodingKeys.self)
          
          id = try container.decode(String.self, forKey: .id)
          type = try container.decode(PlacesTypes.self, forKey: .type)
          name = try container.decode(String.self, forKey: .name)
          description = try container.decode(String.self, forKey: .description)
          //image = try? container.decode(String.self, forKey: .image) as! Data?
          let latitude = try container.decode(Double.self, forKey:.latitude)
          let longitude = try container.decode(Double.self, forKey:.longitude)
          location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
      }
      
      required convenience init(from decoder: Decoder) throws {
          
          self.init()
          try decode(from: decoder)
      }
      
      func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(id, forKey: .id)
          try container.encode(type, forKey: .type)
          try container.encode(name, forKey: .name)
          try container.encode(description, forKey: .description)
          //try container.encode(image, forKey: .image)
          try container.encode(location.latitude, forKey:.latitude)
          try container.encode(location.longitude, forKey:.longitude)
      }

}

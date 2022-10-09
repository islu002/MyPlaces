//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import Foundation

class ManagerPlaces : Codable {
    var places: [Place] = []
    
    init() { }
    
    
    //******************************************
    // Singleton
    //
    //  Unique instance for all App
    //
    private static var sharedManagerPlaces: ManagerPlaces = {
            
            var singletonManager:ManagerPlaces
           
            singletonManager = ManagerPlaces()
            
            return singletonManager
        }()
        
        
        class func shared() -> ManagerPlaces {
            return sharedManagerPlaces
        }
    // ****************************************/
    
    func append(_ value: Place) {
        places.append(value)
    }
    
    func GetCount() -> Int {
        return places.count
    }
    
    func GetItemAt(position: Int) -> Place {
        return places[position]
    }
    
    func GetItemById(id: String) -> Place {
        let index = places.firstIndex(where: {$0.id == id})
        return places[index!]
    }
    
    func remove(_ value: Place) {
        let index = places.firstIndex(where: {$0 === value})
       places.remove(at: index!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteElement"), object: nil)
    }
    
    func GetPosition(_ value: Place) -> Int {
        return places.firstIndex(where: {$0 === value})!
    }
    
    func update(_ value: Place, index: Int) {
        places[index] = value
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newOrUpdateElement"), object: nil)
    }
    
    //******************************************
      // Serialization
      
      enum CodingKeys: String, CodingKey {
          case places
          
      }
      
      enum PlacesTypeKey: CodingKey {
          case type
          
      }
      
      func decode(from decoder: Decoder) throws
      {
          
          let container = try decoder.container(keyedBy: CodingKeys.self)
          
          places = [Place]()
          
          
          var objectsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.places)
          
          
          var tmp_array = objectsArrayForType
          
          while(!objectsArrayForType.isAtEnd)
          {
              let object = try objectsArrayForType.nestedContainer(keyedBy: PlacesTypeKey.self)
              let type = try object.decode(PlacesTypes.self, forKey: PlacesTypeKey.type)
              
              switch type {
              case PlacesTypes.GenericPlace:
                  
                  self.append(try tmp_array.decode(Place.self))
              case PlacesTypes.TouristPlace:
                  
                  self.append(try tmp_array.decode(PlaceTourist.self))
              default :
                  self.append(try tmp_array.decode(Place.self))
              }
              
          }
          
      }
      
      required convenience init(from decoder: Decoder) throws {
          
          self.init()
          try decode(from: decoder)
      }
      
      func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(places, forKey: .places)
          
      }
}

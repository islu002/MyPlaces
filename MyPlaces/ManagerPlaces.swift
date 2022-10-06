//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import Foundation

class ManagerPlaces {
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
}

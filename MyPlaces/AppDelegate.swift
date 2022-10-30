//
//  AppDelegate.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //2.5.1
        let manager = ManagerPlaces.shared()
        let pl = Place(name: "Test PLace", description: "More info", image_int: nil)
        pl.location = CLLocationCoordinate2D(latitude: 42.265281, longitude: 2.958205)
        manager.places.append(pl)
        
        let pl2 = Place(name: "Test2 PLace2", description: "More info2", image_int: nil)
        pl2.location = CLLocationCoordinate2D(latitude: 41.972979, longitude: 2.825447)
        manager.places.append(pl2)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


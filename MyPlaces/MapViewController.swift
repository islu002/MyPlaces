//
//  MapViewController.swift
//  MyPlaces
//
//  Created by uoc on 6/10/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate  {

    // MARK: - Variables
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManger = CLLocationManager()
    var manager = ManagerPlaces.shared().places
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*let pinlocation = CLLocationCoordinate2D(latitude: 42, longitude: 3)
        setPinUsingMKPlacemark(location: pinlocation)*/
        
        mapView.delegate = self
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManger.startUpdatingLocation()
            print("LOCATION", locationManger.location?.coordinate)
            var pin = MKPlacemark(coordinate: locationManger.location!.coordinate)
            let region = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(region, animated: true)
            annotation.coordinate = pin.coordinate
            annotation.title = "Estoy aquí!"
            
            mapView.addAnnotation(annotation)
        }
        
        addPlacesPin()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData), name: NSNotification.Name(rawValue: "newOrUpdateElement"), object: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func setPinUsingMKPlacemark(location: CLLocationCoordinate2D) {
       let pin = MKPlacemark(coordinate: location)
       let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)

       mapView.setRegion(coordinateRegion, animated: true)
       mapView.addAnnotation(pin)
    }
    
    func addPlacesPin() {
        manager.forEach { place in
            let pin = MKPlacemark(coordinate: place.location)
            var annotationPin = MKPointAnnotation()
            annotationPin.coordinate = pin.coordinate
            annotationPin.title = place.name
            mapView.addAnnotation(annotationPin)
        }
    }
    
    @objc func refreshData() {
       mapView.annotations.forEach { notation in
           if !(notation.isEqual(annotation)) {
               mapView.removeAnnotation(notation)
           }
       }
       manager = ManagerPlaces.shared().places
    }
    
}

extension MapViewController: MKMapViewDelegate {

   func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
       print("didSelectAnnotationTapped", view)
       let dc = self.storyboard?.instantiateViewController(withIdentifier: "idDetailController") as! DetailController
       print(view.annotation)
       let index = manager.firstIndex(where: {$0.name == view.annotation?.title &&
           $0.location.latitude == view.annotation?.coordinate.latitude &&
           $0.location.longitude == view.annotation?.coordinate.longitude})
       dc.place = manager[index!]
       self.present(dc, animated: true)
   }
}



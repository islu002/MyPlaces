//
//  NewViewController.swift
//  MyPlaces
//
//  Created by uoc on 29/9/22.
//

import UIKit
import CoreLocation

class NewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var selectType: UIPickerView!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var name: UITextField!
    
    let manager = ManagerPlaces.shared()
    var type = PlacesTypes.GenericPlace
    let types = ["Generic Place", "Tourist Place"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
            type = PlacesTypes.GenericPlace
        }
        else {
            type = PlacesTypes.TouristPlace
        }
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        image.image = UIImage(named: "sun.png")
        selectType.delegate = self
        selectType.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*func addPlace() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newOrUpdateElement"), object: nil)
    }*/

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePlace(_ sender: Any) {
        if (name.text!.isEmpty == false && notes.text.isEmpty == false && latitude.text?.isEmpty == false && longitude.text?.isEmpty == false) {
            var place = Place(name: name.text!, description: notes.text, image_int: nil)
            //place.image = image
            place.location = CLLocationCoordinate2D(latitude: Double(latitude.text!)!, longitude: Double(longitude.text!)!)
            manager.new(place)
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "ERROR", message: "Name, notes, latitude and longitude are required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

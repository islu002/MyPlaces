//
//  DetailControllerViewController.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import UIKit

class DetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    let types = ["Generic Place", "Tourist Place"]
    var manager = ManagerPlaces.shared()
    var index: Int = 0

    @IBOutlet weak var name: UITextField!

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var chooseType: UIPickerView!

    @IBOutlet weak var notes: UITextView!
    
    var place: Place!
    
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
            place.type = PlacesTypes.GenericPlace
        }
        else {
            place.type = PlacesTypes.TouristPlace
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = place.name
        notes.text = place.description
        image.image = UIImage(named: "sun.png")

        // Do any additional setup after loading the view.
        
        //self.constrainHeight.constant = 400
        chooseType.delegate = self
        chooseType.dataSource = self
        index = manager.GetPosition(place)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        if (place.type == PlacesTypes.TouristPlace) {
            chooseType.selectRow(1, inComponent: 0, animated: false)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
     @IBAction func close(_ sender: Any) {
     }
     // Pass the selected object to the new view controller.
    }
    */

    @IBAction func deletePlace(_ sender: Any) {
        manager.remove(place)
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func updatePlace(_ sender: Any) {
        if (name.text!.isEmpty == false && notes.text.isEmpty == false) {
            place.name = name.text!
            place.description = notes.text
            manager.update(place, index: index)
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "ERROR", message: "Name and notes are required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

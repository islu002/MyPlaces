//
//  DetailControllerViewController.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import UIKit

class DetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    // Places types
    let pickerElems1 = ["Generic Place", "Tourist Place"]
    
    var manager = ManagerPlaces.shared()
    var index: Int = 0

    @IBOutlet weak var viewPicker: UIPickerView!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    
    var place: Place? = nil
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElems1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerElems1[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
            place?.type = PlacesTypes.GenericPlace
        }
        else {
            place?.type = PlacesTypes.TouristPlace
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textName.text = place?.name
        textDescription.text = place?.description
        imagePicked.image = UIImage(named: "sun.png")

        // Do any additional setup after loading the view.
        
        //self.constrainHeight.constant = 400
        viewPicker.delegate = self
        viewPicker.dataSource = self
        index = manager.GetPosition(place!)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        if (place?.type == PlacesTypes.TouristPlace) {
            viewPicker.selectRow(1, inComponent: 0, animated: false)
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
        manager.remove(place!)
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func updatePlace(_ sender: Any) {
        if (textName.text!.isEmpty == false && textDescription.text.isEmpty == false) {
            place?.name = textName.text!
            place?.description = textDescription.text
            manager.update(place!, index: index)
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "ERROR", message: "Name and notes are required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func selectImage(_ sender: Any) {
        
    }
}

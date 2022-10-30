//
//  DetailControllerViewController.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import UIKit

class DetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
   
    // Places types
    let pickerElems1 = ["Generic Place", "Tourist Place"]
    
    var manager = ManagerPlaces.shared()
    var index: Int = 0

    @IBOutlet weak var viewPicker: UIPickerView!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var place: Place? = nil
    var keyboardHeight:CGFloat!
    var activeField: UIView!
    var lastOffset:CGPoint!
    var isNew = false
    
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
        if(isNew) {
            if (row == 0) {
                place?.type = PlacesTypes.GenericPlace
            }
            else {
                place?.type = PlacesTypes.TouristPlace
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraintHeight.constant = 400
        viewPicker.delegate = self
        viewPicker.dataSource = self
        
        if(place == nil) {
            btnUpdate.setTitle("New", for: UIControl.State.normal)
            isNew = true
            place = Place()
        }
        else {
            btnUpdate.setTitle("Update", for: UIControl.State.normal)
            textName.text = place?.name
            textDescription.text = place?.description
            if(place?.image == nil) {
                imagePicked.image = UIImage(named: "sun.png")
                
            }
            else {
                imagePicked.image = UIImage(data: (place?.image)!)
                
            }
    
            index = manager.GetPosition(place!)
        }
        
        // Soft keyboard Control
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        textName.delegate = self
        textDescription.delegate = self
    }
  
    override func viewDidAppear(_ animated: Bool) {
        if (place?.type == PlacesTypes.TouristPlace) {
            viewPicker.selectRow(1, inComponent: 0, animated: false)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func deletePlace(_ sender: Any) {
        manager.remove(place!)
        let manager = ManagerPlaces.shared()
        manager.UpdateObservers()
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func updatePlace(_ sender: Any) {
        if (textName.text!.isEmpty == false && textDescription.text.isEmpty == false) {
            place?.name = textName.text!
            place?.description = textDescription.text
            if(isNew) {
                place?.location = ManagerLocation.GetLocation()
                manager.append(place!)
            }
            else {
                manager.update(place!, index: index)
            }
            
            dismiss(animated: true, completion: nil)
            let manager = ManagerPlaces.shared()
            manager.UpdateObservers()
        }
        else {
            let alert = UIAlertController(title: "ERROR", message: "Name and notes are required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        if(isNew) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        view.endEditing(true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePicked.contentMode = .scaleAspectFit
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
        place?.image = imagePicked.image!.jpegData(compressionQuality: 1.0)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    private func textViewShouldBeginEditing(_ textView: UITextView) {
        activeField = textView
        lastOffset = self.scrollView.contentOffset
    }
    
    private func textViewShouldEndEditing(_ textView: UITextView) {
        if(activeField==textView) {
            activeField?.resignFirstResponder()
            activeField = nil
        }
    }
    
    private func textFieldShouldBeginEditing(_ textField: UITextView) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
   
    private func textFieldShouldEndEditing(_ textField: UITextView) {
        if(activeField==textField) {
            activeField?.resignFirstResponder()
            activeField = nil
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func hideKeyboard(notification: Notification) {
        if(keyboardHeight != nil){
            self.scrollView.contentOffset = CGPoint(x:self.lastOffset.x, y: self.lastOffset.y)
            self.constraintHeight.constant -= self.keyboardHeight
        }
        keyboardHeight = nil
    }
    
    @objc func showKeyboard(notification: Notification) {
        if(activeField != nil) {
            let userInfo = notification.userInfo!
            let keyboardScreenEndFrame = (userInfo[DetailController.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            keyboardHeight = keyboardViewEndFrame.size.height
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
            if (collapseSpace > 0) {
                self.scrollView.setContentOffset(CGPoint(x:
                self.lastOffset.x, y: collapseSpace + 10), animated: false)
                self.constraintHeight.constant += self.keyboardHeight
            }
            else {
                keyboardHeight = nil
            }
        }
    }

}

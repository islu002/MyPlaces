//
//  DetailControllerViewController.swift
//  MyPlaces
//
//  Created by uoc on 25/9/22.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var constrainHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.constrainHeight.constant = 400
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

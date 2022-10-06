//
//  NewViewController.swift
//  MyPlaces
//
//  Created by uoc on 29/9/22.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var constraintWeight: NSLayoutConstraint!
    
    
    let manager = ManagerPlaces.shared().places
    
    override func viewDidLoad() {
      
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        constraintWeight.constant = 400
        scrollView.contentSize = CGSize(width: 0.0, height: 1000)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addPlace() {
        
    }

}

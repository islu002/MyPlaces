//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by uoc on 26/9/22.
//

import UIKit

class FirstViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view: UITableView = (self.view as? UITableView)!;
                view.delegate = self
                view.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
     // Access to item using manager
       
     // Present detail controller
       
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
           return 100
     
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: UITableViewCell
            cell = UITableViewCell()
            
            let wt: CGFloat = tableView.bounds.size.width
            
            
            // Add subviews to cell
            // UILabel and UIImageView
            
            var label: UILabel
            label = UILabel(frame: CGRect(x:0,y:0,width:wt,height:40))
            let fuente: UIFont = UIFont(name: "Arial", size: 12)!
            label.font = fuente
            label.numberOfLines = 4
            label.text = "hola"
            label.sizeToFit()
            cell.contentView.addSubview(label)
            
            /*let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
            imageIcon.frame = CGRect(x:10, y:50, width:50, height:50)
            cell.contentView.addSubview(imageIcon)
            */
            
            return cell
        }
        
}

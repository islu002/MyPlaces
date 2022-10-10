//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by uoc on 26/9/22.
//

import UIKit

class FirstViewController : UITableViewController {
    @IBOutlet weak var loadingView: UIView!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var manager = ManagerPlaces.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoader()
        let view: UITableView = (self.view as? UITableView)!;
                view.delegate = self
                view.dataSource = self
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "deleteElement"), object: nil)
        
        //disableLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
            self.disableLoader()
            print("pasaron los 3 segundos")
        }
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        //return manager.count
        return manager.GetCount()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
     // Access to item using manager
       // let selected = manager[indexPath.row]
        let selected = manager.GetItemAt(position: indexPath.row)
     // Present detail controller
        let dc = self.storyboard?.instantiateViewController(withIdentifier: "idDetailController") as! DetailController
        dc.place = selected
        //dc.image = UIImageView(image: UIImage(named: "sun.png"))
        //dc.notes.text = "HOLa"
        self.present(dc, animated: true)
       
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
        label = UILabel(frame: CGRect(x:90,y:10,width:wt,height:40))
        let fuente: UIFont = UIFont(name: "Arial", size: 18)!
        label.font = fuente
        label.numberOfLines = 1
        //label.text = manager[indexPath.row].name
        label.text = manager.GetItemAt(position: indexPath.row).name
        label.sizeToFit()
        cell.contentView.addSubview(label)
        
        var description: UILabel
        description = UILabel(frame: CGRect(x:90,y:50,width:wt,height:40))
        let fuenteDescription: UIFont = UIFont(name: "Arial", size: 12)!
        description.font = fuenteDescription
        description.numberOfLines = 4
        //description.text = manager[indexPath.row].description
        description.text = manager.GetItemAt(position: indexPath.row).description
        description.sizeToFit()
        cell.contentView.addSubview(description)
            
        let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
        imageIcon.frame = CGRect(x:10, y:10, width:80, height:80)
        cell.contentView.addSubview(imageIcon)
        
        
        return cell
    }
    
    @objc func refresh(){
        //manager = ManagerPlaces.shared().places
        setLoader()
        manager = ManagerPlaces.shared()
        self.tableView.reloadData()
        disableLoader()
    }

    func setLoader() {
        loadingView.isHidden = false
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func disableLoader() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingView.frame = CGRect(x:0, y:0, width: 0, height: 0)
        loadingView.isHidden = true
    }
        
}

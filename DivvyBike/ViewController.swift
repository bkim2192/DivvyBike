//
//  ViewController.swift
//  DivvyBike
//
//  Created by Brandon Kim on 9/3/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var itemButton: UIBarButtonItem!
    var seconds = 0
    var timer = Timer()
    var stationsArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        JSON()
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    @IBAction func itemCancel(_ sender: Any) {
        shouldPerformSegue(withIdentifier: "seguee", sender: (Any).self)
       
    }
    
    
    
    
    @IBAction func switchedView(_ sender: Any) {
                if segmentedControl.selectedSegmentIndex == 0 {
                    
                    self.navigationItem.title = "Stations of Chicago"
                    
                    
                    
                } else {
                    
                    performSegue(withIdentifier: "seguee", sender: segmentedControl)
                    segmentedControl.selectedSegmentIndex = 0
                    
                }
                
        
    }
    
    
    @objc func action() {
        seconds += 1
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        tableView.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 0.1, green: 0.5, blue: 0.6, alpha: 1.0)
        cell.textLabel?.text = "\(stationsArray[indexPath.row])"
        
        return cell
    }
    func JSON() {
        let url = URL(string: "https://data.cityofchicago.org/resource/aavc-b2wj.json")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                var outerLayer = jsonObject as! NSArray
                for section in outerLayer {
                    let section = section as! NSDictionary
                    let name = section.object(forKey: "station_name") as!String
                    self.stationsArray.append(name)
                }
                
                
                DispatchQueue.main.async {
                    self.navigationItem.title = "Stations of Chicago"
                    self.tableView.reloadData()
                }
                
                
            }
            
        }
    .resume()
    }
    
    
    
}


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
    var stationsArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        JSON()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        tableView.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.backgroundColor = .systemBlue
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
                    self.navigationItem.title = "Weather For: "
                    self.tableView.reloadData()
                }
                
                
            }
            
        }
    .resume()
    }
    
    
    
}


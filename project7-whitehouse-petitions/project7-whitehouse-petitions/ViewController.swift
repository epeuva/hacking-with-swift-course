//
//  ViewController.swift
//  
//
//  Created by epeuva on 20/08/2018
//  Copyright © 2018 epeuva. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // Array of dictionaries.
    var petitions = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        // Ensures that the url is safe
        if let url = URL(string: urlString) {
            
            // Get the URL contents
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parse(json: json)
                }
            }
         }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // DetailViewController isn't in storyboard. So we can load the class directly
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// Parses the recieved Whitehouse petitions JSON in order to save the important fields of the petitions and reloads the tableView data
    ///
    /// - Parameter json: The result JSON to be parsed (Whitehouse petitions)
    func parse(json: JSON) {
        for result in json["results"].arrayValue {              // Array of objects or Empty array
            let title = result["title"].stringValue             // String value or Empty String
            let body = result["body"].stringValue               // String value or Empty String
            let sigs = result["signatureCount"].stringValue     // String value or Empty String
            let obj = ["title": title, "body": body, "sigs": sigs]
            
            print(obj)
            petitions.append(obj)
        }
        tableView.reloadData()
    }

}


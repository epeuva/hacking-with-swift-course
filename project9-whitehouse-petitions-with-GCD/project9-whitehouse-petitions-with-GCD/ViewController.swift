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

        // Pass the method fetchJSON to the background thread. #selector requires @objc when calling the function
        performSelector(inBackground: #selector(fetchJSON), with:nil)
        
    }
    
    
    /// Recovers all petition info from the Whitehouse servers.
    /// @objc is required as we are calling this function with #selector(fetchJSON).
    @objc func fetchJSON() {
        
        let urlString: String
        
        // Checks if the tabBarItem is 'Most Recent' or 'Top Rated'. See AppDelegate.swift.
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        // Ensures that the url is safe
        if let url = URL(string: urlString) {
            
            // Get the URL contents
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    self.parse(json: json)
                    return
                }
            }
        }
        
        // Pass the method showError to the main thread.
        performSelector(onMainThread: #selector(showError), with:nil, waitUntilDone: false)
        
    }
    
    
    /// Creates an UIAlertController in order to show a loading error to the user
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
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
        for result in json["results"].arrayValue {                                                              // Array of objects or Empty array
            let title = result["title"].stringValue                                                             // String value or Empty String
            let body = result["body"].stringValue.replacingOccurrences(of: "\n", with: "<br>")                  // String value or Empty String. Replaces \n with <br>
            let sigs = result["signatureCount"].stringValue                                                     // String value or Empty String
            let obj = ["title": title, "body": body, "sigs": sigs]
            
            petitions.append(obj)
        }
        
        // Without tableView an NSException with unrecognized selector sent to instance XXX is thrown
        tableView.performSelector(onMainThread:#selector(UITableView.reloadData), with: nil, waitUntilDone:false)
    }

}


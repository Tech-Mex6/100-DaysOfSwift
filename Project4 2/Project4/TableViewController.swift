//
//  TableViewController.swift
//  Project4
//
//  Created by meekam okeke on 9/26/20.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    var websites = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websites += ["apple.com", "hackingwithswift.com", "google.com", "puma.com", "hgtv.com", "adidas.com","samsung.com"]
        title = "Meekam's Webview"
                
        print(websites)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = (storyboard?.instantiateViewController(identifier: "Detail")) as? DetailViewController{
            
            vc.selectedWebsite = websites[indexPath.row]
            vc.listOfWebsites = websites
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

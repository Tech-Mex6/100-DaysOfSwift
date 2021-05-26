//
//  ViewController.swift
//  Project 1
//
//  Created by meekam okeke on 9/17/20.
//  Copyright © 2020 meekam okeke. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                // this is a picture to load
                pictures.append(item)
            }
        }
        print(pictures)
        pictures.sort()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = (storyboard?.instantiateViewController(identifier: "Detail")) as? DetailViewController{
            vc.totalPicture = pictures.count
            vc.selectedImageNumber = indexPath.row + 1
            vc.selectedImage = pictures[indexPath.row]
    
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}


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
    var picDictionary = [String: Int]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "picDictionary") as? Data{
            let savedPictures = defaults.object(forKey: "pictures") as? Data
            let jsonDecoder = JSONDecoder()
            do{
                picDictionary = try jsonDecoder.decode([String: Int].self, from: savedData)
                pictures = try jsonDecoder.decode([String].self, from: savedPictures!)
            }catch{
                print("Failed to load saved data.")
            }
        }else{
            performSelector(inBackground: #selector(loadPictures), with: nil)
        }

        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)

    }
    @objc func loadPictures(){
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                // this is a picture to load
                pictures.append(item)
                picDictionary[item] = 0
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture
        cell.detailTextLabel?.text = "Viewed \(picDictionary[picture]!) times."
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = (storyboard?.instantiateViewController(identifier: "Detail")) as? DetailViewController{
            vc.totalPicture = pictures.count
            vc.selectedImageNumber = indexPath.row + 1
            vc.selectedImage = pictures[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
        let picture = pictures[indexPath.row]
        picDictionary[picture]! += 1
        save()
        tableView.reloadData()
        
    }
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(picDictionary){
            let savedPictures = try? jsonEncoder.encode(pictures)
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "picDictionary")
            defaults.set(savedPictures, forKey: "pictures")
        }else{
            print("Failed to save data.")
        }

    }


}


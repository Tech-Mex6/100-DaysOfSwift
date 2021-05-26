//
//  DetailViewController.swift
//  Project 1
//
//  Created by meekam okeke on 9/18/20.
//  Copyright © 2020 meekam okeke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String?
    var selectedImageNumber = 0
    var totalPicture: Int = 0
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(selectedImageNumber) of \(totalPicture)"
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButton))
        
        if let imageToLoad = selectedImage{
            ImageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    @objc func shareButton(){
        guard let url = URL.init(string: "https://www.stormviewer.com")else{
            print("url not found")
            return
        }
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }

}

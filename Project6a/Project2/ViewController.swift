//
//  ViewController.swift
//  Project2
//
//  Created by meekam okeke on 9/21/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(scoreReveal))
        
        askQuestion()
        
    }
    @objc func scoreReveal(){
        let message = "The score is \(score)"
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = " Country: \(countries[correctAnswer].uppercased()) Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        questionsAnswered += 1
        
        if questionsAnswered < 10 {
            let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(alertController, animated: true, completion: nil)
        }else {
            let alertController = UIAlertController(title: title, message: "Game Over, your final score is \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: askQuestion))
            present(alertController, animated: true, completion: nil)
            score = 0
        }
    }
    
}


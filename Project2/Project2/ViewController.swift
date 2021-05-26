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
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreReveal))
        
        let defaults = UserDefaults.standard
        
        if let highScore = defaults.value(forKey: "highScore") as? Int{
            self.highScore = highScore
            print("successfully loaded high score")
        }else{
            print("failed to load high score.")
        }
        
        askQuestion()
        
    }
    @objc func scoreReveal(){
        let scoreAlert = UIAlertController(title: "Score", message: nil, preferredStyle: .actionSheet)
        scoreAlert.addAction(UIAlertAction(title: "Your current score is \(score)", style: .default, handler: nil))
        scoreAlert.addAction(UIAlertAction(title: "Your current high score is \(highScore)", style: .default, handler: nil))
        
        present(scoreAlert, animated: true, completion: nil)

    }
    func askQuestion(action: UIAlertAction! = nil){
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = " Country: \(countries[correctAnswer].uppercased())"
        questionsAnswered += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            sender.transform = .identity
        })

        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        
        if questionsAnswered < 10 {
            let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true, completion: nil)
            
        }else if score > highScore {
            highScore = score
            save()
            let highScoreAC = UIAlertController(title: "New high score!", message: "Your score is \(score).", preferredStyle: .alert)
            highScoreAC.addAction(UIAlertAction(title: "New Game", style: .default, handler: newGame))
            present(highScoreAC, animated: true)
        }else{
            let alertController = UIAlertController(title: title, message: "Game Over, your final score is \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: newGame))
            present(alertController, animated: true, completion: nil)
        }
    }
    func save(){
        let defaults = UserDefaults.standard
        do{
            defaults.set(highScore, forKey: "highScore")
        }catch{
            print("Failed to save high score.")
        }
    }
    func newGame(action: UIAlertAction){
        score = 0
        questionsAnswered = 0
        
        askQuestion()
    }
    
}


//
//  ViewController.swift
//  Project5
//
//  Created by meekam okeke on 9/29/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var errorTitle = String()
    var errorMessage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        startGame()
    }
    @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row].lowercased()
        return cell
    }
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        
        
        if isPossible(word: lowerAnswer){
        
        } else{
            showErrorMessage(errorTitle:"Word not possible" , errorMessage: "You cant spell that word from \(title!.lowercased()).")
            return
        }
        if isOriginal(word: lowerAnswer){
            
        } else{
            showErrorMessage(errorTitle: "Word already used", errorMessage: "Spend more time with your dictionary.")
            return
        }
        if isReal(word: lowerAnswer){
            
        } else{
            showErrorMessage(errorTitle: "Word not recognized", errorMessage: "You can't just make shit up")
            return
        }
        usedWords.insert(answer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }
    
    func isPossible(word: String)-> Bool{
        guard var tempWord = title?.lowercased() else{return false}
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        return true
    }
    func isOriginal(word: String)-> Bool{
        return !usedWords.contains(word)
    }
    func isReal(word: String)-> Bool{
        if word.count < 3 || word == title{
            return false
        }else{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        }
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}

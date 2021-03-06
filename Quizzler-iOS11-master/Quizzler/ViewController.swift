//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit


// Represents Controller in MVC
class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions : QuestionBank = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let firstQuestion : Question = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: " + String(score)
        // or we can use
        //scoreLabel.text = "Score: \(score)"
        
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        let frameSize : CGSize = view.frame.size
        let progressBarSize : CGSize = progressBar.frame.size
        progressBar.frame.size = CGSize(width: (frameSize.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1), height: progressBarSize.height)
    }
    

    func nextQuestion() {
        if questionNumber < allQuestions.list.count {
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            updateUI()
            
        }else{
            // Alert put in here
            let alert = UIAlertController(title: "Awesome", message: "You finish all the questions, do you wont to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            //print("You got it!")
            ProgressHUD.showSuccess("Correct")
            score += 1
        }else{
            //print("Wrong!")
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
}

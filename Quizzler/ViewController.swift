//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank();
    var pickedAnswer : Bool = false;
    var questionNumber : Int = 0;
    var score : Int = 0;
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion();
    }
    
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true;
        }
        if sender.tag == 2 {
            pickedAnswer = false;
        }
        
        checkAnswer();
        
        questionNumber = questionNumber + 1;
        nextQuestion();
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)";
        
        progressLabel.text = "\(questionNumber + 1) / 13";
        
        //progress bar
        progressBar.frame.size.width = (view.frame.size.width / 13 ) * CGFloat(questionNumber + 1);
    }
    
    
    func nextQuestion() {
        if(questionNumber != allQuestions.list.count) {
            questionLabel.text = allQuestions.list[questionNumber].question;
            updateUI();
        } else {
            print("Reached the end of questions.")
            
            //Creates a Alert
            let alert = UIAlertController(title: "Awesome", message: "All questions are done,Do you want to start over?", preferredStyle: UIAlertController.Style.alert);
            
            //Adds a button to that alert
            let action = UIAlertAction(title: "Restart the Game", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.startOver();
            }
            
            //adds the action to that alert
            alert.addAction(action);
            
            //presents to the user
            present(alert, animated: true, completion: nil);
        }
    }
    
    
    func checkAnswer() {
        if allQuestions.list[questionNumber].answer == pickedAnswer {
            print("You got it!");
            score = score + 1;
            
            //Show the msg on the UI and not requiring any prompt
            ProgressHUD.showSuccess("Correct")
        } else {
            print("Wrong!.")
            ProgressHUD.showError("Wrong!");
        }
    }
    
    
    func startOver() {
        questionNumber = 0;
        score = 0;
        
        nextQuestion();
    }
    
    
}

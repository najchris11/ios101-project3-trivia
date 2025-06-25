//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Christian Coulibaly on 6/24/25.
//

import UIKit

class TriviaViewController: UIViewController {
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionDisplay: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    let questions: [Question] = [
        Question(prompt: "Which planet is known as the Red Planet?", options: ["Venus", "Mars", "Jupiter", "Saturn"], correctAnswerIndex: 1),
        Question(prompt: "Who wrote the play 'Romeo and Juliet'?", options: ["William Shakespeare", "Charles Dickens", "Jane Austen", "Mark Twain"], correctAnswerIndex: 0),
        Question(prompt: "What is the capital city of Japan?", options: ["Seoul", "Beijing", "Tokyo", "Bangkok"], correctAnswerIndex: 2),
        Question(prompt: "Which element has the chemical symbol 'O'?", options: ["Gold", "Oxygen", "Osmium", "Iron"], correctAnswerIndex: 1)
    ]
    
    var currentQuestionIndex = 0
    var score = 0
    
    
    func showQuestion() {
        let question = questions[currentQuestionIndex]
        questionNum.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
        categoryLabel.text = "Entertainment: Video Games"
        questionDisplay.text = question.prompt
        
        option1.setTitle(question.options[0], for: .normal)
        option2.setTitle(question.options[1], for: .normal)
        option3.setTitle(question.options[2], for: .normal)
        option4.setTitle(question.options[3], for: .normal)
    }
    @IBAction func answerTapped(_ sender: UIButton) {
        let selectedIndex: Int
        switch sender {
            case option1: selectedIndex = 0
            case option2: selectedIndex = 1
            case option3: selectedIndex = 2
            case option4: selectedIndex = 3
            default: return
        }
        
        let isCorrect = selectedIndex == questions[currentQuestionIndex].correctAnswerIndex
        if isCorrect {
            score += 1
        }
        
        sender.backgroundColor = isCorrect ? .systemGreen : .systemRed
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        self.nextQuestion()
    }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < questions.count {
        [option1, option2, option3, option4].forEach {
        $0?.backgroundColor = .systemGray5
    }
        showQuestion()
    } else {
        showFinalScore()
    }
    }
    
    func showFinalScore() {
        let alert = UIAlertController(
        title: "Quiz Complete!",
    message: "Your score is \(score)/\(questions.count)",
    preferredStyle: .alert
    )
        
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
        self.restartQuiz()
    }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        [option1, option2, option3, option4].forEach {
        $0?.isHidden = false
        $0?.backgroundColor = .systemBlue
    }
        showQuestion()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
        // Do any additional setup after loading the view.
    }

}

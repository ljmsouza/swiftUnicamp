//
//  ViewController.swift
//  Quiz
//
//  Created by Lucas on 4/13/16.
//  Copyright © 2016 Lucas Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var btnFeedback: UIButton!
    
    var questions : [Question]! // vetor de perguntas
    var currentQuestion = 0     // Int que indica a questao atual
    var grade = 0.0             // Double para nota
    var quizEnded = false       // Bool para saber se terminou ou nao

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let q0answer0 = Answer(answer: "120 anos", isCorrect: true)
        let q0answer1 = Answer(answer: "80 anos", isCorrect: false)
        let q0answer2 = Answer(answer: "140 anos", isCorrect: false)
        let question0 = Question(question: "Quantos anos vive em média um elefante africano?", strImageFileName: "elefante", answers: [q0answer0, q0answer1, q0answer2])
        
        let q1answer0 = Answer(answer: "5,5 m", isCorrect: true)
        let q1answer1 = Answer(answer: "3,5 m", isCorrect: false)
        let q1answer2 = Answer(answer: "4,5 m", isCorrect: false)
        let question1 = Question(question: "Quantos metros em média tem uma girafa macho adulta?", strImageFileName: "girafa", answers: [q1answer0, q1answer1, q1answer2])
        
        let q2answer0 = Answer(answer: "2300 kg", isCorrect: true)
        let q2answer1 = Answer(answer: "3300 kg", isCorrect: false)
        let q2answer2 = Answer(answer: "4300 kg", isCorrect: false)
        let question2 = Question(question: "Quanto pesa em média um rinoceronte-branco macho adulto?", strImageFileName: "rinoceronte", answers: [q2answer0, q2answer1, q2answer2])
        
        let q3answer0 = Answer(answer: "64 km/h", isCorrect: true)
        let q3answer1 = Answer(answer: "74 km/h", isCorrect: false)
        let q3answer2 = Answer(answer: "54 km/h", isCorrect: false)
        let question3 = Question(question: "Qual a velocidade de uma zebra?", strImageFileName: "zebra", answers: [q3answer0, q3answer1, q3answer2])
        
        questions = [question0, question1, question2, question3]
        
        startQuiz() // comeca aqui
    }
    
    func startQuiz() {
        questions.shuffle() // embaralha questoes
        
        for question in questions {
            question.answers.shuffle()  // embaralha respostas
        }
        
        // reseta as variaveis de progresso do usuario
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        
        showQuestion(0) // mostra a primeiraQuestao
    }
    
    func showQuestion(questionId : Int) {
        btnAnswer1.enabled = true
        btnAnswer2.enabled = true
        btnAnswer3.enabled = true
        
        // atualiza o label da questao, imagem e texto dos 3 botoes
        lbQuestion.text = questions[questionId].strQuestion
        imgQuestion.image = questions[questionId].imgQuestion
        btnAnswer1.setTitle(questions[questionId].answers[0].strAnswer, forState: UIControlState.Normal)
        btnAnswer2.setTitle(questions[questionId].answers[1].strAnswer, forState: UIControlState.Normal)
        btnAnswer3.setTitle(questions[questionId].answers[2].strAnswer, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }

    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    func selectAnswer(answerId : Int) {
        // desabilita botoes de alternativa para que nao se possa clicar 2 vezes
        btnAnswer1.enabled = false
        btnAnswer2.enabled = false
        btnAnswer3.enabled = false
        
        viewFeedback.hidden = false
        
        let answer : Answer = questions[currentQuestion].answers[answerId] // seleciona resposta
        
        if answer.isCorrect == true {
            grade = grade + 1.0 // soma um ponto se correto
            lblFeedback.text = answer.strAnswer + "\n\n Resposta correta!"
        } else {
            lblFeedback.text = answer.strAnswer + "\n\n Resposta errada..."
        }
        
        if currentQuestion < questions.count-1 {
            btnFeedback.setTitle("Próxima", forState: UIControlState.Normal)
        } else {
            btnFeedback.setTitle("Ver nota", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func feedbackAction(sender: AnyObject) {
        viewFeedback.hidden = true
        
        if quizEnded {
            startQuiz()
        } else {
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        currentQuestion += 1
        
        if currentQuestion < questions.count {
            showQuestion(currentQuestion)
        } else {
            endQuiz()
        }
    }
    
    func endQuiz() {
        grade = grade / Double(questions.count) * 100.0 // Calcula nota
        quizEnded = true
        viewFeedback.hidden = false
        lblFeedback.text = "Sua nota: \(grade)"
        btnFeedback.setTitle("Refazer", forState: UIControlState.Normal)
    }

}


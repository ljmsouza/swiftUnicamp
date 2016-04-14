//
//  QuizModel.swift
//  Quiz
//
//  Created by Lucas on 4/13/16.
//  Copyright © 2016 Lucas Souza. All rights reserved.
//

import Foundation
import UIKit

class Question {
    var strQuestion : String!   // String da questao
    var imgQuestion : UIImage!  // UIImage para armazenar a imagem da questao
    var answers : [Answer]!     // Vetor com as respostas
    
    init(question : String, strImageFileName : String, answers : [Answer]) {
        self.strQuestion = question
        self.imgQuestion = UIImage(named: strImageFileName)
        self.answers = answers
    }
}

class Answer {
    var strAnswer : String! // String da resposta
    var isCorrect : Bool!   // Bool para saber se é correta ou nao
    
    init(answer : String, isCorrect : Bool) {
        self.strAnswer = answer
        self.isCorrect = isCorrect
    }
}
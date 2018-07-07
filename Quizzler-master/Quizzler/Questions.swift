//
//  Questions.swift
//  Quizzler
//
//  Created by ritu sharma on 2/03/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Questions
{
    let questionText : String
    let answers : Bool
    
    init(text : String, correctAnswer: Bool)
    {
        questionText = text
        answers = correctAnswer
    }
}

class otherClass
{
    let question1 = Questions(text : "What is the meaning of life?", correctAnswer : true)
    let question2 = Questions(text : "what is the name of the best song ever", correctAnswer : false)
}

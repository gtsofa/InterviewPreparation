//
//  QuestionPresenter.swift
//  QuizAppRE
//
//  Created by Julius on 07/03/2021.
//

import Foundation
import QuizEngineRevisit

struct QuestionPresenter {
    let questions: [Question<String>] // all questions so that we can find index of a question
    let question: Question<String> // current question
    
    // computed string value
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return ""}
        return "Question #\(index + 1)"
    }
}

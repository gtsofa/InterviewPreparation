//
//  QuestionPresenterTest.swift
//  QuizAppRETests
//
//  Created by Julius on 07/03/2021.
//

import XCTest
import QuizEngineRevisit
@testable import QuizAppRE

class QuestionPresenterTest: XCTestCase {
    let question1 = Question.singleAnswer("A1")
    let question2 = Question.multipleAnswer("A2")
    
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1], question: question1)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistingQuestion_returnsEmpty() {
        let question3 = Question.multipleAnswer("A3")
        
        let sut = QuestionPresenter(questions: [question1, question2], question: question3)
        
        XCTAssertEqual(sut.title, "")
    }
}

//
//  iOSViewControllerFactoryTest.swift
//  QuizAppRETests
//
//  Created by Julius on 19/02/2021.
//

import XCTest
@testable import QuizEngine
@testable import QuizAppRE


class iOSViewControllerFactoryTest: XCTestCase {
    let options = ["A1", "A1"]
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    
    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let question = singleAnswerQuestion
        let presenter = QuestionPresenter(questions: [question], question: question)
        
        XCTAssertEqual(makeQuestionController(question: question).title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController(question: singleAnswerQuestion)
        XCTAssertFalse(controller.allowsMultipleSelection)
        //_ = controller.view
        
        //XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
        let controller = makeQuestionController(question: multipleAnswerQuestion)
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // Results
    func test_resultsViewController_createsControllerWithSummary() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithTitle() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.title, results.presenter.title)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswer
    () {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }
    
    // MARK: Helpers
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswers: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController{
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let result = Result.make(answers: userAnswers, score: 2)
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        
        let sut = makeSUT(correctAnswers: correctAnswers)
        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        return (controller, presenter)
    }
}

//
//  ResultsViewControllerTest.swift
//  QuizAppRETests
//
//  Created by Julius on 08/02/2021.
//

import XCTest
@testable import QuizAppRE 

class ResultsViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "a summary", answers: []).headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_rendersAnswer() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    // correct answer cell
    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1")

        let sut = makeSUT(answers: [answer])
        
        // we've removed the ! replaced with ? as we don't want crush
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }

    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")

        let sut = makeSUT(answers: [answer])

        // we've removed the ! replaced with ? as we don't want crush
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    //MARK: Helpers
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut  = ResultsViewController(summary: summary, answers: answers)

        _ = sut.view
        return sut
    }
    
    // factory method
    func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil,  isCorrect: Bool = false) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
}

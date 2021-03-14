//
//  NavigationControllerRouterTest.swift
//  QuizAppRETests
//
//  Created by Julius on 10/02/2021.
//
import UIKit
import XCTest
import QuizEngineRevisit
@testable import QuizAppRE

class NavigationControllerRouterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    

    let navigationController = FakeNavigationController() //UINavigationController
    let factory = ViewControllerFactoryStub()
    lazy var  sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
        
    }()
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondViewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        var callbackWasFired = false
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgressesToNextQuestion() {
        var callbackWasFired = false
        
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertFalse(callbackWasFired)
    }
    
    func test_routeToQuestion_singleAnswer_doesNotConfigureViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        
        factory.stub(question: singleAnswerQuestion, with: viewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in})

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in}) // empty answer call back
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"]) // with answers
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([]) // empty answers
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        var callbackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callbackWasFired = true})
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        let button = viewController.navigationItem.rightBarButtonItem!
        button.target!.performSelector(onMainThread: button.action!, with: nil, waitUntilDone: true)
        
        XCTAssertTrue(callbackWasFired)
    }
    
    // route to ResultsController
    /*func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let result = Result.make(answers: [Question.singleAnswer("Q1"): "A1"], score: 10)
        
        let secondViewController = UIViewController()
        let secondResult = Result.make(answers: [Question.singleAnswer("Q2"): "A2"], score: 20)
      
        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)
    
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    */
    
    //MARK: Helpers
    
    //when u want to test for animated behaviour
    class FakeNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool ) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    // stub for
    class ViewControllerFactoryStub: ViewControllerFactory {
    
        private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
        /*private var stubbedResults = Dictionary<Result<Question<String>, String>, UIViewController>() */
        var answerCallback = Dictionary<Question<String>, ([String]) -> Void>()
        
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            //stubbedQuestions of question = viewController
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: Result<Question<String>, String>, with viewController: UIViewController) {
            //stubbedQuestions of question = viewController
            /*stubbedResults[result] = viewController*/
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            
            self.answerCallback[question] = answerCallback
            //returns unoptional we force unwrap it ..its ok because it lives in our test so when it crashes we know test have issues
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            /*return stubbedResults[result] ?? UIViewController()*/
            return UIViewController()
        }
    }
}


// Results to conform to Hashable..make fake hashable for our tests
/*extension Result: Hashable {
    
    init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
    
    public var hashValue: Int {
        return 1
    }
    
    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}*/

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}



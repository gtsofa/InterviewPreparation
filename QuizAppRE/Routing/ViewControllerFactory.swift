//
//  ViewControllerFactory.swift
//  QuizAppRE
//
//  Created by Julius on 19/02/2021.
//

import UIKit
import QuizEngineRevisit

protocol
ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}

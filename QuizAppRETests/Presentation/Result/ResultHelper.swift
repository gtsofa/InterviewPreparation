//
//  ResultHelper.swift
//  QuizAppRETests
//
//  Created by Julius on 20/02/2021.
//

import Foundation
@testable import QuizEngineRevisit

extension Result: Hashable {
    
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Result<Question, Answer> {
        return Result(answers: answers, score: score)
    }
    
    public var hashValue: Int {
        return 1
    }
//    func hash(into hasher: inout Hasher) -> Int {
//        return 1
//    }
    
    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}

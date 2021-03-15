//
//  SceneDelegate.swift
//  QuizAppRE
//
//  Created by Julius on 06/02/2021.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let question1 = Question.singleAnswer("What's Mike's nationality?")
        let question2 = Question.multipleAnswer("What are Caio's nationalities?")
        
        let questions = [question1, question2]
        
        let option1 = "Canadian"
        let option2 = "American"
        let option3 = "Greek"
        let options = [option1, option2, option3]
        
        let option4 = "Portuguese"
        let option5 = "American"
        let option6 = "Brazilian"
        let options2 = [option4, option5, option6]
        
        let correctAnswers = [question1: [option3], question2: [option4, option6]]
        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(questions: questions, options: [question1: options, question2: options2], correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        // windows stuff
        //window = UIWindow(frame: UIScreen.main.bounds)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        game = startGame(question: questions, router: router, correctAnswers: correctAnswers)
        
        // hard coded stuff :-)
        /*guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        /*let controller = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"]) {
            print($0)
        }*/
        let controller = ResultsViewController(summary: "You got 1/2 correct", answers: [PresentableAnswer(question: "Question?? Question?? Question?? Question?? Question?? Question??", answer: "Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah!", wrongAnswer: nil),
         PresentableAnswer(question: "Another Question??", answer: "Hell yeah!", wrongAnswer: "Hell no man!")])
        
        _ = controller.view
        controller.tableView.allowsMultipleSelection = true //true
        window.rootViewController = UINavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
        self.window = window*/
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


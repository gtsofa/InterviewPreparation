//
//  AppDelegate.swift
//  QuizAppRE
//
//  Created by Julius on 06/02/2021.
//

import UIKit
import QuizEngine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"], allowsMultipleSelection: false, selection: {
            print($0)
        })
        
        self.window = window
        window.makeKeyAndVisible()*/
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


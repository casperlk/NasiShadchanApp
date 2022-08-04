//
//  AppDelegate.swift
//  NasiShadchanHelper
//
//  Created by user on 4/24/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Firebase

import FirebaseAnalytics
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // var window: UIWindow?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    // solve dark mode by keeping it in light mode always
    var window: UIWindow? {
        didSet {
            window?.overrideUserInterfaceStyle = .light
        }
    }
    
    class func instance() -> AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    
    
    override init () {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        Database.database().isPersistenceEnabled = true
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        handle = Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.makingRootFlow(Constant.AppRootFlow.kAuthVc)
            } else {
                print("the state of user is \(user!.debugDescription)")
                self.makingRootFlow(Constant.AppRootFlow.kEnterApp)
            }
            
        }
        
        return true
    }
    
    
    
    func createNewDateInFirebase() {
        
        let boyName = "Joe Biden"
        let girlName = "Jill Rogers"
        let datingStatus = "Active"
        let dateNumber = "4"
        let boyAge = "22"
        let girlAge = "22"
        let shadchanNotes = "Cute Couple"
        let nasiProgram = "Sefardim"
        let dateCreated = "\(Date())"
        let dateLastUpdate: Int = 0
        
        let newDate = NasiDate(boyFullName: boyName, boysAge: boyAge, dateNumber: dateNumber, datingStatus: datingStatus, girlFullName: girlName, girlAge: girlAge, shadchanNotes: shadchanNotes, dateCreated: dateCreated, dateLastUpdate: dateLastUpdate, nasiProgram: nasiProgram)
        
        // get uid for current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let dateNodeRef = Database.database().reference().child("NasiDatesList").child(uid)
        
        let ref = dateNodeRef.childByAutoId()
        
        ref.setValue(newDate.toAnyObject())
    }
    
    
    // MARK:- MEthods
    private func setUpNavigationAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .yellow
        UINavigationBar.appearance().backgroundColor = .green
        UIBarButtonItem.appearance() .tintColor = UIColor.red
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white],
            for: .normal)
    }
    
    // MARK: - Making RootView Controller
    func makingRootFlow(_ strRoot: String) {
        
        self.window?.rootViewController?.removeFromParent()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if strRoot == Constant.AppRootFlow.kEnterApp {
            let tabBar = storyboard.instantiateViewController(withIdentifier: "MyTabBarController")
            
            window?.rootViewController = tabBar
            
        } else if strRoot == Constant.AppRootFlow.kAuthVc {
            
            let authStoryboard = UIStoryboard(name: "UserAuthentication", bundle: nil)
            
            let vcNav : AuthNavViewController = authStoryboard.instantiateViewController()
            
            window?.rootViewController = vcNav
        }
    }
    
    
    
}

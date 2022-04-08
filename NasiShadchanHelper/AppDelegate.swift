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
        
        //self.makingRootFlow(Constant.AppRootFlow.kAuthVc)
        //self.makingRootFlow(Constant.AppRootFlow.kEnterApp)
        
        application.applicationIconBadgeNumber = 5
        //Firebase.Analytics.setAnalyticsCollectionEnabled(true)

        // -- IQKeyboardManager---
        IQKeyboardManager.shared.enable = true
        
        
        handle = Auth.auth().addStateDidChangeListener { _, user in
          if user == nil {
             // print("the state of user is \(user!.debugDescription)")
              
              
              
              
              self.makingRootFlow(Constant.AppRootFlow.kAuthVc)
              
              
              
           // self.navigationController?.popToRootViewController(animated: true)
          } else {
              print("the state of user is \(user!.debugDescription)")
              
              
           // self.performSegue(withIdentifier: self.loginToList, sender: nil)
            //self.enterEmail.text = nil
            //self.enterPassword.text = nil
              self.makingRootFlow(Constant.AppRootFlow.kEnterApp)
          }
            
            
        
        }
        
        
        
        
       // if UserInfo.currentUserExists {
       //      self.makingRootFlow(Constant.AppRootFlow.kEnterApp)
       // } else {
      //       self.makingRootFlow(Constant.AppRootFlow.kAuthVc)
      //  }
        //setUpNavigationAppearance()
        // 3
         // (window?.rootViewController as? UITabBarController)?.selectedIndex = 1

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
        //let groceryItemRef = self.ref.child(text.lowercased())
        ref.setValue(newDate.toAnyObject())
    }
    
    /*
    // pass the url string
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        
        // pass the image
        guard let postImage = selectedImage else { return }
        
        // unwrap text from textView
        guard let caption = textView.text else { return }
        
        // get uid for current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // go to posts child node then to child uid
        let userPostRef = Database.database().reference().child("posts").child(uid)
        
        
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
    }
    */
  
   
    
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


    





































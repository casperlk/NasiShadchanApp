//
//  UserProfileVC.swift
//  NasiShadchanHelper
//
//  Created by test on 4/15/22.
//  Copyright © 2022 user. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UITableViewController {
    
    let shadchanListRef  = Database.database().reference().child("NasiShadchanUserList")
    
    var shadchanUser: ShadchanUser!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var numberOfYearsLabel: UILabel!
    
    @IBOutlet weak var familyTypeLabel: UILabel!
    
    @IBOutlet weak var singlesPlanLabel: UILabel!
    
    @IBOutlet weak var singlesTypeLabel: UILabel!
    
    @IBOutlet weak var needToMeetLabel: UILabel!
    
    @IBOutlet weak var welcomeBrainstormLabel: UILabel!
    @IBOutlet weak var yearsInShidduchimPrimary: UILabel!
    
    @IBOutlet weak var yearsInShidduchimSecondary: UILabel!
    @IBOutlet weak var communicationMethodPreferredLabel: UILabel!
    @IBOutlet weak var communicationMethodSecondaryLabel: UILabel!

    @IBOutlet weak var aboutLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        
    }
    
    func fetchUser(){
        
        /*
        func fetchAndCreateBoysArray() {

          let boysListRef  = Database.database().reference().child("NasiBoysList")
            
            guard let myId = UserInfo.curentUser?.id else {return}
            
            let currentUserBoysListRef = boysListRef.child(myId)
          
            currentUserBoysListRef.observe(.value, with: { snapshot in
            
             var boysArray: [NasiBoy] = []
                
                for child in snapshot.children {
                  
                let snapshot = child as? DataSnapshot
                let nasiBoy = NasiBoy(snapshot: snapshot!)
                    
                boysArray.append(nasiBoy)
            }
            self.shadchanBoysArray = boysArray
            self.tableView.reloadData()
                
          })
        }
       
        */
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("NasiShadchanUserList").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
           
            print(snapshot.value ?? "")
    
            //guard let dictionary = snapshot.value as? [String: Any] else { return }
            let snapshot = snapshot as DataSnapshot
            
            let currentUser = ShadchanUser(snapshot: snapshot)
            self.shadchanUser = currentUser
            self.tableView.reloadData()
            
            print("current user is \(currentUser.description)")
                
            //self.user = User(dictionary: dictionary)
            //self.navigationItem.title = self.user?.username
            
            //self.collectionView?.reloadData()
            self.setupLabelsWithUserData(currentUser: currentUser)
            
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
    func setupLabelsWithUserData(currentUser: ShadchanUser) {
        currentUser.shadchanUserID

        // profile photo
        currentUser.shadchanProfileImageURLString
        
        // contact info
        cellLabel.text = currentUser.shadchanCell
        firstNameLabel.text = currentUser.shadchanFirstName
        lastNameLabel.text =  currentUser.shadchanLastName
        emailLabel.text =  currentUser.shadchanEmail
        titleLabel.text = currentUser.shadchanTitle
        
        
        //singlesPlanLabel.text =
        //currentUser.singlesPlan
        
        //familyTypeLabel.text =
        //currentUser.familyTypes
        
        //singlesTypeLabel.text =
        //currentUser.singlesType
        
        // professional bio
        numberOfYearsLabel.text =
        currentUser.yearsAsShadchan
        // yes/No
        
        yearsInShidduchimPrimary.text = currentUser.yearsInShidduchimSecondary
        yearsInShidduchimSecondary.text = currentUser.yearsInShidduchimPrimary
        
        communicationMethodPreferredLabel.text = currentUser.methodOfCommunicationPrimary
        communicationMethodSecondaryLabel.text = currentUser.methodOfCommunicationSecondary
        aboutLabel.text = currentUser.about
        
        }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ErekaVC" {
            let controller = segue.destination as! ErekaVC
            controller.currentUser  = shadchanUser
        }
            
        }
}

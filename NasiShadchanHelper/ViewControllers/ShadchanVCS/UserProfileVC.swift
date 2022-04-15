//
//  UserProfileVC.swift
//  NasiShadchanHelper
//
//  Created by test on 4/15/22.
//  Copyright © 2022 user. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {
    
    let shadchanListRef  = Database.database().reference().child("NasiShadchanUserList")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    func fetchUser(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("NasiShadchanUserList").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
           
            print(snapshot.value ?? "")
    
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            //self.user = User(dictionary: dictionary)
            //self.navigationItem.title = self.user?.username
            
            //self.collectionView?.reloadData()
        let user = ShadchanUser(snapshot: snapshot)
            
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
    /*
    let controller = storyboard!.instantiateViewController(withIdentifier: "AddEditDatesViewController") as! AddEditDatesViewController

    var currentNasiDate: NasiDate!

    currentNasiDate = selectedDatesArray[indexPath.row]
    
    controller.selectedNasiDate = currentNasiDate
    navigationController?.pushViewController(controller, animated: true)
    */
    
    
    
}

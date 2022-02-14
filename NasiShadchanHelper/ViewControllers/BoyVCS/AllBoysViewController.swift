//
//  AllBoysViewController.swift
//  NasiShadchanHelper
//
//  Created by test on 12/31/21.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit
import Firebase

class AllBoysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var shadchanBoysArray: [NasiBoy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchAndCreateBoysArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //
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
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return shadchanBoysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let nasiBoy = shadchanBoysArray[indexPath.row]
        
        cell.textLabel?.text = nasiBoy.boyFullName
        cell.detailTextLabel?.text = nasiBoy.dateCreated
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddEditBoyViewController") as! AddEditBoyViewController

        var currentNasiBoy: NasiBoy!
    
        currentNasiBoy = shadchanBoysArray[indexPath.row]
       controller.selectedNasiBoy = currentNasiBoy
        navigationController?.pushViewController(controller, animated: true)
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        
           //let controller = storyboard!.instantiateViewController(withIdentifier: "BoyDetailsVCTableViewController") as! BoyDetailsVCTableViewController
      
           
           var currentNasiBoy: NasiBoy!
           currentNasiBoy = shadchanBoysArray[indexPath.row]
          //controller.selectedNasiBoy = currentNasiBoy
           
           //navigationController?.pushViewController(controller, animated: true)

       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
           
           let currentBoy = shadchanBoysArray[indexPath.row]
             let currentBoyRef = currentBoy.ref
             let currentBoyKey = currentBoy.key
    
        guard let myId = UserInfo.curentUser?.id else {return}
             
          let boysListRef  = Database.database().reference().child("NasiBoysList")

             boysListRef.child(myId).child(currentBoyKey).removeValue {
               (error, dbRef) in
              
               if error != nil {
               print(error!.localizedDescription)
               
               } else {
                   
                self.shadchanBoysArray.remove(at: indexPath.row)
               let indexPathsToDelete = [indexPath]
               self.tableView.deleteRows(at: indexPathsToDelete, with: .left)
               //self.tableView.reloadData()
               }
           }
        }
    }
   
    

}

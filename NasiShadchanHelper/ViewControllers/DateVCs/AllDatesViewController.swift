//
//  AllDatesViewController.swift
//  NasiShadchanHelper
//
//  Created by test on 1/22/22.
//  Copyright © 2022 user. All rights reserved.
//


import UIKit
import Firebase

class AllDatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: Properties
    var nasiDatesArray: [NasiDate] = []
    var nasiDatesArrayIdea: [NasiDate] = []
    var nasiDatesArrayActive: [NasiDate] = []
    var nasiDatesArrayFinished: [NasiDate] = []
    var nasiDatesArrayEngaged: [NasiDate] = []
    
   let datesListRef  = Database.database().reference().child("NasiDatesList")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAndCreateBoysArray()
        setUpSegmentControlApperance()
        self.segmentChanged(segmentControl)
    }
    
    func setUpSegmentControlApperance() {
        segmentControl.selectedSegmentTintColor = Constant.AppColor.colorAppTheme
        
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                           NSAttributedString.Key.font: Constant.AppFontHelper.defaultSemiboldFontWithSize(size: 16)]
        segmentControl.setTitleTextAttributes(titleTextAttributesSelected, for:.selected)
        
        let titleTextAttributesDefault = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                          NSAttributedString.Key.font: Constant.AppFontHelper.defaultRegularFontWithSize(size: 16)]
        segmentControl.setTitleTextAttributes(titleTextAttributesDefault, for:.normal)
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.nasiDatesArray = nasiDatesArrayIdea
        } else if sender.selectedSegmentIndex == 1 {
            self.nasiDatesArray = nasiDatesArrayActive
        } else if sender.selectedSegmentIndex == 2  {
            self.nasiDatesArray = nasiDatesArrayEngaged
        } else if sender.selectedSegmentIndex == 3 {
            self.nasiDatesArray = nasiDatesArrayFinished
            
        }
        self.tableView.reloadData()
    }
    
    func fetchAndCreateBoysArray() {
      //self.view.showLoadingIndicator()
    
        
        guard let myId = UserInfo.curentUser?.id else {return}
        
        let currentUserDatesListRef = datesListRef.child(myId)
      
        currentUserDatesListRef.observe(.value, with: { snapshot in
        var datesArray: [NasiDate] = []
            for child in snapshot.children {
              
            let snapshot = child as? DataSnapshot
             let nasiDate = NasiDate(snapshot: snapshot!)
            datesArray.append(nasiDate)
        }
    self.nasiDatesArray = datesArray
    self.nasiDatesArrayIdea =  self.nasiDatesArray.filter { nasiDate in
         nasiDate.datingStatus == "Idea"
    }
            
        self.nasiDatesArrayActive =  self.nasiDatesArray.filter { nasiDate in
                nasiDate.datingStatus == "Active"
           }
            
        self.nasiDatesArrayFinished =  self.nasiDatesArray.filter { nasiDate in
                nasiDate.datingStatus == "Finished"
        }
            
        self.nasiDatesArrayEngaged =  self.nasiDatesArray.filter { nasiDate in
                    nasiDate.datingStatus == "Engaged"
        }
            
        self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasiDatesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let nasiDate = nasiDatesArray[indexPath.row]
    
        cell.textLabel?.text = nasiDate.boyFullName
        cell.detailTextLabel?.text = nasiDate.girlFullName   + "  Last Update: - " + nasiDate.updateTimeStamp
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("blue button tapped")
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddEditDatesViewController") as! AddEditDatesViewController

        var currentNasiDate: NasiDate!
    
        currentNasiDate = nasiDatesArray[indexPath.row]
       controller.selectedNasiDate = currentNasiDate
        navigationController?.pushViewController(controller, animated: true)
        }
    
    
  
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
           
           let currentDate = nasiDatesArray[indexPath.row]
             let currentDateRef = currentDate.ref
             let currentDateKey = currentDate.key
    
            
           guard let myId = UserInfo.curentUser?.id else {return}
           
           self.datesListRef.child(myId).child(currentDateKey).removeValue {
               (error, dbRef) in
              
               if error != nil {
               print(error!.localizedDescription)
               
               } else {
                   
                self.nasiDatesArray.remove(at: indexPath.row)
               let indexPathsToDelete = [indexPath]
               self.tableView.deleteRows(at: indexPathsToDelete, with: .left)
               //self.tableView.reloadData()
               
           }
          }
         }
       }
    
}

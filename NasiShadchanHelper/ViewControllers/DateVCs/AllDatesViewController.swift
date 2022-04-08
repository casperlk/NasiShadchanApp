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
    var selectedDatesArray: [NasiDate] = []
    
    var nasiDatesArrayAll: [NasiDate] = []
    var nasiDatesArrayIdea: [NasiDate] = []
    var nasiDatesArrayActive: [NasiDate] = []
    var nasiDatesArrayFinished: [NasiDate] = []
    var nasiDatesArrayEngaged: [NasiDate] = []
    
    
   let datesListRef  = Database.database().reference().child("NasiDatesList")
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        setUpSegmentControlApperance()
        
        fetchAllDates()
    }
    
    func fetchAllDates() {
        
        guard let myId = UserInfo.curentUser?.id else {return}
        print("my id is \(myId)")
        
let currentUserDatesListRef = datesListRef.child(myId)
//currentUserDatesListRef
 //         .queryOrdered(byChild: "dateLastUpdate")
 //         .observe(.value, with:  { snapshot in
 currentUserDatesListRef.observe(.value, with: { snapshot in
        
        var datesArray: [NasiDate] = []
            
            for child in snapshot.children {
              
            let snapshot = child as? DataSnapshot
             let nasiDate = NasiDate(snapshot: snapshot!)
              datesArray.append(nasiDate)
           }
            
            //arrOnetoThreeSingleGirls
             // datesArray = datesArray.sorted(by: { Date($0.dateLastUpdate)! > Date($1.dateLastUpdate)! })
            
            self.selectedDatesArray = datesArray
            self.tableView.reloadData()
        })
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
     fetchAndCreateAllDatesArrays()
    }
    
    func clearAllArrays() {
        self.selectedDatesArray.removeAll()
        self.nasiDatesArrayAll.removeAll()
        self.nasiDatesArrayIdea.removeAll()
        self.nasiDatesArrayActive.removeAll()
        self.nasiDatesArrayFinished.removeAll()
        self.nasiDatesArrayEngaged.removeAll()
        
    }

    func figureOutTheRightArray() {
        
        currentIndex = segmentControl.selectedSegmentIndex
        
        if currentIndex == 0 {
            self.selectedDatesArray = nasiDatesArrayAll
        }
    else if currentIndex == 1 {
        self.selectedDatesArray = nasiDatesArrayIdea
    } else if currentIndex == 2 {
        self.selectedDatesArray = nasiDatesArrayActive
    } else if currentIndex == 3  {
        self.selectedDatesArray = nasiDatesArrayEngaged
    } else if currentIndex == 4 {
        self.selectedDatesArray = nasiDatesArrayFinished
    }
    
}
    
    
    // when segment is tapped array gets set to proper sub array
    // and table view is reloaded to show new list
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.selectedDatesArray = nasiDatesArrayAll
        }
        if sender.selectedSegmentIndex == 1 {
            self.selectedDatesArray = nasiDatesArrayIdea
        } else if sender.selectedSegmentIndex == 2 {
            self.selectedDatesArray = nasiDatesArrayActive
        } else if sender.selectedSegmentIndex == 3  {
            self.selectedDatesArray = nasiDatesArrayEngaged
        } else if sender.selectedSegmentIndex == 4 {
            self.selectedDatesArray = nasiDatesArrayFinished
            
        }
        self.tableView.reloadData()
    }
    
    func fetchAndCreateAllDatesArrays() {

        guard let myId = UserInfo.curentUser?.id else {return}
        
        print("my id is \(myId)")
        
        
        let currentUserDatesListRef = datesListRef.child(myId)
        
        currentUserDatesListRef.observe(.value, with: { snapshot in
        
        var datesArray: [NasiDate] = []
            
            for child in snapshot.children {
              
            let snapshot = child as? DataSnapshot
             let nasiDate = NasiDate(snapshot: snapshot!)
              datesArray.append(nasiDate)
            }
        
            self.selectedDatesArray = datesArray
            self.buildCategoriesArrays(datesArray: datesArray)
            
            // look at the current selected index and set the
            // tableViews array to the selected category
            self.figureOutTheRightArray()
        })
        self.tableView.reloadData()
    }
    
    func buildCategoriesArrays(datesArray: [NasiDate]) {
        
        self.nasiDatesArrayAll = datesArray
        
        self.nasiDatesArrayAll.sort(by: { (date1, date2) -> Bool in
            
            return date1.dateLastUpdate > date2.dateLastUpdate
        })
        
        self.nasiDatesArrayIdea =  datesArray.filter { nasiDate in
          nasiDate.datingStatus == "Idea"
        }
        
        self.nasiDatesArrayIdea.sort(by: { (date1, date2) -> Bool in
            
            return date1.dateLastUpdate > date2.dateLastUpdate
        })
        
       self.nasiDatesArrayActive =  datesArray.filter { nasiDate in
                 nasiDate.datingStatus == "Active"
            }
        
        self.nasiDatesArrayActive.sort(by: { (date1, date2) -> Bool in
            
            return date1.dateLastUpdate > date2.dateLastUpdate
        })
             
         self.nasiDatesArrayFinished =  datesArray.filter { nasiDate in
                 nasiDate.datingStatus == "Finished"
         }
        
        self.nasiDatesArrayFinished.sort(by: { (date1, date2) -> Bool in
            
            return date1.dateLastUpdate > date2.dateLastUpdate
        })
             
         self.nasiDatesArrayEngaged =  datesArray.filter { nasiDate in
                     nasiDate.datingStatus == "Engaged"
         }
        
        self.nasiDatesArrayEngaged.sort(by: { (date1, date2) -> Bool in
            
            return date1.dateLastUpdate > date2.dateLastUpdate
        })
        
        
        
        /*
        //arrOnetoThreeSingleGirls
        nasiDatesArrayAll = self.nasiDatesArray.sorted(by: { Double($0.age ) < Double($1.age ) })
        
        
        nasiDatesArrayIdea = self.arrThreeToFiveSingleGirls.sorted(by: { Double($0.age ) < Double($1.age ) })
        
        nasiDatesArrayActive = self.arrFiveYearsSingleGirls.sorted(by: { Double($0.age ) < Double($1.age ) })
        
        nasiDatesArrayFinished = self.fiveToSevenSingleGirls.sorted(by: { Double($0.age ) < Double($1.age ) })
        
        */
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedDatesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let nasiDate = selectedDatesArray[indexPath.row]
        
        let timeDisplayString = timeAgoDisplay(secondsAgo: nasiDate.dateLastUpdate)
    
        cell.textLabel?.text = nasiDate.boyFullName + " & " +  nasiDate.girlFullName
        
        cell.detailTextLabel?.textColor = UIColor.darkGray
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.text = "Dating Status: " +  "\(nasiDate.datingStatus)  "
        //+ timeDisplayString
        return cell
    }
    
    func timeAgoDisplay(secondsAgo: Int) -> String {
        
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        
        return "\(secondsAgo / week) weeks ago"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddEditDatesViewController") as! AddEditDatesViewController

        var currentNasiDate: NasiDate!
    
        currentNasiDate = selectedDatesArray[indexPath.row]
        
        controller.selectedNasiDate = currentNasiDate
        navigationController?.pushViewController(controller, animated: true)
        }
    
    
  
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
           
           let currentDate = selectedDatesArray[indexPath.row]
             let currentDateRef = currentDate.ref
             let currentDateKey = currentDate.key
    
            
           guard let myId = UserInfo.curentUser?.id else {return}
           
             currentDateRef!.removeValue {
               (error, dbRef) in
              
               if error != nil {
               print(error!.localizedDescription)
               
               } else {
                   
                //self.selectedDatesArray.remove(at: indexPath.row)
               //let indexPathsToDelete = [indexPath]
               //self.tableView.deleteRows(at: indexPathsToDelete, with: .left)
               self.tableView.reloadData()
               
           }
          }
         }
       }
    */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          let currentDate = selectedDatesArray[indexPath.row]
          currentDate.ref?.removeValue()
      }
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
    
    
    
    
}
let now = Date()
let pastDate = Date(timeIntervalSinceNow: -60 * 60 * 24)

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        
        return "\(secondsAgo / week) weeks ago"
    }
}



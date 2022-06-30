//
//  ErekaVC.swift
//  NasiShadchanHelper
//
//  Created by test on 3/31/22.
//  Copyright © 2022 user. All rights reserved.
//

import UIKit
import Eureka
import ImageRow


class ErekaVC: FormViewController {
    
    private lazy var dateFormatter: DateFormatter = {
      let fmtr = DateFormatter()
      fmtr.dateFormat = "EEEE, MMM d"
      return fmtr
    }()
    
    var currentUser: ShadchanUser!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
    //1 section 0
     form +++ Section("Shadchan Name")
          <<< TextRow() {
            
            $0.placeholder = "First Name"
            $0.value = currentUser.shadchanFirstName //5
              
            $0.onChange { [unowned self] row in //6
                self.currentUser.shadchanFirstName = row.value ?? ""
            }
         }
        
        <<< TextRow() {
           $0.placeholder = "Last Name"
            $0.value = currentUser.shadchanLastName //5
          $0.onChange { [unowned self] row in //6
        self.currentUser.shadchanLastName = row.value ??
              ""
          }
      }
    form.last!
        <<< ActionSheetRow<String>() {
            $0.title = "Title:"
            $0.selectorTitle = "Title"
            $0.options = ["Rabbi","Mr.","Mrs.","Ms."]
            $0.value = self.currentUser.shadchanTitle ?? "N/A"
                        
        $0.onChange { [unowned self] row in //6
        self.currentUser.shadchanTitle = row.value ??
            "N/A"
        }
        }
        
        form +++ //section 1
        Section("Contact Info")
        <<< PhoneRow(){
            $0.title = "Cell"
            $0.placeholder = "Add numbers here"
            $0.value = self.currentUser.shadchanCell ?? "N/A"
            
            $0.onChange { [unowned self] row in
            self.currentUser.shadchanCell = row.value ??
                "N/A"
            }
        }
         
        <<< EmailRow(){
             $0.title = "Email"
             $0.placeholder = "Add Email here"
            $0.value = self.currentUser.shadchanEmail ?? "N/A"
          
        
        $0.onChange { [unowned self] row in
        self.currentUser.shadchanEmail = row.value ??
            "N/A"
        }
        }
            
    form
        +++
            Section() //section 2
        <<< ActionSheetRow<String>() {
            $0.title = "Ideal Mode of Communication"
            $0.selectorTitle = "Choose Method"
            $0.options = ["WhatsApp","Text","Email","Phone","N/A"]
            $0.value = self.currentUser.methodOfCommunicationPrimary ?? "N/A"
            $0.onChange { [unowned self] row in
            self.currentUser.methodOfCommunicationPrimary = row.value ??
                "N/A"
            }
        }
    form
        +++ Section() //section 3
        <<< ActionSheetRow<String>() {
            $0.title = "Second Mode of Communication"
            $0.selectorTitle = "Choose Method"
            $0.options = ["WhatsApp","Text","Email","Phone","N/A"]
            $0.value = self.currentUser.methodOfCommunicationSecondary ?? "N/A"
            $0.onChange { [unowned self] row in
            self.currentUser.methodOfCommunicationSecondary = row.value ??
                         "N/A"
            }
        }
        
        
        //section 4
        form +++ Section("Specialties - Types of Singles and Families")
        
        //section 5
        form +++ SelectableSection<ListCheckRow<String>>("Family Type - Check All That Apply", selectionType: .multipleSelection)
                                                                
                                             
        let familyType = ["Yeshivish","American","Baale Batish","Klei Kodesh","Modern Orthodox", "Chasidish", "Heimish", "Sefardi","Russian" ]
        
        for i in familyType {
            
            form.last! <<< ListCheckRow<String>(){ listRow in
                listRow.title = i
                listRow.selectableValue = i
                listRow.value = nil
                
         }
        }
        //section 6
        form +++ SelectableSection<ListCheckRow<String>>("Singles Plan - Check All That Apply", selectionType: .multipleSelection)
        
        let SinglesPlan = ["Learning 1-3 years", "Learning 3-5 years", "Learning 5 plus","Part Time Learning", "Working"]
        
        for option in SinglesPlan {
            
            form.last! <<< ListCheckRow<String>(){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
            
        //section 7
        form +++ SelectableSection<ListCheckRow<String>>("Singles Type - Check All That Apply", selectionType: .multipleSelection)
                                                                
                                             
        let singleType = ["Yeshivish","Toradig","Baale Batish", "Chasidish", "Heimish", "Sefardi", "Modern Orthodox"]
        
        for option in singleType {
            
            form.last! <<< ListCheckRow<String>(){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
        
        let options = ["N/A","1-3 Years","3-5 Years","5-10 Years","10 Plus Years"]

        form +++ SelectableSection<ImageCheckRow<String>>("What PRIMARY range do you specialize in?", selectionType: .multipleSelection)
        
        for option in options {
            form.last! <<< ImageCheckRow<String>(){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                
                let currentElement = option
                let arry = currentUser.yearsInShidduchimPrimary
                let check = arry.contains(currentElement)
                if check == true {
                
                lrow.value =  currentElement
                } else {
                    lrow.value = nil
                }
                
                }.cellSetup { cell, _ in
                    cell.trueImage = UIImage(named: "selectedRectangle")!
                    cell.falseImage = UIImage(named: "unselectedRectangle")!
                    cell.accessoryType = .checkmark
            }
        }
        
        
        
form +++ SelectableSection<ImageCheckRow<String>>("What SECONDARY range do you specialize in?", selectionType: .multipleSelection)

for option in options {
   form.last! <<< ImageCheckRow<String>(option){ lrow in
       lrow.title = option
       lrow.selectableValue = option
       
       let currentElement = option
       let arry = currentUser.yearsInShidduchimPrimary
       let check = arry.contains(currentElement)
       if check == true {
       
       lrow.value =  currentElement
       } else {
           lrow.value = nil
       }
       
       }.cellSetup { cell, _ in
           cell.trueImage = UIImage(named: "selectedRectangle")!
           cell.falseImage = UIImage(named: "unselectedRectangle")!
           cell.accessoryType = .checkmark
   }
}

        
        
        
        
        //section
        form +++ Section("Shadchan Business Bio")
             <<< ActionSheetRow<String>() {
              $0.title = "Years as A Shadchan"
              $0.selectorTitle = "Choose a Range"
              $0.options = ["1-3","3-5","5-10","10 Plus"]
              $0.value = "1-3"    // initially selected
             }
                 
                 
            form
        +++ Section()
            <<< ActionSheetRow<String>() {
                $0.title = "Open To Paid BrainStorming Sessions"
                $0.selectorTitle = "Choose Y/N"
                $0.options = ["Yes","No"]
                $0.value = "Yes"    // initially selected
              }
                 
            form
            +++ Section()
            <<< ActionSheetRow<String>() {
            $0.title = "Need To Meet Single?"
            $0.selectorTitle = "Choose Y/N"
            $0.options = ["Yes","No"]
            $0.value = "Yes"    // initially selected
            }
            
            form +++ Section(header: "Description",footer: "")
                     //form.last!
            <<< TextAreaRow("Description") {
            $0.placeholder = "About Yourself"
            $0.textAreaHeight = .dynamic(initialTextViewHeight: 150)
            }
            
        
        /*
        let titles = ["N/A","Rabbi","Mr","Mrs","Ms"]

        form +++ SelectableSection<ImageCheckRow<String>>() { section in
            section.header = HeaderFooterView(title: "What is your title")
        }

        for option in titles {
            form.last! <<< ImageCheckRow<String>(){ lrow in
                lrow.title = option
                lrow.selectableValue = option
                lrow.value = nil
            }
        }
        */
        
        
     
        
        
                
       
        
        
        
        /*
        form +++ Section()
                       <<< ImageRow() { row in
                           row.title = "Profile Avatar"
                           row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                           row.clearAction = .yes(style: UIAlertAction.Style.destructive)
        }
        */
        /*
        <<< ButtonRow("Native iOS Event Form") { row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: "NativeEventsFormNavigationControllerSegue", onDismiss:{  vc in vc.dismiss(animated: true) })
            }
        */
        
         
        
        //+++ Section()    //2
        
        
    
        
   
  
             
             //$0.onChange(<#T##callback: (ActionSheetRow<String>) -> Void##(ActionSheetRow<String>) -> Void#>)
                    }
         
        /*
        +++ Section()
          <<< DateTimeRow() {
            
           // $0.dateFormatter = type(of: self).dateFormatter //1
            $0.title = "Date of Birth" //2
            //$0.value = viewModel.dueDate //3
            $0.minimumDate = Date() //4
            $0.onChange { [unowned self] row in //5
              if let date = row.value {
             //   self.viewModel.dueDate = date
                  row.baseCell.textLabel?.textColor = .blue
                  row.baseCell.detailTextLabel?.textColor = .blue
              }
            }
          }
        */
    /*
        +++ Section(header: "Date Started With Nasi", footer: "")
              // <<< DateRow(){
              //     $0.title = "Date"
              //     $0.value = //Date(timeIntervalSinceReferenceDate: 0)
             //  }
        form.last!  <<< DateInlineRow() {
            $0.title = "Select Date"
            $0.value = Date()
        }
        */
        
       
        
        
        

        
      
      
        
        
        

        
    
    override func valueHasBeenChanged(for row: BaseRow, oldValue: Any?, newValue: Any?) {
        /*
        if row.section === form[0] {
            print("Single Selection:\((row.section as! SelectableSection<ImageCheckRow<String>>).selectedRow()?.baseValue ?? "No row selected")")
        }
        */
        //else
        if row.section === form[1] {
           var values = (row.section as! SelectableSection<ImageCheckRow<String>>).selectedRows().map({$0.baseValue!}) as! [String]
            print(values)
            self.currentUser.yearsInShidduchimPrimary = values
        }
    }
    
    
    
   

    @IBAction func saveTapped(_ sender: Any) {
        updateShadchanUserInFireBase()
    }
    
    
    
    
     func updateShadchanUserInFireBase() {
         let revisedUser  = ShadchanUser(shadchanEmail: currentUser.shadchanEmail, shadchanFirstName: currentUser.shadchanFirstName, shadchanLastName: currentUser.shadchanLastName, shadchanUserID: currentUser.shadchanUserID, shadchanCell: currentUser.shadchanCell, shadchanTitle: currentUser.shadchanTitle, shadchanProfileImageURLString: currentUser.shadchanProfileImageURLString, yearsAsShadchan: currentUser.yearsAsShadchan, about: currentUser.about, familyTypes: currentUser.familyTypes, singlesPlan: currentUser.singlesPlan, singlesType: currentUser.singlesType, needToMeetSingle: currentUser.needToMeetSingle, welcomePaidBrainstormingSessions: currentUser.welcomePaidBrainstormingSessions, yearsInShidduchimPrimary: currentUser.yearsInShidduchimPrimary, yearsInShidduchimSecondary: currentUser.yearsInShidduchimSecondary, methodOfCommunicationPrimary: currentUser.methodOfCommunicationPrimary, methodOfCommunicationSecondary: currentUser.methodOfCommunicationSecondary)
        /*
         let revisedUser = ShadchanUser(shadchanEmail: currentUser.shadchanEmail, shadchanFirstName: currentUser.shadchanFirstName, shadchanLastName: currentUser.shadchanLastName, shadchanUserID: currentUser.shadchanUserID, shadchanCell: currentUser.shadchanCell, shadchanTitle: currentUser.shadchanTitle, shadchanProfileImageURLString: currentUser.shadchanProfileImageURLString, yearsAsShadchan: currentUser.yearsAsShadchan, about: currentUser.about, familyTypes: currentUser.familyTypes, singlesPlan: currentUser.singlesPlan, singlesType: currentUser.singlesType, needToMeetSingle: currentUser.needToMeetSingle, welcomePaidBrainstormingSessions: currentUser.welcomePaidBrainstormingSessions)
        */
        let dict = revisedUser.toAnyObject()
        let ref = currentUser.ref
        ref?.setValue(dict as! [AnyHashable : Any])
        
    }
}
    




/*
   form +++ Section("Callbacks") <<< SwitchRow("scr1") { $0.title = "Switch to turn red"; $0.value = false }
        .onChange({ row in
            if row.value == true {
                row.cell.backgroundColor = .red
            } else {
                row.cell.backgroundColor = .black
            }
        })
    
    }
        */
    
        
        /*
 form +++ SelectableSection<ListCheckRow<String>>("Where do you live", selectionType: .singleSelection(enableDeselection: true))

        
        let continents = ["New York City", "Baltimore", "Lakewood", "Monsey", "Israel"]
        
        for option in continents {
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
         */
            
       
        
        
        
        
        

    



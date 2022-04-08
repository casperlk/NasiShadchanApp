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
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        //view.backgroundColor = .green
        form +++ Section()
                       <<< ImageRow() { row in
                           row.title = "Profile Avatar"
                           row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                           row.clearAction = .yes(style: UIAlertAction.Style.destructive)
                       }
        
        /*
        <<< ButtonRow("Native iOS Event Form") { row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: "NativeEventsFormNavigationControllerSegue", onDismiss:{  vc in vc.dismiss(animated: true) })
            }
        */
        
          //1
          form
            +++ Section("Shadchan Name")    //2
            <<< TextRow() { // 3
              //$0.title = "Description" //4
              $0.placeholder = "First Name"
             // $0.value = viewModel.title //5
              $0.onChange { [unowned self] row in //6
               // self.viewModel.title = row.value
              }
          }
        
        //+++ Section()    //2
        <<< TextRow() { // 3
          //$0.title = "Description" //4
          $0.placeholder = "Last Name"
         // $0.value = viewModel.title //5
          $0.onChange { [unowned self] row in //6
           // self.viewModel.title = row.value
          }
      }
        
        
        form.last! <<< ActionSheetRow<String>() {
                        $0.title = "Title"
                        $0.selectorTitle = "Title"
                        $0.options = ["Rabbi","Mr.","Mrs.","Ms."]
                        $0.value = "Mrs."    // initially selected
                    }
        
        
        form +++ Section("Contact Info")
               <<< PhoneRow(){
                   $0.title = "Cell"
                   $0.placeholder = "Add numbers here"
               }
        form
        +++ Section()
         <<< ActionSheetRow<String>() {
                        $0.title = "Years as A Shadchan"
                        $0.selectorTitle = "Choose a Range"
                        $0.options = ["1-3","3-5","5-10","10 Plus"]
                        $0.value = "1-3"    // initially selected
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
    
        
     
          
        
        +++ Section(header: "Date Started With Nasi", footer: "")
              // <<< DateRow(){
              //     $0.title = "Date"
              //     $0.value = //Date(timeIntervalSinceReferenceDate: 0)
             //  }
        form.last!  <<< DateInlineRow() {
            $0.title = "Select Date"
            $0.value = Date()
        }
        
        form +++ Section("Specialties - Types of Singles and Families")
        form +++ SelectableSection<ListCheckRow<String>>("Family Type", selectionType: .multipleSelection)
                                                                
                                             
        let familyType = ["Yeshivishe","Americanish","Baale Batishe","Klei Kodesh","Modern Orthodoxish", "Chasidishe", "Heimishe", "Sefardishe","Russian" ]
        
        for i in familyType {
            
            form.last! <<< ListCheckRow<String>(i){ listRow in
                listRow.title = i
                listRow.selectableValue = i
                listRow.value = nil
            }
        }
      
        form +++ SelectableSection<ListCheckRow<String>>("Singles Plan", selectionType: .multipleSelection)
        
        let SinglesPlan = ["Learning 1-3 years", "Learning 3-5 years", "Learning 5 plus","Part Time Learning", "Working"]
        
        for option in SinglesPlan {
            
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
        
        form +++ SelectableSection<ListCheckRow<String>>("Singles Type", selectionType: .multipleSelection)
                                                                
                                             
        let singleType = ["Yeshivish","Toradig","Baale Batish", "Chasidish", "Heimish", "Sefardi", "Modern Orthodox"]
        
        for option in singleType {
            
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
        
        form +++ Section(header: "Description",footer: "")
            //form.last!
        <<< TextAreaRow("Description") {
                $0.placeholder = "About Yourself"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 150)
        }
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
            
       
        
        
        
        
        

    



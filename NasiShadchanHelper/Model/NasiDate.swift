//
//  NasiDate.swift
//  NasiShadchanHelper
//
//  Created by test on 1/20/22.
//  Copyright © 2022 user. All rights reserved.
//

import Foundation
import Firebase

class NasiDate: NSObject {
    
    var  ref: DatabaseReference?
    var  key: String = ""
    var  boyFullName: String = ""
    var  boysAge: String = ""
    var  dateNumber: String = ""
    var  datingStatus: String = ""
    var  girlFullName: String  = ""
    var  girlAge: String = ""
    var  shadchanNotes: String = ""
    var  creationDate: String = ""
    var  updateTimeStamp: String  = ""
    var  nasiProgram: String = "" // N/A - Nasi - AY - Sefardim
    
    init(snapshot: DataSnapshot) {
    //let value = snapshot.value as! [String: AnyObject]
    guard  let value = snapshot.value! as? [String: String] else { return }
        
        // FB snapshot has a ref and key property
        self.ref = snapshot.ref
        self.key = snapshot.key
        
        let boyFullName = value["boyFullName"] ?? ""
        let girlFullName = value["girlFullName"] ?? ""
        let boysAge = value["boysAge"] ?? ""
        let girlAge = value["girlAge"] ?? ""
        let dateNumber = value["dateNumber"] ?? ""
        let datingStatus = value["datingStatus"] ?? ""
        let shadchanNotes = value["shadchanNotes"] ?? ""
        let nasiProgram = value["nasiProgram"] ?? ""
        let creationDate = value["creationDate"] ?? ""
        let updateTimeStamp = value["updateTimeStamp"] ?? ""
        
        self.boyFullName = boyFullName
        self.girlFullName = girlFullName
        self.boysAge = boysAge
        self.girlAge = girlAge
        
        self.dateNumber = dateNumber
        self.datingStatus = datingStatus
        
        self.shadchanNotes = shadchanNotes
        self.nasiProgram = nasiProgram
        
        self.creationDate = creationDate
        self.updateTimeStamp = updateTimeStamp
        
        
    }

    // MARK: Initialize with Raw Data
    init(boyFullName: String, boysAge: String, dateNumber: String, datingStatus: String, girlFullName: String, girlAge: String, shadchanNotes: String, creationDate: String, updateTimeStamp: String, nasiProgram: String, key: String = "") {
        
        
      self.ref = nil
      self.key = key
      self.boyFullName = boyFullName
      self.boysAge = boysAge
      self.dateNumber = dateNumber
      self.datingStatus = datingStatus
      self.girlFullName = girlFullName
      self.girlAge = girlAge
      self.shadchanNotes = shadchanNotes
      self.creationDate = creationDate
      self.updateTimeStamp = updateTimeStamp
      self.nasiProgram = nasiProgram
        
    }
    
    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "boyFullName": boyFullName,
        "boysAge": boysAge,
        "dateNumber": dateNumber,
        "datingStatus" : datingStatus,
        "girlFullName" : girlFullName,
        "girlAge": girlAge,
        "shadchanNotes": shadchanNotes,
        "creationDate": creationDate,
        "updateTimeStamp": updateTimeStamp,
        "nasiProgram": nasiProgram
      ]
    }
    
    func createNewDateInFirebase() {
        let boyName = "Michel Jordan"
        let girlName = "Shprintza Gross"
        let datingStatus = "ended"
        let dateNumber = "4"
        let boyAge = "22"
        let girlAge = "22"
        let shadChanNotes = "Cute Couple"
        let nasiProgram = "Sefardim"
        let creationDate = "\(Date())"
        let updateTimeStamp = "\(Date())"
        
        let newDate = NasiDate(boyFullName: boyName, boysAge: boyAge, dateNumber: dateNumber, datingStatus: datingStatus, girlFullName: girlName, girlAge: girlAge, shadchanNotes: shadchanNotes, creationDate: creationDate, updateTimeStamp: updateTimeStamp, nasiProgram: nasiProgram)
        
        let dateNodeRef = Database.database().reference(withPath: "NasiDatesList")

        //let groceryItemRef = self.ref.child(text.lowercased())
        dateNodeRef.setValue(newDate.toAnyObject())
    }

}

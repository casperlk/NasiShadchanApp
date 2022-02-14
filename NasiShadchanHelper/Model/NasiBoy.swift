//
//  NasiBoy.swift
//  NasiShadchanHelper
//
//  Created by test on 12/31/21.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import Firebase

class NasiBoy: NSObject {
    
    var  ref: DatabaseReference?
    var  key: String = ""
    
    var addedByShadchanUserID = ""
    var boyCell = ""
    var boyFullName = ""
    var boyProfileImageURLString = ""
    var boyUID = ""
    var contactCell = ""
    var contactFullName = ""
    var dateCreated = ""
    var dob = ""
    var sendResumeEmail = ""
    var sendResumeText = ""

    init(snapshot: DataSnapshot) {
    //let value = snapshot.value as! [String: AnyObject]
    guard  let value = snapshot.value! as? [String: String] else { return }
        
        // FB snapshot has a ref and key property
        self.ref = snapshot.ref
        self.key = snapshot.key
        
        let addedByShadchanUserID = value["addedByShadchanUserID"] ?? ""
        let boyCell = value["boyCell"] ?? ""
        let boyFullName = value["boyFullName"] ?? ""
        let boyProfileImageURLString = value["boyProfileImageURLString"] ?? ""
        let boyUID = value["boyUID"] ?? ""
        let contactCell = value["contactCell"] ?? ""
        
        let contactFullName = value["contactFullName"] ?? ""
        let dateCreated = value["dateCreated"] ?? ""
        let dob = value["dob"] ?? ""
        
        let sendResumeEmail = value["sendResumeEmail"] ?? ""
        let sendResumeText = value["sendResumeText"] ?? ""
        
        self.addedByShadchanUserID = addedByShadchanUserID
        self.boyCell = boyCell
        self.boyFullName = boyFullName
        self.boyProfileImageURLString = boyProfileImageURLString
        
        self.boyUID = boyUID
        self.contactCell = contactCell
        
        self.contactFullName = contactFullName
        self.dateCreated = dateCreated
        self.dob = dob
        self.sendResumeEmail = sendResumeEmail
        self.sendResumeText = sendResumeText
    }
  
    // MARK: Initialize with Raw Data
    init(addedByShadchanUserID: String, boyCell: String, boyFullName: String, boyProfileImageURLString: String, boyUID: String, contactCell: String, contactFullName: String, dateCreated: String, dob: String, sendResumeEmail: String,sendResumeText:String,key: String = "") {
        
        
      self.ref = nil
      self.key = key
      self.addedByShadchanUserID = addedByShadchanUserID
      self.boyCell = boyCell
      self.boyFullName = boyFullName
      self.boyProfileImageURLString = boyProfileImageURLString
      self.boyUID = boyUID
      self.contactCell = contactCell
      self.contactFullName = contactFullName
      self.dateCreated = dateCreated
      self.dob = dob
      self.sendResumeEmail = sendResumeEmail
      self.sendResumeText = sendResumeText
        
    }
    
    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "ref": "",
        "key": key,
        "addedByShadchanUserID": addedByShadchanUserID,
        "boyCell": boyCell,
        "boyFullName": boyFullName,
        "boyProfileImageURLString": boyProfileImageURLString,
        "boyUID": boyUID,
        "contactCell": contactCell,
        "contactFullName" : contactFullName,
        "dateCreated": dateCreated,
        "dob": dob,
        "sendResumeEmail": sendResumeEmail,
        "sendResumeText": sendResumeText
        ]
    }
    
}

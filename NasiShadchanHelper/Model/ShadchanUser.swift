//
//  ShadchanUser.swift
//  NasiShadchanHelper
//
//  Created by test on 4/9/22.
//  Copyright © 2022 user. All rights reserved.
//


import Foundation
import Firebase

class ShadchanUser: NSObject {
    
    var  ref: DatabaseReference?
    var  key: String = ""
    
    var shadchanEmail = ""
    var shadchanUserID = ""
    var shadchanLastName = ""
    var shadchanFirstName = ""
    var shadchanTitle = ""
    var shadchanProfileImageURLString = ""
    var shadchanCell = ""
    var yearsAsShadchan = ""
    var about = ""
    
    var familyTypes: [String] = []
    var singlesPlan: [String] = []
    var singlesType: [String] = []
    
    // initialize from a firebase snapshot coming down into app
    init(snapshot: DataSnapshot) {
    //let value = snapshot.value as! [String: AnyObject]
    guard  let value = snapshot.value! as? [String: AnyObject] else { return }
        
        // FB snapshot has a ref and key property
        self.ref = snapshot.ref
        self.key = snapshot.key
        
        let shadchanEmail = value["shadchanEmail"]  as? String
        let shadchanUserID = value["shadchanUserID"]  as? String
        let shadchanLastName = value["shadchanLastName"]  as? String
        let shadchanFirstName = value["shadchanFirstName"]  as? String
        let shadchanTitle = value["shadchanTitle"]  as? String
        let shadchanProfileImageURLString = value["shadchanProfileImageURLString"]  as? String
        
        let shadchanCell = value["shadchanCell"]  as? String
        let yearsAsShadchan = value["yearsAsShadchan"]  as? String
        let about = value["about"]  as? String
        
        self.shadchanEmail = shadchanEmail ?? ""
        self.shadchanFirstName = shadchanFirstName ?? ""
        self.shadchanLastName = shadchanLastName ?? ""
        self.shadchanUserID = shadchanUserID ?? ""
        
        self.shadchanTitle = shadchanTitle ?? ""
        self.shadchanProfileImageURLString = shadchanProfileImageURLString ?? ""
        
        self.shadchanCell = shadchanCell ?? ""
        self.yearsAsShadchan = yearsAsShadchan ?? ""
        self.about = about ?? ""
    }
        
        // MARK: Initialize with user input data to send up
        // to firebase
        init(shadchanEmail: String, shadchanFirstName: String, shadchanLastName: String, shadchanUserID: String, shadchanTitle: String, shadchanProfileImageURLString: String, yearsAsShadchan: String,about: String, key: String = "") {
            
          self.ref = nil
          self.key = key
          self.shadchanEmail = shadchanEmail
          self.shadchanFirstName = shadchanFirstName
          self.shadchanLastName = shadchanLastName
            
          self.shadchanUserID = shadchanUserID
          self.shadchanTitle = shadchanTitle
          self.shadchanProfileImageURLString = shadchanProfileImageURLString
        
          self.yearsAsShadchan = yearsAsShadchan
          self.about = about
        
            
        }
    
    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "shadchanEmail": shadchanEmail,
        "shadchanFirstName": shadchanFirstName,
        "shadchanLastName": shadchanLastName,
        "shadchanUserID" : shadchanUserID,
        "shadchanTitle": shadchanTitle,
        "shadchanProfileImageURLString": shadchanProfileImageURLString,
        "yearsAsShadchan": yearsAsShadchan,
        "about": about,
        "familyTypes": familyTypes
      ]
    }
        
        
    }
        
    


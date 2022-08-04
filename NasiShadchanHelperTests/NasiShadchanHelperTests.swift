//
//  NasiShadchanHelperTests.swift
//  NasiShadchanHelperTests
//
//  Created by user on 4/24/20.
//  Copyright © 2020 user. All rights reserved.
//

import XCTest
import Firebase

@testable import NasiShadchanHelper

class NasiShadchanHelperTests: XCTestCase {
    
    var girlNote: ShadchanGirlNote
    var snapshot: DataSnapshot
    override init() {
        func createSnapshot() -> Any {
          return [
            "ShachanID": "1",
            "ShadchanEmail": "2",
            "ShadchanFirstName": "3",
            "ShadchanLastName" : "4",
            "girlFirstName": "5",
            "girlLastName": "6",
            "girlRef": "7",
            "girlUID": "8",
            "notesImageURL": "9",
            "notesTextString": "10"
          ]
        }
        
        snapshot = createSnapshot() as! DataSnapshot
        girlNote = ShadchanGirlNote(snapshot: snapshot)
        super.init(selector: <#T##Selector#>)
        
    }
    
    override func setUp() {
        
    }
    
    

    func testInitGirlNoteFromSnapshot() {
        XCTAssertEqual(girlNote.notesTextString, "10")
    }

}


/**
 
 override func setUp() {
     // Put setup code here. This method is called before the invocation of each test method in the class.
 }

 override func tearDown() {
     // Put teardown code here. This method is called after the invocation of each test method in the class.
 }

 func testExample() {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
 }

 func testPerformanceExample() {
     // This is an example of a performance test case.
     self.measure {
         // Put the code you want to measure the time of here.
     }
 }
 
 
 let snapshot =  {
             ShachanID = lrsAyqIdiJMtCEU8sdqyBQZ9Nbk1;
             ShadchanEmail = "";
             ShadchanFirstName = "";
             ShadchanLastName = "";
             girlFirstName = "";
             girlLastName = "";
             girlRef = "";
             girlUID = "";
             notesImageURL = "";
             notesTextString = "July 28th 5:21pm";
         }
 
 */

//
//  ContactsViewController.swift
//  NasiShadchanHelper
//
//  Created by test on 2/5/22.
//  Copyright © 2022 user. All rights reserved.
//

import UIKit
import MessageUI

class ContactsViewController: UITableViewController {

    var selectedNasiGirl: NasiGirl!
    
    
    @IBOutlet weak var toDiscussTextView: UITextView!
    @IBOutlet weak var toReddTextView: UITextView!
    @IBOutlet weak var girlTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateToDiscussTextField()
        populateToReddTextField()
        populateGirlTextField()
    }
    
    func populateToDiscussTextField() {
        
        let toDiscussNameString = selectedNasiGirl.firstNameOfAContactWhoKnowsGirl + " " + selectedNasiGirl.lastNameOfAContactWhoKnowsGirl
        let toDiscussTelString = selectedNasiGirl.cellNumberOfContactWhoKNowsGirl
        let toDiscussEmailstring = selectedNasiGirl.emailOfContactWhoKnowsGirl
        let relationToGirlString = selectedNasiGirl.relationshipOfThisContactToGirl
        
        let attributedText = NSMutableAttributedString(string: toDiscussNameString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: toDiscussTelString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
        
        attributedText.append(NSAttributedString(string: toDiscussEmailstring, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
        
        attributedText.append(NSAttributedString(string:relationToGirlString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        
        toDiscussTextView.attributedText = attributedText
    }
    
    func populateToReddTextField() {
        
        
        let toReddNameString = selectedNasiGirl.firstNameOfPersonToContactToReddShidduch + " " + selectedNasiGirl.lastNameOfPersonToContactToReddShidduch
        let toReddTelString = selectedNasiGirl.cellNumberOfContactToReddShidduch
        let toReddEmailstring = selectedNasiGirl.emailOfContactToReddShidduch
        let relationToGirlString = selectedNasiGirl.relationshipOfThisContactToGirl
        
    
        let attributedText = NSMutableAttributedString(string: toReddNameString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: toReddTelString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
        
        attributedText.append(NSAttributedString(string: toReddEmailstring, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
        
        attributedText.append(NSAttributedString(string:relationToGirlString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        
        toReddTextView.attributedText = attributedText
    }
    
    func populateGirlTextField() {
        
        let girlNameString = selectedNasiGirl.firstNameOfGirl + " " + selectedNasiGirl.lastNameOfGirl
        let girlTelString = selectedNasiGirl.girlsCellNumber
        let girlEmailstring = selectedNasiGirl.girlsEmailAddress
        
        
    
        let attributedText = NSMutableAttributedString(string: girlNameString, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        
        attributedText.append(NSAttributedString(string: girlTelString, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "\n", attributes:  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]))
        
        attributedText.append(NSAttributedString(string: girlEmailstring, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]))
        girlTextView.attributedText = attributedText
        }
        
    @IBAction func callContactToDisccuss(_ sender: Any) {
        Utility.makeACall(selectedNasiGirl.cellNumberOfContactWhoKNowsGirl)
    }
    
    
    @IBAction func textContactToDiscuss(_ sender: Any) {
        if !MFMessageComposeViewController.canSendText() {
            print("SMS services are not available")
        }
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        let toDiscussTelString = selectedNasiGirl.cellNumberOfContactWhoKNowsGirl
         
        // Configure the fields of the interface.
        composeVC.recipients = [toDiscussTelString]
        composeVC.body = "HelloXXXXXXXXXX"
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    @IBAction func emailContactToDiscuss(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            
            
            let toDiscussEmailstring = selectedNasiGirl.emailOfContactWhoKnowsGirl
            let composeVC = MFMailComposeViewController()
            
            composeVC.mailComposeDelegate = self
            
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([toDiscussEmailstring])
           // composeVC.setSubject(subject)
            //composeVC.setMessageBody("XXXXXX", isHTML: false)
          
            self.present(composeVC, animated: true, completion: nil)
              }
    }
    
    @IBAction func callContactToRedd(_ sender: Any) {
        Utility.makeACall(selectedNasiGirl.cellNumberOfContactToReddShidduch)
      
    }
    
    @IBAction func textContactToRedd(_ sender: Any) {
        if !MFMessageComposeViewController.canSendText() {
            print("SMS services are not available")
        }
        
        
        let toReddTelString = selectedNasiGirl.cellNumberOfContactToReddShidduch
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
         
        // Configure the fields of the interface.
        composeVC.recipients = [toReddTelString]
        //composeVC.body = "HelloXXXXXXXXXX"
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    @IBAction func emailContactToRedd(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            
            
            let toDiscussEmailstring = selectedNasiGirl.emailOfContactToReddShidduch
            let composeVC = MFMailComposeViewController()
            
            composeVC.mailComposeDelegate = self
            
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([toDiscussEmailstring])
           // composeVC.setSubject(subject)
            //composeVC.setMessageBody("XXXXXX", isHTML: false)
          
            self.present(composeVC, animated: true, completion: nil)
              }
    }
    
    
    @IBAction func callTheGirl(_ sender: Any) {
        Utility.makeACall(selectedNasiGirl.girlsCellNumber)
    }
    
    @IBAction func textTheGirl(_ sender: Any) {
        if !MFMessageComposeViewController.canSendText() {
            print("SMS services are not available")
        }
        
        let girlTextString = selectedNasiGirl.girlsCellNumber
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
         
        // Configure the fields of the interface.
        composeVC.recipients = [girlTextString]
        //composeVC.body = "HelloXXXXXXXXXX"
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
        }
    
    @IBAction func emailTheGirl(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            
            
            let girlsEmailString = selectedNasiGirl.girlsEmailAddress
            let composeVC = MFMailComposeViewController()
            
            composeVC.mailComposeDelegate = self
            
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([girlsEmailString])
           // composeVC.setSubject(subject)
            //composeVC.setMessageBody("XXXXXX", isHTML: false)
          
            self.present(composeVC, animated: true, completion: nil)
              }

    }
    
}
extension ContactsViewController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
   
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        guard let mainView = navigationController?.parent?.view
            else { return }
          
        let hudView = HudView.hud(inView: view, animated: true)
          
        if result.rawValue == 0 {
          // it was cancelled
        }
        
        if result.rawValue == 1 {
            
        }
        
        if result.rawValue == 2 {
           // "It was sent"
            hudView.text = "Sent"
            
        }
        if result.rawValue == 3 {
            // it failed
            hudView.text = "ooops.. failed to send"
        }
        
        self.dismiss(animated: true, completion: nil)
        
        let delayInSeconds = 1.6
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds)
        {
        
        hudView.hide()
       
      }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                        didFinishWith result: MessageComposeResult) {
        
        guard let mainView = navigationController?.parent?.view
            else { return }
          
        let hudView = HudView.hud(inView: view, animated: true)
        
        // Check the result or perform other tasks.
        if result.rawValue == 0 {
            //it was cancelled
        }
        if result.rawValue == 1 {
            //it was sent
            hudView.text = "Sent"
        }
        if result.rawValue == 2 {
            //if failed
        }
        
        self.dismiss(animated: true, completion: nil)
        
        let delayInSeconds = 1.6
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds)
        {
        
        hudView.hide()
       
      }
        }
}
   
   

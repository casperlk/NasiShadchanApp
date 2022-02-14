//
//  AddEditBoyViewController.swift
//  NasiShadchanHelper
//
//  Created by test on 1/29/22.
//  Copyright © 2022 user. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class AddEditBoyViewController: UITableViewController {
    
    @IBOutlet weak var boysNameTextField: UITextField!
    @IBOutlet weak var boysCellTextField: UITextField!
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactCellTextField: UITextField!
   
    @IBOutlet weak var sendResumeCellTextField: UITextField!
    @IBOutlet weak var sendResumeEmailTextField: UITextField!
    @IBOutlet weak var boyProfileImageImageView: UIImageView!
    
    var selectedNasiBoy: NasiBoy!
    var selectedImage: UIImage!
    
    //var selectedImage: UIImage? {
    //    didSet {
            
    //        self.imageView.image = selectedImage
    //    }
   // }
    
    var  boyProfileImageURLString = ""
    var isEditingBoy = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedNasiBoy != nil {
            self.boyProfileImageURLString = selectedNasiBoy.boyProfileImageURLString
            isEditingBoy = true
            populateFields()
            populateBoyProfileImageView()
         }
    }
    
    func  populateFields() {
        boysNameTextField.text = selectedNasiBoy.boyFullName
        boysCellTextField.text = selectedNasiBoy.boyCell
        contactNameTextField.text = selectedNasiBoy.contactFullName
        contactCellTextField.text = selectedNasiBoy.contactCell
        sendResumeCellTextField.text = selectedNasiBoy.sendResumeText
        sendResumeEmailTextField.text = selectedNasiBoy.sendResumeEmail
        
    }
    
    func populateBoyProfileImageView() {
        if selectedNasiBoy.boyProfileImageURLString != ""{
            boyProfileImageImageView.loadImageUsingCacheWithUrlString(self.selectedNasiBoy.boyProfileImageURLString)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        saveBoyToFirebase()
    }
    
    func saveBoyToFirebase() {
        guard let mainView = navigationController?.parent?.view
            else { return }
          let hudView = HudView.hud(inView: mainView, animated: true)
          hudView.text = "Saved"
        
     
        if isEditingBoy == true {
            updateBoyInFirebase()
        } else {
            createNewBoyInFirebase()
        }
        
        let delayInSeconds = 0.6
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds)
        {
         hudView.hide()
          self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateBoyInFirebase() {
        let boyFullName = boysNameTextField.text ?? ""
        let boyCell = boysCellTextField.text ?? ""
        let contactFullName = contactNameTextField.text ?? ""
        let contactCell = contactCellTextField.text ?? ""
        let sendResumeText = sendResumeCellTextField.text ?? ""
        let sendResumeEmail = sendResumeEmailTextField.text ?? ""
        
        let creationDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM-dd-yyyy"//"hh:mm:ss a"
       
        let creationDateString = dateFormatter.string(from: creationDate)
        // get uid for current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let revisedBoy = NasiBoy(addedByShadchanUserID: uid, boyCell: boyCell, boyFullName: boyFullName, boyProfileImageURLString: self.boyProfileImageURLString, boyUID: "", contactCell: contactCell, contactFullName: contactFullName, dateCreated: creationDateString, dob: "", sendResumeEmail: sendResumeEmail, sendResumeText: sendResumeText)
        
        let dict = revisedBoy.toAnyObject()
        let ref = selectedNasiBoy.ref
        ref?.updateChildValues(dict as! [AnyHashable : Any])
    }
    
    func createNewBoyInFirebase() {
        let boyFullName = boysNameTextField.text ?? ""
        let boyCell = boysCellTextField.text ?? ""
        let contactFullName = contactNameTextField.text ?? ""
        let contactCell = contactCellTextField.text ?? ""
        let sendResumeText = sendResumeCellTextField.text ?? ""
        let sendResumeEmail = sendResumeEmailTextField.text ?? ""
        
        let creationDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM-dd-yyyy"//"hh:mm:ss a"
       
        let creationDateString = dateFormatter.string(from: creationDate)
        
        let newBoy = NasiBoy(addedByShadchanUserID: "", boyCell: boyCell, boyFullName: boyFullName, boyProfileImageURLString: self.boyProfileImageURLString, boyUID: "", contactCell: contactCell, contactFullName: contactFullName, dateCreated: creationDateString, dob: "", sendResumeEmail: sendResumeEmail, sendResumeText: sendResumeText)
        
        // get uid for current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
       print("the uid is \(uid)")
       let dateNodeRef = Database.database().reference().child("NasiBoysList").child(uid)
        let ref = dateNodeRef.childByAutoId()
        ref.setValue(newBoy.toAnyObject())
        
    }
    
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.section == 3 && indexPath.row == 0 {
        pickPhoto()
    } else if indexPath.section == 3 && indexPath.row == 0 {
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
    
}
extension AddEditBoyViewController:
UIImagePickerControllerDelegate,
  UINavigationControllerDelegate {
  
    // MARK: - Image Helper Methods
  func takePhotoWithCamera() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true, completion: nil)
}
    
    func choosePhotoFromLibrary() {
        
        let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Delegates
    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info:
    [UIImagePickerController.InfoKey: Any] ){
     let image = info[UIImagePickerController.InfoKey.editedImage] as?
    UIImage
      if let theImage = image {
        
          show(image: theImage)
          
          view.showLoadingIndicator()
          
          uploadImageAndGetURLAndSetInstanceVar(image: theImage)
        }
      dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(
      _ picker: UIImagePickerController
    ){
      dismiss(animated: true, completion: nil)
    }
    
    func pickPhoto() {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        showPhotoMenu()
      } else {
        choosePhotoFromLibrary()
      }
    }
    
    func showPhotoMenu() {
      let alert = UIAlertController(
        title: nil,
        message: nil,
        preferredStyle: .actionSheet)
      let actCancel = UIAlertAction(
        title: "Cancel",
        style: .cancel,
        handler: nil)
      alert.addAction(actCancel)
      let actPhoto = UIAlertAction(
        title: "Take Photo",
        style: .default,
        handler: nil)
      alert.addAction(actPhoto)
      let actLibrary = UIAlertAction(
        title: "Choose From Library",
        style: .default,
            handler: nil)
          alert.addAction(actLibrary)
          present(alert, animated: true, completion: nil)
    }
    
    func show(image: UIImage) {
        boyProfileImageImageView.image = image
        boyProfileImageImageView.isHidden = false
      //addPhotoLabel.text = ""
    }
    
    func uploadImageAndGetURLAndSetInstanceVar(image: UIImage) {
        
        print("upload image invoked - image state is \(image)")
        // convert image to jpeg data
        guard let uploadData = image.jpegData(compressionQuality: 0.1) else { return }
        
        let filename = NSUUID().uuidString
        print("the fileName is \(filename)")
        
        let storageRef = Storage.storage().reference().child("test_boy_profile_images").child(filename)
        
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err {
                
                print("Failed to upload post image:", err)
                return
            
            }
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    
                print("Failed to fetch downloadURL:", err)
                    return
                    
                }
                
                guard let imageUrl = downloadURL?.absoluteString else { return }
                
                print("Successfully uploaded post image:", imageUrl)
                
                // set the imageView.image Property
                self.boyProfileImageURLString = imageUrl
                
                self.show(image: image)
                self.view.hideLoadingIndicator()
                
            })
        }
    }
    
    // pass the url string
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        
    // get uid for current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // go to posts child node then to child uid
        let usersBoysListNode = Database.database().reference().child("NasiBoysList").child(uid)
        
        
        //let selectedBoyImageURLRef = usersBoysListNode.child("boyProfileImageURLString")
        /*
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageUrl": imageUrl,"imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                
                print("Failed to save post to DB", err)
                return
            }
            
            print("Successfully saved post to DB")
         */
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//}





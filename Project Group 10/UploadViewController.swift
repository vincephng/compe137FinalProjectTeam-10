//
//  UploadViewController.swift
//  Project Group 10
//
//  Created by Vince Nguyen on 11/21/18.
//  Copyright © 2018 Vince Nguyen. All rights reserved.
//

import UIKit
import Firebase
import Photos

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var foodImage: UIImageView!
    
   let imagePicker = UIImagePickerController()
    @IBAction func uploadImg(_ sender: Any) {
        checkPermission()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
        
    }
    override func viewDidLoad() {
        imagePicker.delegate = self
        super.viewDidLoad()
    }
    
@objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let chosenImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            foodImage.image = chosenImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
   
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
   

}

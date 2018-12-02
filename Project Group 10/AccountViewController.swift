//
//  AccountViewController.swift
//  Project Group 10
//
//  Created by Vince Nguyen on 11/15/18.
//  Copyright © 2018 Vince Nguyen. All rights reserved.
//

import UIKit
import Firebase
import Photos
import PhotosUI
import ObjectiveC

class CameraHandler: NSObject{
    static let shared = CameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}
extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imagePickedBlock?(image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}
class AccountViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    var dbRef = DatabaseReference()
    var stoRef = StorageReference()
    var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?

    
    
    @IBOutlet weak var image_usr: UIImageView!
    @IBOutlet weak var usrLable: UILabel!
    
    
    override func viewDidLoad() {
        image_usr.layer.cornerRadius = image_usr.frame.size.width/2
        image_usr.clipsToBounds = true
//        picker.delegate = self
        super.viewDidLoad()
        
        
    }
    
    @IBAction func uploadBtn(_ sender: Any) {
        checkPermission()
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image_usr.image
        }
        //setupProfile()
//        picker.delegate = self
//        picker.allowsEditing = true
//        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
//        present(picker, animated: true)

//not used
//            var selectImagefromPicker: UIImage?
//            if let editImage = info[UIImagePickerControllerEditedImage] as! UIImage{
//                selectImagefromPicker = editImage
//
//            }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
//                selectImagefromPicker = originalImage
//            };if let selectImage = selectImagefromPicker {
//                image_usr.image = selectImage
//            }
//            dismiss(animated: true, completion: nil)
//
//        }
       
//
   }
    

   
//@objc func image_picker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
//    {
//        defer {
//            picker.dismiss(animated: true)
//        }
//
//        print(info)
//        // get the image
//        guard let image = info[.originalImage] as? UIImage else
//        {
//            return
//        }
//
//        // do something with it
//        image_usr.image = image
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        defer {
//            picker.dismiss(animated: true)
//        }
//
//        print("did cancel")
//    }
//
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
//
//    func setupProfile(){
//
//        dbRef.child("users").observeSingleEvent(of: .value, with: {(snapshot) in
//            if let dict = snapshot.value as? [String: AnyObject]{
//                self.usrLable.text = dict["username"] as? String
//                if let profileImageURL = dict["pic"] as? String{
//                    let url = URL(string: profileImageURL)
//                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                        if error != nil{
//                            print(error!)
//                            return}
//                        DispatchQueue.main.async {
//                            self.image_usr?.image = UIImage(data: data!)
//                        }
//                    }).resume()
//                }
//
//            }
//        })
//        func chooseImage()
//        {
//
//            let imageName = NSUUID().uuidString
//            let storedImage = stoRef.child("profile_images").child(imageName)
//            if let uploadData = self.image_usr.image!.pngData()
//            {
//                storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
//                    if error != nil{
//                        print(error!)
//                        return
//                    }
//                    storedImage.downloadURL(completion: { (url, error) in
//                        if error != nil{
//                            print(error!)
//                            return
//                        }
//                        if let urlText = url?.absoluteString{
//                        self.dbRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["pic" :urlText], withCompletionBlock: { (error, ref) in
//                                if error != nil{
//                                    print(error!)
//                                    return
//                                }
//                            })
//                        }
//                    })
//                })
//            }
//        }
    


//  }

}



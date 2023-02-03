//
//  UploadViewController.swift
//  PostHub
//
//  Created by shoeb on 01/02/23.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image Useraction Enabled
        uploadImageView.isUserInteractionEnabled = true
        //Image Tab Function
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imagePickerFunc))
        uploadImageView.addGestureRecognizer(imageGesture)
        
    }
    
    @objc func imagePickerFunc(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //Upload Button Function
    @IBAction func uploadBTN(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil){ (metaData, error) in
                if error != nil {
                    self.makeAlertFunc(titleInput: "Error", messageInput: error!.localizedDescription)
                }else{
                    imageRef.downloadURL { (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            //Database Cloud FireStore
                            let fireStoreDB = Firestore.firestore()
                            var fireStoreRef : DocumentReference? = nil
                            let fireStorePost = ["imageUrl" : imageUrl!, "postBy" : Auth.auth().currentUser!.email!, "postTitle" : self.titleTextField.text!, "postDate" : FieldValue.serverTimestamp(), "like" : 0] as [String : Any]
                            fireStoreRef = fireStoreDB.collection("Posts").addDocument(data: fireStorePost, completion: { (error) in
                                if error != nil{
                                    self.makeAlertFunc(titleInput: "Error", messageInput: error!.localizedDescription)
                                }else{
                                    self.uploadImageView.image = UIImage(named: "defaultImage.jpeg")
                                    self.titleTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                    self.makeAlertFunc(titleInput: "Successful", messageInput: "Post Upload Successfully")
                }
            }
        }
    }
    
    func  makeAlertFunc(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okBTN)
        self.present(alert, animated: true, completion: nil)
    }
}

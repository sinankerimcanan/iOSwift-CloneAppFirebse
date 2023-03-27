//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Sinan on 24.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commetText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        imageView.isUserInteractionEnabled = true
        let imageTapRec = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRec)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data) { (metadata,error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            //DataBase
                            let firestoreDb = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePosts = ["imageUrl" : imageURL!,"postedBy" : Auth.auth().currentUser!.email!, "postsComment" : self.commetText.text!,"date" : FieldValue.serverTimestamp(),"likes" : 0] as [String : Any]
                            firestoreReference = firestoreDb.collection("Posts").addDocument(data: firestorePosts, completion: { error in
                                if error != nil{
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                                }else{
                                    self.commetText.text = ""
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
        }
        
    }
    func makeAlert(titleInput:String , messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        //Gorseli sectkten sonra mageView.image in icinde gozucek olan resmi imageview A atiyoruz
    }
}

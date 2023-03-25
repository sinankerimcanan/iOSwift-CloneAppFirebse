//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Sinan on 24.03.2023.
//

import UIKit

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

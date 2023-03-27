//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Sinan on 27.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class FeedCell: UITableViewCell {

    @IBOutlet weak var userEmailCell: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commetLabel: UILabel!
    @IBOutlet weak var docIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestoreDb = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!){
            
            let likePosts = ["likes" : likeCount + 1] as [String : Any]
            
            firestoreDb.collection("Posts").document(docIdLabel.text!).setData(likePosts, merge: true)
        }
        
        
        
        
    }
}

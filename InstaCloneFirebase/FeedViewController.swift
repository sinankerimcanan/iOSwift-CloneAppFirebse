//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Sinan on 24.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var docIdArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
    }
    func getDataFromFirebase(){
        let fireStoreDb = Firestore.firestore()
        fireStoreDb.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true{
                    self.userImageArray.removeAll()
                    self.userCommentArray.removeAll()
                    self.userImageArray.removeAll()
                    self.likeArray.removeAll()
                    self.docIdArray.removeAll()
                    for doc in snapshot!.documents{
                        let docID = doc.documentID
                        self.docIdArray.append(docID)
                        
                        
                        if let postedBy = doc.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                            
                        }
                        if let postsComment = doc.get("postsComment") as? String{
                            self.userCommentArray.append(postsComment)
                            
                        }
                        if let like = doc.get("likes") as? Int{
                            self.likeArray.append(like)
                            
                        }
                        if let image = doc.get("imageUrl") as? String{
                            self.userImageArray.append(image)
                            
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.userEmailCell.text = userEmailArray[indexPath.row]
        cell.commetLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        cell.docIdLabel.text = docIdArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
}

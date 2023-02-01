//
//  HomeViewController.swift
//  PostHub
//
//  Created by shoeb on 31/01/23.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var homeTableView: UITableView!
    var userEmailArray = [String]()
    var userTitleArray = [String]()
    var userlikeArray = [Int]()
    var userImageArray = [String]()
    var documentIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()
        getDataFromDatabase()
        
    }
    
    func getDataFromDatabase(){
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection("Posts").order(by: "postDate", descending: true).addSnapshotListener{ (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userTitleArray.removeAll(keepingCapacity: false)
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userlikeArray.removeAll(keepingCapacity: false)
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        if let postBy = document.get("postBy") as? String {
                            self.userEmailArray.append(postBy)
                        }
                        if let postTitle = document.get("postTitle") as? String {
                            self.userTitleArray.append(postTitle)
                        }
                        if let postUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(postUrl)
                        }
                        if let postLike = document.get("like") as? Int {
                            self.userlikeArray.append(postLike)
                        }
                    }
                    self.homeTableView.reloadData()
                }
            }
        }
    }
    
    func loadTableView(){
        homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeTableCell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        homeTableCell.emailLBL.text = userEmailArray[indexPath.row]
        homeTableCell.titleLBL.text = userTitleArray[indexPath.row]
        homeTableCell.postImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        homeTableCell.likeLBL.text = String(userlikeArray[indexPath.row])
        homeTableCell.dcumentIDLBL.text = documentIDArray[indexPath.row]
        return homeTableCell
    }
}

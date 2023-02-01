//
//  HomeTableViewCell.swift
//  PostHub
//
//  Created by shoeb on 01/02/23.
//

import UIKit
import Firebase

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeTabLBL: UILabel!
    @IBOutlet weak var likeLBL: UILabel!
    @IBOutlet weak var dcumentIDLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(likeTapFun))
        likeTabLBL.addGestureRecognizer(likeTapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func likeTapFun(){
        
        let fireStoreDB = Firestore.firestore()
        if let likeCount = Int(likeLBL.text!){
            let likeStore = ["like" : likeCount + 1] as [String : Any]
            fireStoreDB.collection("Posts").document(dcumentIDLBL.text!).setData(likeStore, merge: true)
        }
        
    }
    
}

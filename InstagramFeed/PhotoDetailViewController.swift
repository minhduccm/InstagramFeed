//
//  PhotoDetailViewController.swift
//  InstagramFeed
//
//  Created by Duc Dinh on 10/12/16.
//  Copyright © 2016 Duc Dinh. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoDetailViewController: UIViewController {
    
    var photoDetailUrl: String!
    var captionText: String!
    var usernameText: String!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoDetailImageView.setImageWith(URL(string: photoDetailUrl)!)
//        captionLabel.text = captionText
        usernameLabel.text = usernameText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  PhotosViewController.swift
//  InstagramFeed
//
//  Created by Duc Dinh on 10/12/16.
//  Copyright © 2016 Duc Dinh. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate {
    
    var photos = [NSDictionary]()
    
    @IBOutlet weak var photosTableView: UITableView!
    
    func refreshControlAction() {
        let accessToken = "435569061.c66ada7.d12d19c8687e427591f254586e4f3e47"
        let userId = "435569061"
        let url = URL(string: "https://api.instagram.com/v1/users/\(userId)/media/recent/?access_token=\(accessToken)")
        
        if let url = url {
            let request = URLRequest(
                url: url,
                cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                timeoutInterval: 10)
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: nil,
                delegateQueue: OperationQueue.main)
            let task = session.dataTask(
                with: request,
                completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            if let photoData = responseDictionary["data"] as? [NSDictionary] {
                                self.photos = photoData
                                self.photosTableView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        }
                    }
            })
            task.resume()
        }
    }

    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosTableView.delegate = self
        photosTableView.dataSource = self

        refreshControl.addTarget(self, action: #selector(PhotosViewController.refreshControlAction), for: UIControlEvents.valueChanged)
        refreshControlAction()
        
        photosTableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! PhotoDetailViewController
        
        let idx = photosTableView.indexPathForSelectedRow?.row
        
        nextVC.usernameText = (photos[idx!] as NSDictionary).value(forKeyPath: "user.username") as! String!
        //nextVC.captionText = (photos[idx!] as NSDictionary).value(forKeyPath: "caption") as! String!
        nextVC.photoDetailUrl = (photos[idx!] as NSDictionary).value(forKeyPath: "images.standard_resolution.url") as! String!
    }
}


extension PhotosViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoCellView
        
        let photo = photos[indexPath.row]
        let user = photo["user"] as! NSDictionary
        let image = photo["images"] as! NSDictionary
        let standardImage = image["low_resolution"] as! NSDictionary
        
        cell.userNameLabel.text = user["username"] as? String
        cell.avatarImageView.setImageWith(URL(string: (user["profile_picture"] as? String)!)!)
        cell.photoImageView.setImageWith(URL(string: (standardImage["url"] as? String)!)!)
        return cell
    }
}

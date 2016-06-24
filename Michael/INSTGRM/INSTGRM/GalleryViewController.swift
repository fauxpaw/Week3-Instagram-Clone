//
//  GalleryViewController.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/22/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post](){
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    class func id() -> String {
        return String(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        setupCollectionView()
    }
    
    func setupCollectionView(){
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GalleryViewController.pinchedCollectionView(_:)))
        self.collectionView.addGestureRecognizer(pinchGesture)
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    func pinchedCollectionView(sender: UIPinchGestureRecognizer){
        let layout = self.collectionView.collectionViewLayout as! GalleryCustomFlowLayout
        var columns = layout.columns
        
        if sender.state == .Ended {
            
            if sender.scale > 1.0 {
                columns += 1
            }
            else if sender.scale < 1.0 {
                if columns > 1{
                    columns -= 1
                }
            }
        }
        self.collectionView.setCollectionViewLayout(GalleryCustomFlowLayout(columns: columns), animated: true)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.GET { (posts) in
            if let posts = posts {
                self.posts = posts
                print(posts)
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
            print("cell created")
        
        cell.post = self.posts[indexPath.row]
        return cell
    }
}

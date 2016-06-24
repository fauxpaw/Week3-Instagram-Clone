//
//  ViewController.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/20/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

private var history = [UIImage]()


class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var post = Post()
    
    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
        
//        API.shared.GET { (posts) in
//            print(posts)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupAppearance(){
        //self.imageView.
        
    }
    
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType){
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func setup(){
        self.navigationItem.title = "INSTGRM"
    }
    
    func presentActionSheet(){
        
        let actionSheet = UIAlertController(title: "this my title", message: "this my message", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
        
        let photosAction = UIAlertAction(title: "photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    @IBAction func addButtonSelected(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        }
        else {
            self.presentImagePicker(.PhotoLibrary)
        }
        
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return}
        
        self.post = Post(image: image)
        API.shared.write(self.post) { (success) in
            if success {
                print("Pic sent")
            }
        }
    }
    
    @IBAction func filterButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        Filters.shared.original = image
        print(image)
        self.post = Post(image: image)
        
        self.performSegueWithIdentifier(FiltersPreviewViewController.id(), sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FiltersPreviewViewController.id() {
            guard let filtersPreviewViewController = segue.destinationViewController as? FiltersPreviewViewController else {return}
            filtersPreviewViewController.delegate = self
            filtersPreviewViewController.post = self.post
        }
    }
    
    func didFinishPickingImage(success: Bool, image: UIImage?) {
        if success {
            guard let image = image else {return}
            self.imageView.image = image
        } else {
            print("unsuccessful at retrieving image!")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        
        //clear filter history and add original image to stack
        history = []
        history.append(self.imageView.image!)
        print(history.count)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}



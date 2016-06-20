//
//  ViewController.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/20/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
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
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


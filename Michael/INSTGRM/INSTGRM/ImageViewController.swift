//
//  ViewController.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/20/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

private var history = [UIImage]()


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
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return}
        
        API.shared.write(Post(image: image)) { (success) in
            if success {
                print("Pic sent")
            } 
        }
    }
    
    @IBAction func filterButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Pleaes select a filter to modify your existing photo", preferredStyle: .ActionSheet)
        
        let bwAction = UIAlertAction(title: "Black and White", style: .Default) { (action) in
            
            Filters.bw(image) { (theImage) in
                self.imageView.image = theImage
                history.append(theImage!)
                print(history.count)

            }
        }
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            
            Filters.vintage(image, completion: { (theImage) in
                self.imageView.image = theImage
                history.append(theImage!)
                print(history.count)


            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) in
            
            Filters.chrome(image, completion: { (theImage) in
                self.imageView.image = theImage
                history.append(theImage!)
                print(history.count)


            })
        }
        
        let undoLast = UIAlertAction(title: "Undo Last", style: .Destructive) { (action) in
            print("lets undo")
            
            if history.count > 1 {
                history.removeLast()
                print(history.count)
                let last = history.last
                self.imageView.image = last
            }
            else {
                print("there is nothing to undo")
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(bwAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(undoLast)
        actionSheet.addAction(cancelAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
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



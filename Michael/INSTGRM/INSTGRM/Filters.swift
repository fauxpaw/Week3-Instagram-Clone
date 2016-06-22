//
//  Filters.swift
//  INSTGRM
//
//  Created by Michael Sweeney on 6/21/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit



class Filters {
    
    typealias FiltersCompletion = (theImage: UIImage?) -> ()
    
//    static var original = UIImage()
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion){
        
        NSOperationQueue().addOperationWithBlock{
            guard let filter = CIFilter(name: name) else { fatalError("Check yo spelling")}
    
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            guard let outputImage = filter.outputImage else {fatalError("Error creating output image")}
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    class func vintage(image: UIImage, completion: FiltersCompletion){
        
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
        //can we load a target for the undo action tab
    }
    
    class func bw(image: UIImage, completion: FiltersCompletion){
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletion){
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
}


